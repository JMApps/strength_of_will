import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:of_will/application/styles/app_styles.dart';

class FootnoteContainer extends StatelessWidget {
  const FootnoteContainer({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: AppStyles.mainMargin,
      child: SingleChildScrollView(
        padding: AppStyles.mainPadding,
        child: SelectableRegion(
          focusNode: FocusNode(),
          selectionControls: Platform.isIOS
              ? CupertinoTextSelectionControls()
              : MaterialTextSelectionControls(),
          child: Html(
            data: content,
            style: {
              '#': Style(
                padding: HtmlPaddings.zero,
                margin: Margins.zero,
                fontSize: FontSize(18),
                textAlign: TextAlign.center,
              ),
              'small': Style(
                padding: HtmlPaddings.zero,
                margin: Margins.zero,
                fontSize: FontSize(14),
              ),
            },
          ),
        ),
      ),
    );
  }
}
