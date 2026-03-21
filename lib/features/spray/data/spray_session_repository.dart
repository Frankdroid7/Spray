import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpraySessionRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> saveSprayCode(String uid, String code) async {
    await _db.doc('users/$uid').set(
      {'activeSprayCode': code, 'spraySessionActive': false},
      SetOptions(merge: true),
    );
  }

  Stream<bool> listenForSessionStart(String uid) {
    return _db.doc('users/$uid').snapshots().map((snap) {
      return snap.data()?['spraySessionActive'] == true;
    });
  }

  Future<bool> validateAndStartSession(String receiverId, String code) async {
    final doc = await _db.doc('users/$receiverId').get();
    final storedCode = doc.data()?['activeSprayCode'] as String?;
    if (storedCode == null || storedCode != code) return false;

    await _db.doc('users/$receiverId').set(
      {'spraySessionActive': true},
      SetOptions(merge: true),
    );
    return true;
  }

  Future<void> clearSpraySession(String uid) async {
    await _db.doc('users/$uid').update({
      'activeSprayCode': FieldValue.delete(),
      'spraySessionActive': FieldValue.delete(),
    });
  }
}

final spraySessionRepositoryProvider =
    Provider<SpraySessionRepository>((ref) => SpraySessionRepository());
