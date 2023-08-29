import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_will/application/state/content_settings_state.dart';
import 'package:of_will/application/strings/app_strings.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/application/themes/app_theme.dart';
import 'package:provider/provider.dart';

class FootnoteContainer extends StatelessWidget {
  const FootnoteContainer({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final ContentSettingsState settings = Provider.of<ContentSettingsState>(context);
    return Card(
      margin: AppStyles.mainMargin,
      child: SingleChildScrollView(
        padding: AppStyles.mainPadding,
        child: Column(
          children: [
            SelectableRegion(
              focusNode: FocusNode(),
              selectionControls: Platform.isIOS
                  ? CupertinoTextSelectionControls()
                  : MaterialTextSelectionControls(),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: settings.getTextSize,
                  color: appTheme.brightness == Brightness.light
                      ? settings.getLightTextColor
                      : settings.getDarkTextColor,
                  fontFamily: AppStyles.getFont[settings.getFontIndex],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              shape: AppStyles.mainShape,
              child: Text(
                AppStrings.close,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold,
                  color: appTheme.colorScheme.titleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
