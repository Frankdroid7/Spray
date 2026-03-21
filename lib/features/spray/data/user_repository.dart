import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spray/features/spray/domain/entities/spray_receiver.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<SprayReceiver>> getAllUsers() async {
    final snap = await _db.collection('users').get();
    return snap.docs.map((d) {
      final data = d.data();
      final name = data['displayName'] as String? ?? '';
      final tag = name.isNotEmpty ? '@${name.split(' ').first.toLowerCase()}' : '';
      return SprayReceiver(
        id: d.id,
        name: name,
        tag: tag,
        photoUrl: data['photoUrl'] as String?,
      );
    }).toList();
  }
}

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository());
