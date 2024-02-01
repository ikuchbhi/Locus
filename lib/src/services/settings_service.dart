import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/locus_user.dart';

abstract class SettingsService {
  Future<LocusUser> getSettings(String email);

  Future<LocusUser> updateUsername(String email, String username);

  Future<LocusUser> updateName(String email, String name);

  Future<LocusUser> updateBiodata(String email, String biodata);
}

class SettingsServiceImpl implements SettingsService {
  static const USERS_COLLECTION = "users";

  final FirebaseFirestore client;

  SettingsServiceImpl(this.client);

  @override
  Future<LocusUser> updateBiodata(String email, String biodata) async {
    await client.collection(USERS_COLLECTION).doc(email).set({
      'biodata': biodata,
    });
    return getSettings(email);
  }

  @override
  Future<LocusUser> updateName(String email, String name) async {
    await client.collection(USERS_COLLECTION).doc(email).set({
      'name': name,
    });
    return getSettings(email);
  }

  @override
  Future<LocusUser> updateUsername(String email, String username) async {
    await client.collection(USERS_COLLECTION).doc(email).set({
      'username': username,
    });
    return getSettings(email);
  }

  @override
  Future<LocusUser> getSettings(String email) async {
    final res = await client.collection(USERS_COLLECTION).doc(email).get();
    return LocusUser(
      res.data()!['username'] ?? "",
      res.data()!['email'] ?? "",
      res.data()!['name'] ?? "",
      res.data()!['biodata'] ?? "",
    );
  }
}
