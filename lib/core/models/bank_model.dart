class BankModel {
  int bankId;
  String bankName;

  BankModel({
    this.bankId,
    this.bankName,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => new BankModel(
    bankId: json["bank_id"],
    bankName: json["bank_name"],
  );

  Map<String, dynamic> toJson() => {
    "bank_id": bankId,
    "bank_name": bankName,
  };
}
