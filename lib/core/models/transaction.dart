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
}
