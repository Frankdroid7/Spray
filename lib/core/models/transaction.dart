import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionType { fund, credit, debit }

class Transaction {
  final String id;
  final String timestamp;
  final TransactionType type;
  final double amount;
  final String narration;

  const Transaction({
    this.id = "",
    this.timestamp = "2026-01-01",
    this.type = TransactionType.fund,
    this.amount = 0.0,
    this.narration = "",
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type.name,
        'amount': amount,
        'narration': narration,
        'timestamp': Timestamp.fromDate(DateTime.parse(timestamp)),
      };

  factory Transaction.fromMap(String id, Map<String, dynamic> map) =>
      Transaction(
        id: id,
        type: TransactionType.values.byName(map['type'] as String),
        amount: (map['amount'] as num).toDouble(),
        narration: map['narration'] as String,
        timestamp:
            (map['timestamp'] as Timestamp).toDate().toIso8601String(),
      );
}
