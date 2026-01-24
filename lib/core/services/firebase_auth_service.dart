import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_time_chat_app/core/errors/custom_exception.dart';
import 'package:real_time_chat_app/core/services/auth_service.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "error happend in FirebaseAuthService in register method please check it, the error: $e",
      );
      if (e.code == 'weak-password') {
        throw CustomException(
          exceptionMeassge:
              "Your password is too weak. Please use at least 8 characters with numbers and symbols.",
        );
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          exceptionMeassge:
              "This email is already registered. Try signing in instead.",
        );
      } else if (e.code == 'invalid-email') {
        throw CustomException(
          exceptionMeassge:
              "The email address is not valid. Please check and try again.",
        );
      } else if (e.code == "network-request-failed") {
        throw CustomException(
          exceptionMeassge:
              "No internet connection. Please check your network and try again.",
        );
      } else {
        throw CustomException(
          exceptionMeassge: "Something went wrong. Please try again later.",
        );
      }
    } catch (e) {
      log(
        "error happend in FirebaseAuthService in register method please check it, the error: $e",
      );

      throw CustomException(
        exceptionMeassge: "Something went wrong. Please try again later.",
      );
    }
  }

  @override
  Future<User> signInWithEmailAndPassword({
    required String password,
    required String email,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        "error happend in FirebaseAuthService in signIn method please check it, the error: $e",
      );

      if (e.code == 'user-not-found') {
        throw CustomException(
          exceptionMeassge:
              "No account found with this email. Please sign up first.",
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(
          exceptionMeassge: "Incorrect email or password. Please try again.",
        );
      } else if (e.code == "network-request-failed") {
        throw CustomException(
          exceptionMeassge:
              "No internet connection. Please check your network and try again.",
        );
      } else if (e.code == "invalid-credential") {
        throw CustomException(
          exceptionMeassge:
              "No account found with this email. Please sign up to continue.",
        );
      } else if (e.code == "too-many-requests") {
        throw CustomException(
          exceptionMeassge:
              "For security reasons, too many requests were made. Please try again after a few minutes.",
        );
      } else {
        throw CustomException(
          exceptionMeassge: "Something went wrong. Please try again later.",
        );
      }
    } catch (e) {
      log(
        "error happend in FirebaseAuthService in signIn method please check it, the error: $e",
      );
      throw CustomException(
        exceptionMeassge: "Something went wrong. Please try again later.",
      );
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw CustomException(
        exceptionMeassge: "faild to send password reset email $e",
      );
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    await firebaseAuth.currentUser!.delete();
  }
}
