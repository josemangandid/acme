import 'package:acme/app/core/values/colors.dart';
import 'package:flutter/material.dart';

ThemeData theme(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme.apply(
        bodyColor: MyColors.principal,
        displayColor: MyColors.textoClaro,
      );

  final ThemeData theme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: MyColors.verde!),
      contentPadding: const EdgeInsets.all(10.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.principal!),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: MyColors.verde!, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: MyColors.error!,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: MyColors.error!,
        ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: MyColors.verde!,
    ),
    textTheme: textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    primaryColor: MyColors.fondo,
  );
  return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(secondary: MyColors.principal));
}
