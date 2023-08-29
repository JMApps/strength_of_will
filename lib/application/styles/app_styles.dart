import 'package:flutter/material.dart';

class AppStyles {
  static const EdgeInsets mainPadding = EdgeInsets.all(16);
  static const EdgeInsets mainPaddingMini = EdgeInsets.all(8);
  static const EdgeInsets mainPaddingHorizontal = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets mainPaddingHorizontalMini = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets mainPaddingVertical = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets mainPaddingVerticalMini = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets mainMargin = EdgeInsets.all(16);
  static const EdgeInsets mainMarginMini = EdgeInsets.all(8);

  static const RoundedRectangleBorder mainShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(25),
    ),
  );

  static const BorderRadius mainBorderRadius = BorderRadius.all(
    Radius.circular(25),
  );

  static const List<String> getFont = [
    'Gilroy',
    'Montserrat',
    'Nexa',
  ];

  static const List<TextAlign> getAlign = [
    TextAlign.left,
    TextAlign.center,
    TextAlign.right,
    TextAlign.justify,
  ];
}
