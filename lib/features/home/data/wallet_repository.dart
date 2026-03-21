import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/models/transaction.dart';

class WalletRepository {
  final _db = FirebaseFirestore.instance;

  Future<({double balance, List<Transaction> transactions})> getWallet(
      String uid) async {
    final doc = await _db.doc('users/$uid').get();
    final txns = await _db
        .collection('users/$uid/transactions')
        .orderBy('timestamp', descending: true)
        .limit(20)
        .get();
    return (
      balance: (doc.data()?['balance'] as num?)?.toDouble() ?? 0.0,
      transactions:
          txns.docs.map((d) => Transaction.fromMap(d.id, d.data())).toList(),
    );
  }

  Future<void> updateBalance({
    required String uid,
    required double delta,
    required Transaction transaction,
  }) async {
    final userRef = _db.doc('users/$uid');
    final txnRef = userRef.collection('transactions').doc(transaction.id);
    await _db.runTransaction((t) async {
      final snap = await t.get(userRef);
      final current = (snap.data()?['balance'] as num?)?.toDouble() ?? 0.0;
      t.set(
        userRef,
        {
          'balance': current + delta,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
      t.set(txnRef, transaction.toMap());
    });
  }
}

final walletRepositoryProvider =
    Provider<WalletRepository>((ref) => WalletRepository());
