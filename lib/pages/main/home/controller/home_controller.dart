import 'package:keeper/models/item.dart';
import 'package:keeper/models/item_snapshot.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/services/database.dart';

class HomeController {
  final DatabaseService _db;

  HomeController(this._db);

  Future<void> deleteItem(Item item) async {
    await _db.deleteItemById(item.id!);
  }

  Future<void> addItem({
    required MyUser user,
    required String name,
    required String desc,
    required String loc,
    required bool locked,
    required bool lost,
  }) async {
    final item = await _db.createItem(
      Item(
        ownerId: user.uid,
        name: name,
        description: desc,
        location: loc,
        isLocked: locked,
        isLost: lost,
        updatedAt: DateTime.now(),
      ),
    );

    if (item == null) throw Exception('Item create failed');

    await _db.createItemSnapshot(
      ItemSnapshot(itemId: item.id!, location: loc, changerId: user.uid),
    );
  }

  Future<void> updateItem({
    required Item oldItem,
    required MyUser user,
    required String name,
    required String desc,
    required String loc,
    required bool locked,
    required bool lost,
  }) async {
    await _db.updateItem(
      Item(
        id: oldItem.id,
        ownerId: user.uid,
        name: name,
        description: desc,
        location: loc,
        isLocked: locked,
        isLost: lost,
        updatedAt: DateTime.now(),
      ),
    );

    if (oldItem.location != loc) {
      await _db.createItemSnapshot(
        ItemSnapshot(itemId: oldItem.id!, location: loc, changerId: user.uid),
      );
    }
  }
}
