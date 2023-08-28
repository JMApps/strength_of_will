import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/application/themes/app_theme.dart';
import 'package:of_will/presentation/widgets/footnote_data.dart';

class ForHtmlText extends StatelessWidget {
  const ForHtmlText({
    super.key,
    required this.textContent,
    required this.textSize,
    required this.textAlignIndex,
    required this.textFontIndex,
    required this.textLightColor,
    required this.textDarkColor,
  });

  final String textContent;
  final double textSize;
  final int textFontIndex;
  final int textAlignIndex;
  final Color textLightColor;
  final Color textDarkColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Html(
      data: textContent,
      style: {
        '#': Style(
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
          fontSize: FontSize(textSize),
          fontFamily: AppStyles.getFont[textFontIndex],
          textAlign: AppStyles.getAlign[textAlignIndex],
          color: appTheme.brightness == Brightness.light
              ? textLightColor
              : textDarkColor,
        ),
        'a': Style(
          fontSize: FontSize(textSize - 3),
          color: appTheme.colorScheme.titleColor,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.bold,
        ),
        'small': Style(
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
          fontSize: FontSize(14),
        ),
      },
      onLinkTap: (String? footnoteId, _, __) {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => FootnoteData(
            footnoteId: int.parse(
              footnoteId!,
            ),
          ),
        );
      },
    );
  }
}
