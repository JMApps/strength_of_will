import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:of_will/application/state/main_app_state.dart';
import 'package:of_will/application/strings/app_strings.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/application/themes/app_theme.dart';
import 'package:of_will/data/model/strength_model.dart';
import 'package:of_will/presentation/widgets/for_html_text.dart';
import 'package:provider/provider.dart';

class StrengthItemTablet extends StatelessWidget {
  const StrengthItemTablet({
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
    final bool isBookmark = mainAppState.supplicationIsFavorite(model.id);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () {
          mainAppState.saveLastParagraph = model.id;
          mainAppState.changeParagraphId = model.id;
        },
        contentPadding: AppStyles.mainPaddingMini,
        visualDensity: const VisualDensity(horizontal: -4),
        title: Text(
          model.paragraph,
          style: TextStyle(
            color: appColors.titleColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gilroy',
          ),
        ),
        subtitle: ForHtmlText(
          textContent: model.chapterTitle,
          textSize: 22,
          textFontIndex: 0,
          textAlignIndex: 0,
          textLightColor: Colors.grey.shade800,
          textDarkColor: Colors.grey.shade50,
        ),
        leading: IconButton(
          onPressed: () {
            mainAppState.toggleFavorite(model.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: appColors.titleColor,
                duration: const Duration(milliseconds: 350),
                content: Text(
                  isBookmark ? AppStrings.removed : AppStrings.added,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          icon: Icon(
            isBookmark
                ? CupertinoIcons.bookmark_solid
                : CupertinoIcons.bookmark,
            color: appColors.titleColor,
          ),
        ),
      ),
    );
  }
}
