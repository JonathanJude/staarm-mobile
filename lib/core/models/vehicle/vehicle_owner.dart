

class VehicleOwner {
  int id;
  dynamic dob;
  String email;
  dynamic about;
  bool approved;
  String lastName;
  String firstName;
  String profilePic;

  VehicleOwner({
    this.id,
    this.dob,
    this.email,
    this.about,
    this.approved,
    this.lastName,
    this.firstName,
    this.profilePic,
  });

  factory VehicleOwner.fromJson(Map<String, dynamic> json) {
    var x=  new VehicleOwner(
      id: json["id"] ?? 1,
      dob: json["dob"],
      email: json["email"],
      about: json["about"],
      approved: json["approved"],
      lastName: json["last_name"],
      firstName: json["first_name"],
      profilePic: json['profile_pic']
    );
    return x;
  }

  Map<String, dynamic> toJson() => {
        "dob": dob,
        "email": email,
        "about": about,
        "approved": approved,
        "last_name": lastName,
        "first_name": firstName,
      };
}
