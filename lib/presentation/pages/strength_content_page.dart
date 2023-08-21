import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:of_will/application/state/content_settings_state.dart';
import 'package:of_will/application/state/main_app_state.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/application/themes/app_theme.dart';
import 'package:of_will/data/model/strength_model.dart';
import 'package:of_will/presentation/widgets/footnote_data.dart';
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
    final ColorScheme appColors = Theme.of(context).colorScheme;
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
                          title: Text(model.chapterTitle),
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
                                    '${model.paragraph}\n\n${model.chapterTitle}\n\n${model.chapterContent}}',
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
                                  color: appColors.titleColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Html(
                            data: model.chapterContent,
                            style: {
                              '#': Style(
                                padding: HtmlPaddings.all(4),
                                fontSize: FontSize(settingsState.getTextSize),
                                fontFamily: AppStyles
                                    .getFont[settingsState.getFontIndex],
                                textAlign: AppStyles
                                    .getAlign[settingsState.getTextAlignIndex],
                                color: settingsState.getDarkTheme
                                    ? settingsState.getDarkTextColor
                                    : settingsState.getLightTextColor,
                              ),
                              'a': Style(
                                fontSize: FontSize(settingsState.getTextSize),
                                color: appColors.titleColor,
                                fontWeight: FontWeight.bold,
                              ),
                              'small': Style(
                                padding: HtmlPaddings.zero,
                                margin: Margins.zero,
                                fontSize: FontSize(14),
                              ),
                            },
                            onLinkTap: (String? content, _, __) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (_) => FootnoteData(
                                  footnoteId: int.parse(content!),
                                ),
                              );
                            },
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
