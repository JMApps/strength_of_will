import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:of_will/application/state/content_settings_state.dart';
import 'package:of_will/application/state/main_app_state.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/application/themes/app_theme.dart';
import 'package:of_will/data/model/strength_model.dart';
import 'package:of_will/presentation/widgets/for_html_text.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class StrengthContentPage extends StatelessWidget {
  const StrengthContentPage({
    super.key,
    required this.paragraphId,
  });

  final int paragraphId;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return FutureBuilder<List<StrengthModel>>(
      future: context
          .read<MainAppState>()
          .getDatabaseQuery
          .getChapterContent(paragraphId),
      builder:
          (BuildContext context, AsyncSnapshot<List<StrengthModel>> snapshot) {
        if (snapshot.hasData) {
          final StrengthModel model = snapshot.data![0];
          return Consumer<ContentSettingsState>(
            builder: (context, settingsState, _) {
              return Scaffold(
                body: SelectableRegion(
                  focusNode: FocusNode(),
                  selectionControls: Platform.isIOS
                      ? CupertinoTextSelectionControls()
                      : MaterialTextSelectionControls(),
                  child: CupertinoScrollbar(
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          title: Text(model.paragraph),
                          floating: true,
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/app_settings');
                              },
                              icon: const Icon(CupertinoIcons.settings),
                            ),
                            IconButton(
                              onPressed: () {
                                Share.share(
                                  _parseHtmlText(
                                    '${model.paragraph}\n\n${model.chapterTitle}\n\n${model.chapterContent}${model.footnotesChapter != null ? '\n\n${model.footnotesChapter}' : ''}',
                                  ),
                                  sharePositionOrigin:
                                      const Rect.fromLTWH(0, 0, 10, 10 / 2),
                                );
                              },
                              icon: const Icon(CupertinoIcons.share),
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: Card(
                            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            shape: AppStyles.mainShape,
                            child: Padding(
                              padding: AppStyles.mainPadding,
                              child: Text(
                                model.chapterTitle,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: appTheme.colorScheme.titleColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: AppStyles.mainPadding,
                            child: ForHtmlText(
                              textContent: model.chapterContent,
                              textSize: settingsState.getTextSize,
                              textFontIndex: settingsState.getFontIndex,
                              textAlignIndex: settingsState.getTextAlignIndex,
                              textLightColor: settingsState.getLightTextColor,
                              textDarkColor: settingsState.getDarkTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: AppStyles.mainPadding,
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  String _parseHtmlText(String htmlText) {
    final documentText = parse(htmlText);
    final String parsedString =
        parse(documentText.body!.text).documentElement!.text;
    return parsedString;
  }
}
