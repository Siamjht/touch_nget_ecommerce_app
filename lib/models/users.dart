

class Users{
  late String userId;
  late String userName;
  String? userEmail;
  num? userMobile;
  late String userImage;

  Users({
    required this.userId, required this.userName, required this.userImage});

  Users.me({required this.userId, required this.userName, this.userEmail, this.userMobile, required this.userImage});
}