
# Gradient Line Graph
GradientLineGraphWidget is a simple and customizable animated connecting button widget [GradientLineGraphWidget](https://github.com/Sorbh/gradient_line_graph)

The source code is **100% Dart**.

[![pub package](https://img.shields.io/pub/v/kdgaugeview.svg?style=flat-square)](https://pub.dartlang.org/packages/GradientLineGraphWidget)  ![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg?style=flat-square)


# Motivation

I need some animated graph in my Flutter application.

# Getting started

## Installing
Add this to your package's pubspec.yaml file:

This library is posted in pub.dev

#### pubspec.yaml
```dart
dependencies:  
	gradient_line_graph: ^1.0.0
```

# Usage

After Importing this library, you can directly use this view in your Widget tree

```dart
import 'package:gradient_line_graph/gradient_line_graph.dart';
```


```dart
GradientLineGraphView(
                min: 0,
                max: 100,
                value: downloadRate,
                precentage: downloadProgress,
                color: Color(0xFF4cbdbb).withOpacity(0.7),
                duration: Duration(milliseconds: 0),
              )
  ```

# Customization
  Depending on your view you may want to tweak the UI. For now you can these custom attributes

  | Property | Type | Description |
  |----------|------|-------------|
  | 'min' | double | Minimum value to start graph line from |
  | 'max' | double | Maximum value (End point of graph line) |
  | 'value' | double | Value of the line points |
  | 'percentage' | double | Line graph progress percentage |
  | 'color' | Color | Color of the line in line graph |
  | 'duration' | double | Duration of the animation |
  | 'gradient' | double | Gradiant below the line in line graph |
  | 'lineThickness' | double | Thickmedd of the line in line graph |




# Screenshots
![Screenshot 2021-08-13 at 10 37 36 AM](https://user-images.githubusercontent.com/14270768/129310466-d4524053-3a7c-4329-a43d-2815d6fc6a60.png)

![Screen Recording 2021-08-13 at 11 19 31 AM](https://user-images.githubusercontent.com/14270768/129311544-ca7881a3-100e-4556-af57-d0de95332125.gif)










# Author
  * **Saurabh K Sharma - [GIT](https://github.com/Sorbh)**
  
      I am very new to open source community. All suggestion and improvement are most welcomed. 
      

### Contributors

<table>
<tr>
    <td align="center" style="word-wrap: break-word; width: 150.0; height: 150.0">
        <a href=https://github.com/Sorbh>
            <img src=https://avatars.githubusercontent.com/u/8159377?v=4 width="100;"  style="border-radius:50%;align-items:center;justify-content:center;overflow:hidden;padding-top:10px" alt=Sorabh/>
            <br />
            <sub style="font-size:14px"><b>Sorabh</b></sub>
        </a>
    </td>
    <td align="center" style="word-wrap: break-word; width: 150.0; height: 150.0">
        <a href=https://github.com/RohitKumarMishra>
            <img src=https://avatars.githubusercontent.com/u/14270768?v=4 width="100;"  style="border-radius:50%;align-items:center;justify-content:center;overflow:hidden;padding-top:10px" alt=Rohit Kumar Mishra/>
            <br />
            <sub style="font-size:14px"><b>Rohit Kumar Mishra</b></sub>
        </a>
    </td>
</tr>
</table>
 
 
## Contributing

1. Fork it (<https://github.com/sorbh/gradient_line_graph/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

