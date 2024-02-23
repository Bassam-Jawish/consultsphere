import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final String? imgUrl;
  final String? gender;
  final bool? isOnline;
  final String? userProfileType;

  const UserEntity(
      {this.userId,
      this.name,
      this.email,
      this.phoneNumber,
      this.role,
      this.imgUrl,
      this.gender,
      this.isOnline,
      this.userProfileType});

  @override
  List<Object?> get props =>
      [userId, name, email, phoneNumber, role, imgUrl, gender, isOnline, userProfileType];
}
