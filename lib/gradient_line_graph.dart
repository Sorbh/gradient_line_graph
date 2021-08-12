import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_line_graph/utils/extension.dart';

class GradientLineGraphView extends StatefulWidget {
  final double max;
  final double min;
  final double value;
  final double precentage;
  final Color color;
  final double lineThickness;
  final Duration duration;
  final ui.Gradient? gradient;

  GradientLineGraphView(
      {Key? key,
      required this.max,
      required this.min,
      required this.value,
      required this.precentage,
      this.color = Colors.blue,
      this.lineThickness = 2,
      this.duration = const Duration(milliseconds: 200),
      this.gradient})
      : super(key: key);

  @override
  _LineGraphViewState createState() => _LineGraphViewState();
}

class _LineGraphViewState extends State<GradientLineGraphView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double lastValue = 0;
  double lastProgress = 0;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: widget.duration);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      child: _LineGraphViewWidgetObject(
        state: this,
        value: _unlerpValue(widget.value),
        precentage: _unlerpPrecentage(widget.precentage),
      ),
    );
  }

  double _unlerpValue(double value) {
    assert(value <= widget.max);
    assert(value >= widget.min);
    return widget.max > widget.min
        ? (value - widget.min) / (widget.max - widget.min)
        : 0.0;
  }

  double _unlerpPrecentage(double value) {
    // assert(value <= 100);
    // assert(value >= 1);
    return (value) / (100);
  }

  // // Returns a number between min and max, proportional to value, which must
  // // be between 0.0 and 1.0.
  double? _lerp(double value) => ui.lerpDouble(widget.min, widget.max, value);
}

class _LineGraphViewWidgetObject extends LeafRenderObjectWidget {
  _LineGraphViewWidgetObject({
    required this.state,
    required this.value,
    required this.precentage,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _LineGraphViewRenderBox(
        state: state, value: value, precentage: precentage);
  }

  final _LineGraphViewState state;
  final double value;
  final double precentage;

  @override
  void updateRenderObject(
      BuildContext context, covariant _LineGraphViewRenderBox renderObject) {
    renderObject
      ..value = value
      ..precentage = precentage;
  }
}

class _LineGraphViewRenderBox extends RenderBox {
  //  Color(0xff96a8ff)
  //  Color(0xFF76cbd5)
  // final Color startColor;
  // final Color endColor;
  final _LineGraphViewState state;
  double _value;
  double _precentage;

  _LineGraphViewRenderBox(
      {required this.state, required double value, required double precentage})
      : _value = value,
        _precentage = precentage;

  double get value => _value;
  set value(double value) {
    assert(value != null); // same check as in the constructor
    if (value == _value) return;
    _value = value;

    if (state.animationController.isAnimating) {
      state.animationController.stop();
    }
    state.animationController.reset();
    state.animationController.forward();

    markNeedsLayout();
  }

  double get precentage => _precentage;
  set precentage(double value) {
    assert(value != null); // same check as in the constructor
    if (value == _precentage) return;
    _precentage = value;
    markNeedsLayout();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return Size(
      constraints.hasBoundedWidth ? constraints.maxWidth : 300,
      constraints.hasBoundedHeight ? constraints.maxHeight : 80,
    );
  }

  @override
  bool get sizedByParent => true;

  Path? path;
  @override
  void paint(PaintingContext context, Offset offset) {
    print('>>>>>>>>>>> $precentage   $value');
    //listen animaiton status
    if (state.animationController.status == AnimationStatus.completed ||
        state.animationController.status == AnimationStatus.dismissed) {
      state.lastValue = value;
      state.lastProgress = precentage;
    }

    Canvas canvas = context.canvas;

    canvas.translate(offset.dx, offset.dy);

    Rect rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height);

    // canvas.drawRect(rect, Paint()..color = Colors.amber);

    if (path == null) {
      path = Path();
      path?.moveTo(0, size.height);
    }

    Offset pointOffset = Offset(
        state.lastProgress * size.width +
            (precentage - state.lastProgress) *
                size.width *
                state.animationController.value,
        (1 - state.lastValue) * size.height +
            ((1 - value) - (1 - state.lastValue)) *
                size.height *
                state.animationController.value);

    path?.lineToOffset(pointOffset);

    // path.lineToOffset(Offset(size.width * precentage, size.height));

    canvas.drawCircle(pointOffset, 4, Paint()..color = state.widget.color);

    canvas.drawPath(
        path ?? Path(),
        Paint()
          ..color = state.widget.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = state.widget.lineThickness);

    //Draw path with gradinet
    Path closePathFormGradient = Path();

    closePathFormGradient.addPath(path ?? Path(), Offset.zero);

    closePathFormGradient.lineToOffset(Offset(pointOffset.dx, size.height));

    Rect closePathRect = closePathFormGradient.getBounds();

    canvas.drawPath(
      closePathFormGradient,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill
        ..shader = state.widget.gradient ??
            ui.Gradient.linear(
              Offset(closePathRect.left + closePathRect.width / 2,
                  closePathRect.top),
              Offset(closePathRect.left + closePathRect.width / 2,
                  closePathRect.bottom),
              [
                state.widget.color.withOpacity(.4),
                state.widget.color.withOpacity(.01)
              ],
              [0, 5],
            ),
    );
    // });
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    state.animationController.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    state.animationController.removeListener(markNeedsPaint);
    super.detach();
  }
}
