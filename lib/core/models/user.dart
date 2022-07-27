class UserModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String dob;
  dynamic about;
  String profilePic;
  dynamic emailVerifiedAt;
  int id;
  bool approved;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.dob,
    this.about,
    this.profilePic,
    this.id,
    this.emailVerifiedAt,
    this.approved = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => new UserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        dob: json["dob"] ?? '',
        about: json["about"],
        profilePic: json["profile_pic"],
        id: json["id"],
        emailVerifiedAt: json["email_verified_at"],
        approved: json["approved"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "about": about,
        "profile_pic": profilePic,
        "id": id,
        "email_verified_at": emailVerifiedAt,
        "approved": approved,
      };
}
