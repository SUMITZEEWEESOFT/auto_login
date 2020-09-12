class User {
  String eml;
  String pas;

  User();

  User.fromJson(Map<String, dynamic> json)
      : eml = json['eml'],
        pas = json['pas'];

  Map<String, dynamic> toJson() => {
    "eml": eml,
    "pas": pas,
  };

}
