import 'dart:convert' show base64Url;
import 'dart:math' show Random;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/locus_user.dart';

/// A AuthService Interface
/// Defines what all methods should be present in an AuthService
abstract class AuthService {
  /// Login via Email+Password and return a LocusUser if valid else null
  Future<LocusUser?> login(String email, String password);

  /// Login via Google OAuth
  Future<AuthResponse> loginViaGoogle();

  /// Signup via Email+Password with a unique username
  Future<void> signUp(
    String email,
    String password,
  );

  /// Verify the Token sent on the given email
  /// If successful, allow signup else no
  Future<bool> verifyToken(String email, String token);

  /// Checks if a user's username is unique
  Future<bool> checkIfUsernameExists(String username);

  /// Update username and name
  Future<void> updateUsernameAndName(
      String email, String username, String name);
}

class AuthServiceImpl implements AuthService {
  /// Fixed value for Google login
  static const discoveryUrl =
      'https://accounts.google.com/.well-known/openid-configuration';

  /// OAuth Scopes
  static const scopes = [
    'openid',
    'email',
  ];

  /// Table names
  // ignore: constant_identifier_names
  static const USER_TABLE = "locus_users";

  /// Supabase Client to access custom Locus User table
  final SupabaseClient client;

  /// Supabase Auth client
  final GoTrueClient supabaseAuth;

  /// Supabase client ID
  final String clientID;

  /// Supabase redirectURL
  final String _redirectURL;

  AuthServiceImpl(
    this.client,
    this.clientID,
  )   : supabaseAuth = client.auth,
        _redirectURL = "${clientID.split('.').reversed.join('.')}:/";

  static String _generateRandomString() {
    final r = Random.secure();
    return base64Url.encode(
      List<int>.generate(
        16,
        (_) => r.nextInt(256),
      ),
    );
  }

  @override
  Future<LocusUser?> login(String email, String password) async {
    final res = await supabaseAuth.signInWithPassword(
      email: email,
      password: password,
    );
    if (res.user != null) {
      return LocusUser("", res.user!.email!, "", "");
    }
    return null;
  }

  // TODO: Doesn't work for some reason
  @override
  Future<AuthResponse> loginViaGoogle() async {
    final rawNonce = _generateRandomString();
    final googleSignIn = GoogleSignIn(
      serverClientId: clientID,
      scopes: [
        'openid',
        'email',
      ],
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    return supabaseAuth.signInWithIdToken(
      provider: Provider.google,
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken,
      nonce: rawNonce,
    );
  }

  @override
  Future<void> signUp(
    String email,
    String password,
  ) async {
    await supabaseAuth.signInWithOtp(
      shouldCreateUser: true,
      email: email,
      emailRedirectTo: '${_redirectURL}signin-callback/',
    );
  }

  @override
  Future<bool> verifyToken(String email, String token) async {
    final res = await supabaseAuth.verifyOTP(
      type: OtpType.email,
      token: token,
      email: email,
    );
    return res.user != null;
  }

  @override
  Future<bool> checkIfUsernameExists(String username) async {
    final res =
        await client.from('locus_user_data').select().eq('username', username);
    return res.count > 1;
  }

  @override
  Future<void> updateUsernameAndName(
    String email,
    String username,
    String name,
  ) async {
    await client.from(USER_TABLE).update({
      "username": username,
      "name": name,
    }).eq('email', email);
  }
}
