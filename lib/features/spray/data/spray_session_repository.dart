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

  Future<void> endSession(String uid) async {
    await _db.doc('users/$uid').set(
      {'spraySessionActive': false},
      SetOptions(merge: true),
    );
  }

  Stream<bool> listenForSessionEnd(String receiverId) {
    return _db.doc('users/$receiverId').snapshots().map((snap) {
      return snap.data()?['spraySessionActive'] != true;
    });
  }

  Future<void> updateRunningTotal(String sprayeeUid, double amount, int denominationValue) async {
    await _db.doc('users/$sprayeeUid').set(
      {'currentSprayAmount': amount, 'lastDenominationValue': denominationValue},
      SetOptions(merge: true),
    );
  }

  Stream<double> listenToRunningTotal(String uid) {
    return _db.doc('users/$uid').snapshots().map((snap) {
      return (snap.data()?['currentSprayAmount'] as num?)?.toDouble() ?? 0.0;
    });
  }

  Stream<int?> listenToLastDenomination(String uid) {
    return _db.doc('users/$uid').snapshots().map((snap) {
      return snap.data()?['lastDenominationValue'] as int?;
    });
  }

  Stream<Map<String, dynamic>?> listenToSprayUpdates(String uid) {
    return _db.doc('users/$uid').snapshots().map((snap) => snap.data());
  }

  Future<void> clearSpraySession(String uid) async {
    await _db.doc('users/$uid').update({
      'activeSprayCode': FieldValue.delete(),
      'spraySessionActive': FieldValue.delete(),
      'currentSprayAmount': FieldValue.delete(),
      'lastDenominationValue': FieldValue.delete(),
    });
  }
}

final spraySessionRepositoryProvider =
    Provider<SpraySessionRepository>((ref) => SpraySessionRepository());
