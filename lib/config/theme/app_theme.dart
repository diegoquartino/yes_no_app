import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF4B11A8);

const List<Color> _colorTheme = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
  Colors.black
];

class AppTheme {
  
  final int selectedColor;

  // Constructor
  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor <= _colorTheme.length - 1,
            'El color debe estar entre 0 y ${_colorTheme.length - 1}');

  // Funcion que devuelve un ThemeData que es lo que se usará
  // en la propiedad "theme:" del main en el widget "MaterialApp"
  ThemeData theme() {
    return ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: _colorTheme[selectedColor]
    );
    //, brightness: Brightness.dark);
  }
}
