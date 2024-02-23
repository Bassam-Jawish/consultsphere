import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultsphere/core/utils/firebase_collections.dart';
import 'package:consultsphere/features/authentication/data/data_sources/remote/auth_remote_service.dart';
import 'package:consultsphere/features/authentication/data/models/user_model.dart';
import 'package:consultsphere/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRemoteServiceImpl implements AuthRemoteService {
  final FirebaseFirestore fireStore;
  final FirebaseAuth auth;

  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookSignIn;

  AuthRemoteServiceImpl({
    required this.fireStore,
    required this.auth,
    required this.googleSignIn,
    required this.facebookSignIn,
  });

  String _verificationId = "";

  @override
  Future<UserCredential> register(
    String name,
    String gender,
    String email,
    String phoneNumber,
    String password,
  ) async {
    userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    sendEmailVerification();

    await createNewUser(name, email, phoneNumber, '', gender, 'email')
        .catchError((e) {
      throw FirebaseException(
        plugin: '',
        code: 'permission-denied',
        message: 'Permission denied',
      );
    });

    return userCredential!;
  }

  @override
  Future<UserCredential> login(String email, String password) async {
    userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential!;
  }

  @override
  Future<void> sendEmailVerification() async {
    return await userCredential!.user!.sendEmailVerification();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    return await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw FirebaseException(
        plugin: '',
        code: 'google-sign-in-error',
        message: 'Google Sign In Error: User is null',
      );
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    userCredential = await auth.signInWithCredential(credential);

    await createNewUser(googleUser.displayName ?? '', googleUser.email, '',
        googleUser.photoUrl ?? '', 'male', 'google')
        .catchError((e) {
      throw FirebaseException(
        plugin: '',
        code: 'permission-denied',
        message: 'Permission denied',
      );
    });

    return userCredential!;
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    final facebookUser =
        await facebookSignIn.login(permissions: ['email', 'public_profile']);
    if (facebookUser == null) {
      throw FirebaseException(
        plugin: '',
        code: 'facebook-sign-in-error',
        message: 'Facebook Sign In Error: User is null',
      );
    }

    final OAuthCredential credential = FacebookAuthProvider.credential(
      facebookUser.accessToken!.token,
    );
    userCredential = await auth.signInWithCredential(credential);

    final facebookUserData = await facebookSignIn.getUserData();

    await createNewUser(
        facebookUserData['name'] ?? '',
        facebookUserData['email'] ?? '',
        '',
        facebookUserData['picture']['data']['url'] ?? '',
        'male',
        "facebook")
        .catchError((e) {
      throw FirebaseException(
        plugin: '',
        code: 'permission-denied',
        message: 'Permission denied',
      );
    });

    return userCredential!;
  }

  @override
  Future<UserCredential> signInWithApple() async {
    final appleUser = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: '',
        redirectUri: Uri(path: ''),
      ),
    );

    if (appleUser == null) {
      throw FirebaseException(
        plugin: '',
        code: 'apple-sign-in-error',
        message: 'Apple Sign In Error: User is null',
      );
    }

    final OAuthCredential credential =
        AppleAuthProvider.credential(appleUser.identityToken!);
    userCredential = await auth.signInWithCredential(credential);

    await createNewUser(appleUser.givenName ?? '', appleUser.email ?? '', '',
        '', 'male', "apple")
        .catchError((e) {
      throw FirebaseException(
        plugin: '',
        code: 'permission-denied',
        message: 'Permission denied',
      );
    });

    return userCredential!;
  }

  @override
  Future<void> signOut() async {
    if (googleSignIn != null) {
      await googleSignIn.disconnect();
    } else if (facebookSignIn != null) {
      await facebookSignIn.logOut();
    }
    auth.signOut();
  }

  @override
  Future<void> createNewUser(String name, String email, String phoneNumber,
      String imgUrl, String gender, String userProfileType) async {
    final userCollection = fireStore.collection(FirebaseCollection.users);

    final uid = await getCurrentUID();

    final newUser = UserModel(
      userId: uid,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      role: 'user',
      imgUrl: imgUrl,
      gender: gender,
      isOnline: true,
      userProfileType: userProfileType,
    ).toDocument();

    userCollection.doc(uid).get().then((userDoc) {
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser).then((value) {});
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((e) {
      throw FirebaseException(
        plugin: '',
        code: 'permission-denied',
        message: 'Permission denied',
      );
    });
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    phoneVerificationCompleted(AuthCredential authCredential) {
      print(
          "phone verified : Token ${authCredential.token} ${authCredential.signInMethod}");
    }

    phoneVerificationFailed(FirebaseAuthException firebaseAuthException) {
      print(
        "phone failed : ${firebaseAuthException.message},${firebaseAuthException.code}",
      );
    }

    phoneCodeAutoRetrievalTimeout(String verificationId) {
      _verificationId = verificationId;
      print("time out :$verificationId");
    }

    phoneCodeSent(String verificationId, int? forceResendingToken) {
      _verificationId = verificationId;
    }

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 60),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }
}
