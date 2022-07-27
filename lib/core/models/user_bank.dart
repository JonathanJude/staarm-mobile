class UserBankModel {
  int id;
  String bankName;
  String accountName;
  String accountNumber;

  UserBankModel({
    this.id,
    this.bankName,
    this.accountName,
    this.accountNumber,
  });

  factory UserBankModel.fromJson(Map<String, dynamic> json) => new UserBankModel(
    id: json["id"],
    bankName: json["bank_name"],
    accountName: json["account_name"],
    accountNumber: json["account_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_name": bankName,
    "account_name": accountName,
    "account_number": accountNumber,
  };
}
