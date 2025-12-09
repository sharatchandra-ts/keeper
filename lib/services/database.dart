import 'package:flutter/widgets.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/models/item_snapshot.dart';
import 'package:keeper/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service layer responsible for reading/writing application data
/// from/to Supabase (profiles, items, etc.).
class DatabaseService {
  final _supabase = Supabase.instance.client;

  Future<MyUser?> createUser(User user, String name, String? phone) async {
    try {
      await _supabase.from('profiles').insert({
        'id': user.id,
        'email': user.email,
        'name': name,
        'phone': phone,
      });
      return MyUser(uid: user.id, name: name, email: user.email!, phone: phone);
    } catch (e) {
      debugPrint('Error creating user: $e');
      return null;
    }
  }

  /// Inserts a new [Item] into the `items` table and returns the created
  /// item as returned by the database (including generated `id` and
  /// timestamps). Returns `null` on error.
  Future<Item?> createItem(Item item) async {
    try {
      final response = await _supabase
          .from('items')
          .insert(item.toDatabase())
          .select()
          .single();

      return Item.fromDatabase(response);
    } catch (e) {
      debugPrint('Error creating item: $e');
      return null;
    }
  }

  Future<ItemSnapshot?> createItemSnapshot(ItemSnapshot itemSnapshot) async {
    try {
      final response = await _supabase
          .from('item_snapshots')
          .insert(itemSnapshot.toDatabase())
          .select()
          .single();

      return ItemSnapshot.fromDatabase(response);
    } catch (e) {
      debugPrint('Error creating item: $e');
      return null;
    }
  }

  Future updateItem(Item item) async {
    try {
      await _supabase
          .from('items')
          .update(item.toDatabase())
          .eq('id', item.id!);
    } catch (e) {
      debugPrint('Error creating item: $e');
    }
  }

  Stream<MyUser?> streamUserFromId(String id) {
    return Supabase.instance.client
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((dataList) {
          if (dataList.isEmpty) {
            debugPrint('Profile not found for ID: $id');
            return null;
          }
          final response = dataList.first;
          return MyUser.fromDatabase(response);
        })
        .handleError((e) {
          debugPrint('Realtime Stream Error fetching user: $e');
          return null;
        });
  }

  Stream<List<Item>> streamItemsForUser(String ownerId) {
    return Supabase.instance.client
        .from('items')
        .stream(primaryKey: ['id'])
        .eq('owner_id', ownerId)
        .map((dataList) {
          return dataList.map((data) => Item.fromDatabase(data)).toList();
        })
        .handleError((e) {
          debugPrint('Realtime Stream Error fetching items: $e');
          return <Item>[];
        });
  }
}
