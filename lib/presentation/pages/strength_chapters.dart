import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_will/application/state/main_app_state.dart';
import 'package:of_will/application/strings/app_strings.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/application/themes/app_theme.dart';
import 'package:of_will/data/arguments/strength_arguments.dart';
import 'package:of_will/data/model/strength_model.dart';
import 'package:of_will/presentation/items/strength_item.dart';
import 'package:of_will/presentation/items/strength_item_tablet.dart';
import 'package:of_will/presentation/widgets/search_strength_delegate.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StrengthChapters extends StatefulWidget {
  const StrengthChapters({Key? key}) : super(key: key);

  @override
  State<StrengthChapters> createState() => _StrengthChaptersState();
}

class _StrengthChaptersState extends State<StrengthChapters> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchStrengthDelegate(
                  hintText: AppStrings.searchQuestions,
                ),
              );
            },
            tooltip: AppStrings.searchQuestions,
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      ),
      body: FutureBuilder<List<StrengthModel>>(
        future: mainAppState.getDatabaseQuery.getAllParagraphs(),
        builder:
            (BuildContext context, AsyncSnapshot<List<StrengthModel>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CupertinoScrollbar(
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      padding: AppStyles.mainPaddingMini,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ScreenTypeLayout.builder(
                          mobile: (BuildContext context) => StrengthItem(
                            model: snapshot.data![index],
                            index: index,
                          ),
                          tablet: (BuildContext context) => StrengthItemTablet(
                            model: snapshot.data![index],
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: mainAppState.getLastParagraph > 0 ? true : false,
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppStyles.mainBorderRadius,
                      side: BorderSide(
                        width: 1,
                        color: appColors.titleColor,
                      ),
                    ),
                    child: ScreenTypeLayout.builder(
                      mobile: (BuildContext context) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/strength_content',
                            arguments: StrengthArguments(
                              paragraphId: mainAppState.getLastParagraph,
                            ),
                          );
                        },
                        borderRadius: AppStyles.mainBorderRadius,
                        child: Padding(
                          padding: AppStyles.mainPaddingMini,
                          child: Text(
                            '${AppStrings.lastHead} ${mainAppState.getLastParagraph} ${AppStrings.head}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      tablet: (BuildContext context) => InkWell(
                        onTap: () {
                          mainAppState.changeParagraphId = mainAppState.getLastParagraph;
                        },
                        borderRadius: AppStyles.mainBorderRadius,
                        child: Padding(
                          padding: AppStyles.mainPaddingMini,
                          child: Text(
                            '${AppStrings.lastHead} ${mainAppState.getLastParagraph} ${AppStrings.head}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: AppStyles.mainPadding,
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
