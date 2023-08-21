class FootnoteModel {
  final int id;
  final String content;

  FootnoteModel({
    required this.id,
    required this.content,
  });

  factory FootnoteModel.fromMap(Map<String, dynamic> map) {
    return FootnoteModel(
      id: map['id'],
      content: map['footnote'],
    );
  }
}
