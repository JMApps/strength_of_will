import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_will/application/state/main_app_state.dart';
import 'package:of_will/application/strings/app_strings.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/data/model/strength_model.dart';
import 'package:of_will/presentation/items/strength_item.dart';
import 'package:of_will/presentation/items/strength_item_tablet.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StrengthFavorites extends StatefulWidget {
  const StrengthFavorites({super.key});

  @override
  State<StrengthFavorites> createState() => _StrengthFavoritesState();
}

class _StrengthFavoritesState extends State<StrengthFavorites> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookmarks),
      ),
      body: FutureBuilder<List<StrengthModel>>(
        future: context.watch<MainAppState>().getDatabaseQuery.getFavoriteParagraphs(favorites: mainAppState.getFavoriteParagraphs),
        builder: (BuildContext context, AsyncSnapshot<List<StrengthModel>> snapshot) {
          if (snapshot.hasData) {
            return CupertinoScrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
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
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Padding(
                padding: AppStyles.mainPadding,
                child: Text(
                  AppStrings.bookmarksIsEmpty,
                  style: TextStyle(
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
      ),
    );
  }
}
