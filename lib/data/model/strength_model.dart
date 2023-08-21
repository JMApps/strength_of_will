class StrengthModel {
  final int id;
  final String paragraph;
  final String chapterTitle;
  final String chapterContent;
  final int favoriteState;

  StrengthModel({
    required this.id,
    required this.paragraph,
    required this.chapterTitle,
    required this.chapterContent,
    required this.favoriteState,
  });

  factory StrengthModel.fromMap(Map<String, dynamic> map) {
    return StrengthModel(
      id: map['id'],
      paragraph: map['paragraph'],
      chapterTitle: map['chapter_title'],
      chapterContent: map['chapter_content'],
      favoriteState: map['favorite_state'],
    );
  }
}
