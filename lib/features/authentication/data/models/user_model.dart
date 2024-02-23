
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';

class UserModel extends UserEntity{

  const UserModel({
    String? userId,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    String? imgUrl,
    String? gender,
    bool? isOnline,
    String? userProfileType,
  }) : super(
    userId: userId,
    name: name,
    email: email,
    phoneNumber: phoneNumber,
    role: role,
    imgUrl: imgUrl,
    gender: gender,
    isOnline: isOnline,
      userProfileType : userProfileType,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      userId: snap['userId'] ?? "",
      name: snap['name'] ?? "",
      email: snap['email'] ?? "",
      phoneNumber: snap['phoneNumber'] ?? "",
      role: snap['role'] ?? "",
      imgUrl: snap['imgUrl'] ?? "",
      gender: snap['gender'] ?? "",
      isOnline: snap['isOnline'] ?? "",
      userProfileType: snap['userProfileType'] ?? "",
    );
  }

  Map<String, dynamic> toDocument() => {
    "userId": userId,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "role": role,
    "imgUrl": imgUrl,
    "gender": gender,
    "isOnline": isOnline,
    "userProfileType": userProfileType,
  };

}
