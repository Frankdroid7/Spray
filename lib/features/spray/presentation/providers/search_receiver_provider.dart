import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/features/authentication/view_models/auth_provider.dart';
import 'package:spray/features/spray/data/user_repository.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';

class SearchReceiverState {
  final bool loading;
  final String error;
  final List<SprayReceiver> receivers;
  final int selectedReceiverIndex;

  const SearchReceiverState({
    this.receivers = const [],
    this.loading = false,
    this.error = "",
    this.selectedReceiverIndex = -1,
  });

  SearchReceiverState copyWith({
    List<SprayReceiver>? receivers,
    bool? loading,
    String? error,
    int? selectedReceiverIndex,
  }) {
    return SearchReceiverState(
      error: error ?? this.error,
      loading: loading ?? this.loading,
      receivers: receivers ?? this.receivers,
      selectedReceiverIndex:
          selectedReceiverIndex ?? this.selectedReceiverIndex,
    );
  }
}

class SearchReceiverNotifier extends Notifier<SearchReceiverState> {
  List<SprayReceiver> _allUsers = [];

  @override
  SearchReceiverState build() {
    _loadUsers();
    return const SearchReceiverState(loading: true);
  }

  Future<void> _loadUsers() async {
    try {

      final repo = ref.read(userRepositoryProvider);
      final currentUser = ref.read(authStateProvider).value;
      final allUsers = await repo.getAllUsers();
      _allUsers = allUsers.where((u) => u.id != currentUser?.uid).toList();
      state = state.copyWith(receivers: _allUsers, loading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(receivers: _allUsers, selectedReceiverIndex: -1);
      return;
    }

    final lower = query.toLowerCase();
    final filtered = _allUsers
        .where((u) => u.name.toLowerCase().contains(lower))
        .toList();
    state = state.copyWith(receivers: filtered, selectedReceiverIndex: -1);
  }

  void selectReceiver(int index) {
    state = state.copyWith(selectedReceiverIndex: index);
  }
}

final NotifierProvider<SearchReceiverNotifier, SearchReceiverState>
    searchReceiversProvider = NotifierProvider(SearchReceiverNotifier.new);
