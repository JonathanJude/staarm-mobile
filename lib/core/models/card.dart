class CardModel {
  int id;
  String name;
  String last4;
  String first6;
  String expYear;
  String expMonth;
  String cardType;

  CardModel({
    this.id,
    this.name,
    this.last4,
    this.first6,
    this.expYear,
    this.expMonth,
    this.cardType,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => new CardModel(
    id: json["id"],
    name: json["name"],
    last4: json["last4"],
    first6: json["first6"],
    expYear: json["exp_year"],
    expMonth: json["exp_month"],
    cardType: json["card_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "last4": last4,
    "first6": first6,
    "exp_year": expYear,
    "exp_month": expMonth,
    "card_type": cardType,
  };
}
