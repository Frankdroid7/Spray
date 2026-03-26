import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/core/models/transaction.dart';
import 'package:spray/features/authentication/view_models/auth_provider.dart';
import 'package:spray/features/home/data/wallet_repository.dart';
import 'package:uuid/uuid.dart';

class HomeState {
  final double balance;
  final List<Transaction> transactions;
  final bool isUpdatingBalance;

  const HomeState({
    this.transactions = const [],
    this.balance = 0.0,
    this.isUpdatingBalance = false,
  });

  HomeState copyWith({
    List<Transaction>? transactions,
    double? balance,
    bool? isUpdatingBalance,
  }) {
    return HomeState(
      transactions: transactions ?? this.transactions,
      balance: balance ?? this.balance,
      isUpdatingBalance: isUpdatingBalance ?? this.isUpdatingBalance,
    );
  }
}

class HomeNotifier extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    final user = ref.watch(authStateProvider).value;
    if (user == null) return const HomeState();

    final result = await ref.read(walletRepositoryProvider).getWallet(user.uid);
    final initialState = HomeState(
      balance: result.balance,
      transactions: List<Transaction>.from(result.transactions),
    );
    state = AsyncData(initialState);

    final sub = ref
        .read(walletRepositoryProvider)
        .listenToBalance(user.uid)
        .listen((newBalance) {
      final current = state.value;
      if (current != null) {
        state = AsyncData(current.copyWith(balance: newBalance));
      }
    });

    ref.onDispose(sub.cancel);

    return initialState;
  }

  Future<void> addBalance(
    double delta, {
    TransactionType type = TransactionType.fund,
    String? narration,
  }) async {
    final user = ref.read(authStateProvider).value;
    print('USER -> $user');
    if (user == null) return;
    print('STATE -> ${state}');
    final current = state.value;
    print('CURRENT -> $current');
    if (current == null) return;
    final txnId = const Uuid().v4();
    final txn = Transaction(
      id: txnId,
      type: type,
      amount: delta.abs(),
      narration: narration ?? 'Wallet funded',
      timestamp: DateTime.now().toIso8601String(),
    );
    state = AsyncData(
      current.copyWith(
        balance: current.balance + delta,
        isUpdatingBalance: true,
        transactions: [txn, ...current.transactions],
      ),
    );
    try {
      print('UPDATING BALANCE');
      await ref
          .read(walletRepositoryProvider)
          .updateBalance(uid: user.uid, delta: delta, transaction: txn);
    } catch (e) {
      state = AsyncData(current);
      rethrow;
    } finally {
      final s = state.value;
      if (s != null) state = AsyncData(s.copyWith(isUpdatingBalance: false));
    }
  }
}

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
