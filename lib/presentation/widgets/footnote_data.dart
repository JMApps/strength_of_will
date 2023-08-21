import 'package:flutter/material.dart';
import 'package:of_will/application/state/main_app_state.dart';
import 'package:of_will/application/styles/app_styles.dart';
import 'package:of_will/data/model/footnote_model.dart';
import 'package:of_will/presentation/widgets/footnote_container.dart';
import 'package:provider/provider.dart';

class FootnoteData extends StatelessWidget {
  const FootnoteData({super.key, required this.footnoteId});

  final int footnoteId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FootnoteModel>>(
      future: context.read<MainAppState>().getDatabaseQuery.getFootnote(footnoteId),
      builder: (BuildContext context, AsyncSnapshot<List<FootnoteModel>> snapshot) {
        if (snapshot.hasData) {
          final FootnoteModel model = snapshot.data![0];
          return FootnoteContainer(content: model.content);
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: AppStyles.mainPadding,
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(
                  fontSize: 18,
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
}
