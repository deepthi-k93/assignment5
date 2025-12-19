class UserModel {
  final String userName;
  final String userEmail;
  final String password;
  // final double price;

  UserModel({
    required this.userName,
    required this.userEmail,
    required this.password,
    // required this.price,
  });
  Map<String, dynamic> toJson() => {
    'userName': userName,
    'userEmail': userEmail,
    'password': password,
  };

  // Create a User object from a Map
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json['userName'],
    userEmail: json['userEmail'],
    password: json['password'],
  );
}
