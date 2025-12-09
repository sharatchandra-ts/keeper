/// A historical record of an item's location change.
class ItemSnapshot {
  final String? id;
  final String itemId;
  final String location;
  final DateTime? timestamp;
  final String changerId;

  ItemSnapshot({
    this.id,
    required this.itemId,
    required this.location,
    this.timestamp,
    required this.changerId,
  });

  /// Constructs an [ItemSnapshot] from a database row map.
  ItemSnapshot.fromDatabase(Map<String, dynamic> data)
    : id = data['id'],
      itemId = data['item_id'],
      location = data['location'],
      timestamp = DateTime.parse(data['timestamp']),
      changerId = data['changer_id'];

  /// Converts the model to a map for insertion into Supabase.
  Map<String, dynamic> toDatabase() => {
    'item_id': itemId,
    'location': location,
    'changer_id': changerId,
  };
}
