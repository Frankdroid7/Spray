import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/models/transaction.dart';

class HomeState {
  final double balance;
  final List<Transaction> transactions;

  const HomeState({this.transactions = const [], this.balance = 0.0});

  HomeState copyWith({List<Transaction>? transactions, double? balance}) {
    return HomeState(
      transactions: transactions ?? this.transactions,
      balance: balance ?? this.balance,
    );
  }
}

class HomeNotifier extends Notifier<HomeState> {
  HomeNotifier();

  @override
  HomeState build() => const HomeState();

  void addDummyTransactions() {
    String now = DateTime.now().toIso8601String();
    state = state.copyWith(
      transactions: [
        Transaction(
          id: "1",
          timestamp: now,
          type: TransactionType.credit,
          narration: "Received from @john_doe",
          amount: 250.0,
        ),
        Transaction(
          id: "2",
          timestamp: now,
          type: TransactionType.debit,
          narration: "Sprayed to @jane_smith",
          amount: 150.0,
        ),
        Transaction(
          id: "3",
          timestamp: now,
          type: TransactionType.fund,
          narration: "Wallet funded",
          amount: 2000.0,
        ),
      ],
    );
  }
}

final NotifierProvider<HomeNotifier, HomeState> homeProvider = NotifierProvider(
  HomeNotifier.new,
);
