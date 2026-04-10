import 'package:flutter/material.dart';

class AppTheme {
  static const Color lightPrimaryColor = Color.fromRGBO(255, 50, 113, 1);
  static const Color lightSecondaryColor = Color.fromRGBO(48, 127, 226, 1);
  static const Color lightThreeColor = Color.fromRGBO(38, 79, 112, 1);
  static const Color lightFourColor = Color.fromRGBO(153, 219, 255, 1.0);
  static const Color lightFiveColor = Color.fromRGBO(253, 215, 87, 1.0);
  static const Color lightSixColor = Color.fromRGBO(255, 246, 231, 1.0);


  static ThemeData getTheme({bool darkMode = false}) {
    return lightTheme();
  }

  static ThemeData lightTheme() {
    const ColorScheme colorScheme = ColorScheme.light(
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      // MaterialColor
      // surfaceTint: Colors.transparent
    );

    return ThemeData(
      brightness: Brightness.light,
      // fontFamily: 'Vogue',
      primaryColor: lightPrimaryColor,
      textTheme: Typography().black.apply(
          fontFamily: 'Vogue'
      ),
      colorScheme: const ColorScheme.light(
        primary: lightPrimaryColor,
        secondary: lightSecondaryColor,
        onSurface: Colors.red,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: lightThreeColor,
        selectionColor: lightThreeColor,
        selectionHandleColor: lightThreeColor,
      ),
      scaffoldBackgroundColor: lightPrimaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        labelStyle: TextStyle(
          fontFamily: 'Vogue Bold',
        ),
        unselectedLabelColor: lightThreeColor,
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Vogue Bold',
        ),
      ),
      dialogBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        hintStyle: const TextStyle(
          color: lightThreeColor,
        ),
        floatingLabelStyle: const TextStyle(
          color: lightThreeColor,
          fontSize: 18,
        ),
        labelStyle: const TextStyle(
          color: lightThreeColor,
          fontSize: 18,
        ),
        errorStyle: const TextStyle(
          color: Colors.white,
        ),
        focusColor: Colors.blue,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      buttonTheme: const ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightSecondaryColor,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontFamily: 'Vogue Bold',
          ),
          side: const BorderSide(
            color: Colors.white,
            width: 2.5,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        extendedTextStyle: TextStyle(
          fontFamily: 'Vogue Bold',
        ),
      ),
      dividerTheme: const DividerThemeData(
        thickness: 1,
        color: lightPrimaryColor,
      ),
    );
  }

}
