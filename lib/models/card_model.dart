CardModel unKnownCard =
    CardModel(tag: '1', imageUrl: 'assets/images/unKnown_Pokemon.jpg');

enum CardState {
  close,
  open,
}

class CardModel {
  String tag;
  String imageUrl;
  int index;
  CardState state;
  CardModel({this.tag, this.imageUrl, this.index}) {
    state = CardState.close;
  }

  String get getTag => tag;

  int get getIndex => index;
  set setIndexn(int other) => index = other;

  CardState get getState => state;
  set setState(CardState other) => state = other;

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      index: json["index"],
      tag: json["tag"],
      imageUrl: json["imageUrl"],
    );
  }
}
