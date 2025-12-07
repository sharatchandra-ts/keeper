/// A simple data model representing an item owned by a user.
class Item {
  /// Unique identifier (primary key) for the item.
  final String id;

  /// User id of the owner.
  final String ownerId;

  /// Human-readable name for the item.
  final String name;

  /// Description text for the item.
  final String description;

  /// Location string for the item.
  final String location;

  /// Whether the item is locked.
  final bool isLocked;

  /// Whether the item is marked as lost.
  final bool isLost;

  /// Creation timestamp from the database.
  final DateTime createdAt;

  /// Last update timestamp from the database.
  final DateTime updatedAt;

  Item({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.location,
    required this.isLocked,
    required this.isLost,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates an empty/default item. Useful as a placeholder.
  Item.initialData()
    : id = '',
      ownerId = '',
      name = '',
      description = '',
      location = '',
      isLocked = false,
      isLost = false,
      createdAt = DateTime.now(),
      updatedAt = DateTime.now();

  /// Constructs an [Item] from a database row map returned by Supabase.
  Item.fromDatabase(Map<String, dynamic> data)
    : id = data['id'],
      ownerId = data['owner_id'],
      name = data['name'],
      description = data['description'],
      location = data['location'],
      isLocked = data['is_locked'],
      isLost = data['is_lost'],
      createdAt = DateTime.parse(data['created_at']),
      updatedAt = DateTime.parse(data['updated_at']);
}
