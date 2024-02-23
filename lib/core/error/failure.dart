import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return const ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return const ServerFailure('badCertificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response!.statusCode!, e.response!.data);
      case DioExceptionType.cancel:
        return const ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return const ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return const ServerFailure('Ops There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return const ServerFailure(
          'Your request was not found, please try later');
    } else if (statusCode == 500) {
      return const ServerFailure(
          'There is a problem with server, please try later');
    } else if (statusCode == 400 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 422) {
      return ServerFailure(response['message']);
    } else {
      return const ServerFailure('There was an error , please try again');
    }
  }

  @override
  String toString() {
    return 'ServerFailure{errorMessage: $message}';
  }
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);

  @override
  String toString() {
    return 'ConnectionFailure{errorMessage: $message}';
  }
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(String message) : super(message);

  factory FirebaseFailure.fromFirebaseException(FirebaseException e) {
    switch (e.code) {
      case 'invalid-email':
        return const FirebaseFailure('The email address entered is not valid');
      case 'invalid-verification-code':
        return const FirebaseFailure('Invalid Verification Code');
      case 'quota-exceeded':
        return const FirebaseFailure('SMS quota-exceeded');
      case 'wrong-password':
        return const FirebaseFailure('The password provided is incorrect');
      case 'user-disabled':
        return const FirebaseFailure('Your account has been disabled');
      case 'user-not-found':
        return const FirebaseFailure(
            'No account found with the provided email address');
      case 'email-already-in-use':
        return const FirebaseFailure(
            'An account with this email address already exists');
      case 'operation-not-allowed':
        return const FirebaseFailure(
            'Email/password accounts are currently not enabled');
      case 'weak-password':
        return const FirebaseFailure('The password is not strong enough');
      case 'expired-action-code':
        return const FirebaseFailure('The OTP in the email link has expired');
      case 'account-exists-with-different-credential':
        return const FirebaseFailure(
            'An account with this email address already exists');
      case 'invalid-credential':
        return const FirebaseFailure(
            'The provided credential is malformed or has expired');
      case 'user-mismatch':
        return const FirebaseFailure(
            'The provided credential does not correspond to the user');
      case 'permission-denied':
        return const FirebaseFailure(
            'Permission denied');
      default:
        return const FirebaseFailure('There was an Error, Please try again');
    }
  }
}
