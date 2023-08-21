import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_will/application/state/main_app_state.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/application/themes/app_theme.dart';
import 'package:of_will/data/arguments/strength_arguments.dart';
import 'package:of_will/data/model/strength_model.dart';
import 'package:provider/provider.dart';

class StrengthItem extends StatelessWidget {
  const StrengthItem({
    super.key,
    required this.model,
    required this.index,
  });

  final StrengthModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme appColors = Theme.of(context).colorScheme;
    final MainAppState mainAppState = Provider.of<MainAppState>(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () {
          mainAppState.saveLastParagraph = model.id;
          Navigator.pushNamed(
            context,
            '/strength_content',
            arguments: StrengthArguments(
              paragraphId: model.id,
            ),
          );
        },
        contentPadding: AppStyles.mainPaddingMini,
        visualDensity: const VisualDensity(horizontal: -4),
        title: Text(
          model.paragraph,
          style: TextStyle(
            color: appColors.titleColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
          ),
        ),
        subtitle: Text(
          model.chapterTitle,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            mainAppState.addRemoveBookmark(model.favoriteState == 0 ? 1 : 0, model.id);
          },
          icon: Icon(
            model.favoriteState == 1
                ? CupertinoIcons.bookmark_solid
                : CupertinoIcons.bookmark,
            color: appColors.titleColor,
          ),
        ),
      ),
    );
  }
}
