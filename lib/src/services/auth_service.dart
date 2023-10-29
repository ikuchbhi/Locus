import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/locus_user.dart';

/// A AuthService Interface
/// Defines what all methods should be present in an AuthService
abstract class AuthService {
  /// Login via Email+Password and return a LocusUser if valid else null
  Future<LocusUser?> loginViaEmail(String email, String password);

  /// Login via Google OAuth
  Future<User?> loginViaGoogle();

  /// Logs a user out
  Future<void> logOut();

  /// Signup via Email+Password with a unique username
  Future<User?> signUp(
    String email,
    String password,
  );

  /// Sends the email with a verification link
  /// If successful, allow signup else no
  Future<bool> sendVerificationLink();

  /// Checks if a user's username is unique
  Future<bool> checkIfUsernameExists(String username);

  /// Update username and name
  Future<void> updateUsernameAndName(
    String email,
    String username,
    String name,
  );

  /// Checks if email has been verified
  Future<bool> checkIfEmailVerified();

  /// Resends the email verification link
  Future<void> resendVerificationLink();

  /// Logs in via username
  Future<LocusUser?> loginViaUsername(String username, String password);

  /// Sends the reset password email
  Future sendResetPasswordEmail(String email);

  /// Gets the corresponding Locus User from Firestore
  Future<LocusUser> getLocusUserFromOAuth(String email);
}

class AuthServiceImpl implements AuthService {
  static const USER_COLLECTION = "users";

  /// Firebase Client (for users table)
  final FirebaseFirestore client;

  /// Firebase Auth client
  final FirebaseAuth authClient;

  AuthServiceImpl(this.authClient, this.client);

  @override
  Future<LocusUser?> loginViaEmail(String email, String password) async {
    final res = await authClient.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (res.user != null) {
      // TODO: Fix login logic
      return LocusUser("", res.user!.email!, "", "");
    }
    return null;
  }

  @override
  Future<User?> loginViaGoogle() async {
    final googleSignIn = await GoogleSignIn().signIn();
    final googleUser = await googleSignIn?.authentication;
    final cred = GoogleAuthProvider.credential(
      accessToken: googleUser?.accessToken,
      idToken: googleUser?.idToken,
    );

    final userCreds = await authClient.signInWithCredential(cred);
    return userCreds.user;
  }

  @override
  Future<User?> signUp(
    String email,
    String password,
  ) async {
    final userCreds = await authClient.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCreds.user;
  }

  @override
  Future<bool> sendVerificationLink() async {
    if (authClient.currentUser == null) {
      return false;
    } else {
      await authClient.currentUser!.sendEmailVerification();
      return true;
    }
  }

  @override
  Future<bool> checkIfUsernameExists(String username) async {
    final usernames = await client
        .collection(USER_COLLECTION)
        .where('username', isEqualTo: username)
        .count()
        .get();
    return usernames.count >= 2;
  }

  @override
  Future<void> updateUsernameAndName(
    String email,
    String username,
    String name,
  ) async {
    await client.collection(USER_COLLECTION).doc(email).set({
      "email": email,
      "username": username,
      "name": name,
      "biodata": "",
    });
  }

  @override
  Future<bool> checkIfEmailVerified() async {
    if (authClient.currentUser == null) {
      return false;
    } else {
      authClient.currentUser!.reload();
      return authClient.currentUser!.emailVerified;
    }
  }

  @override
  Future<void> resendVerificationLink() async {
    await authClient.currentUser?.sendEmailVerification();
  }

  @override
  Future<LocusUser?> loginViaUsername(String username, String password) async {
    final user = await client
        .collection(USER_COLLECTION)
        .where('username', isEqualTo: username)
        .get();
    if (user.docs.isEmpty) {
      return null;
    } else {
      return LocusUser(
        user.docs[0].get('username'),
        user.docs[0].get('email'),
        user.docs[0].get('name'),
        user.docs[0].get('biodata'),
      );
    }
  }

  @override
  Future<void> logOut() async {
    await authClient.signOut();
    if (GoogleSignIn().currentUser != null) {
      await GoogleSignIn().disconnect();
    }
  }

  @override
  Future sendResetPasswordEmail(String email) async {
    await authClient.sendPasswordResetEmail(email: email);
  }

  @override
  Future<LocusUser> getLocusUserFromOAuth(String email) async {
    final res = await client
        .collection(USER_COLLECTION)
        .where('email', isEqualTo: email)
        .get();
    return LocusUser(
      res.docs[0].get('username'),
      res.docs[0].get('email'),
      res.docs[0].get('name'),
      res.docs[0].get('biodata'),
    );
  }
}
