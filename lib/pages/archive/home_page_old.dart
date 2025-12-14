// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:keeper/models/item.dart';
// import 'package:keeper/models/item_snapshot.dart';
// import 'package:keeper/services/database.dart';
// import 'package:keeper/themes/app_tokens.dart';
// import 'package:keeper/themes/app_typography.dart';
// import 'package:keeper/pages/item_sheet.dart';
// import 'package:marquee/marquee.dart';
// import 'package:provider/provider.dart';

// /// Home screen showing the user's items stream and actions.
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final List<Item>? items = context.watch<List<Item>?>();

//     if (items == null) {
//       return Scaffold(body: LinearProgressIndicator());
//     }

//     return GestureDetector(
//       // To dismiss the search field
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

//       child: Scaffold(
//         body: Column(
//           mainAxisSize: .max,
//           children: [
//             // List of all the items
//             ItemListView(items: items),

//             // Bottom info marquee
//             Container(
//               color: Colors.black,
//               width: .maxFinite,
//               height: 20,
//               child: Marquee(
//                 text:
//                     'NO OF ITEMS STORED: ${items.length} :: NO OF ITEMS LOST: ${items.where((item) => item.isLost).length} :: ',
//                 style: AppTextStyles.label.copyWith(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//         floatingActionButtonAnimator: .noAnimation,
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12.0),

//           child: FabToInputFieldDemo(),
//         ),
//       ),
//     );
//   }
// }

// // This is the list of all the items the home page shows
// class ItemListView extends StatefulWidget {
//   const ItemListView({super.key, required this.items});

//   final List<Item> items;

//   @override
//   State<ItemListView> createState() => _ItemListViewState();
// }

// class _ItemListViewState extends State<ItemListView> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: const .fromLTRB(8.0, 16.0, 8.0, 0.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             border: Border(
//               left: AppBorders.thick,
//               right: AppBorders.thick,
//               top: AppBorders.thick,
//             ),
//             borderRadius: .vertical(top: .circular(AppBorders.hardR)),
//           ),
//           child: Material(
//             borderRadius: .vertical(top: .circular(AppBorders.hardR)),
//             clipBehavior: .antiAliasWithSaveLayer,
//             child: widget.items.isNotEmpty
//                 ? RefreshIndicator(
//                     onRefresh: () async {
//                       return Future.value();
//                     },
//                     child: ListView.builder(
//                       itemBuilder: (context, index) => MyListTile(
//                         item: widget.items[index],
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             useSafeArea: true,
//                             builder: (dialogContext) => Dialog(
//                               insetPadding: .symmetric(
//                                 horizontal: 16.0,
//                                 vertical: 56.0,
//                               ),
//                               child: ItemDetailsDialog(
//                                 item: widget.items[index],
//                                 mainContext: context,
//                                 onItemDelete: (item) async {
//                                   // Delete item
//                                   await DatabaseService().deleteItemById(
//                                     item.id!,
//                                   );
//                                   setState(() {
//                                     widget.items.removeWhere(
//                                       (i) => i.id == item.id!,
//                                     );
//                                   });
//                                 },
//                               ),
//                             ),
//                           );

//                           // ShowCreateSheet.itemSheetUpdate(
//                           //   context,
//                           //   items[index],
//                           // );
//                         },
//                       ),
//                       itemCount: widget.items.length,
//                     ),
//                   )
//                 : Center(
//                     child: Text(
//                       'No items to see, try adding new items.',
//                       style: AppTextStyles.label,
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ItemDetailsDialog extends StatelessWidget {
//   const ItemDetailsDialog({
//     super.key,
//     required this.item,
//     required this.mainContext,
//     required this.onItemDelete,
//   });

//   final Item item;
//   final BuildContext mainContext;
//   final Function(Item item) onItemDelete;

//   @override
//   Widget build(BuildContext context) {
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),

//       child: StreamBuilder(
//         stream: DatabaseService().streamItemSnapshotForItem(item.id!),
//         builder: (context, asyncSnapshot) {
//           List<ItemSnapshot>? itemSnap = asyncSnapshot.data;

//           return Material(
//             borderRadius: AppBorders.soft,
//             clipBehavior: .antiAlias,
//             child: Column(
//               crossAxisAlignment: .start,
//               children: [
//                 AppBar(
//                   leading: IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: Icon(Icons.close),
//                   ),
//                   actions: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         ShowCreateSheet.itemSheetUpdate(mainContext, item);
//                       },
//                       icon: Icon(Icons.edit_outlined),
//                     ),
//                     PopupMenuButton(
//                       icon: Icon(Icons.delete_outline_rounded),
//                       onSelected: (value) async {
//                         switch (value) {
//                           case 0:
//                             break;
//                           case 1:
//                             Navigator.pop(context);
//                             onItemDelete(item);
//                         }
//                       },
//                       itemBuilder: (context) => <PopupMenuEntry>[
//                         PopupMenuItem(
//                           value: 0,
//                           child: ListTile(title: Text('archive')),
//                         ),
//                         PopupMenuDivider(height: 0),
//                         PopupMenuItem(
//                           value: 1,
//                           child: ListTile(
//                             title: Text(
//                               'confirm delete',
//                               style: .new(color: AppColors.error),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                   title: Text(
//                     'item details',
//                     style: AppTextStyles.label.copyWith(fontSize: 18.0),
//                   ),
//                 ),
//                 Divider(),
//                 // Use Expanded only if the parent allows it, otherwise just SingleChildScrollView
//                 Flexible(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const .all(16.0),
//                       child: Column(
//                         crossAxisAlignment: .start,
//                         children: [
//                           Text(
//                             '++ item name ::\n${item.name.toLowerCase()}',
//                             style: AppTextStyles.label.copyWith(fontSize: 16),
//                           ),
//                           Divider(height: 32.0),
//                           Text(
//                             '++ location stored ::\n${item.location.toLowerCase()}',
//                             style: AppTextStyles.label.copyWith(fontSize: 16),
//                           ),
//                           Divider(height: 32.0),
//                           Text(
//                             '++ description ::\n${item.description.toLowerCase()}',
//                             style: AppTextStyles.label.copyWith(fontSize: 16),
//                           ),
//                           Divider(height: 32.0),
//                           Text(
//                             '++ last updated ::\n${DateFormat('dd MMMM yyyy, hh:mm a').format(item.updatedAt.toLocal())}',
//                             style: AppTextStyles.label.copyWith(fontSize: 16),
//                           ),
//                           Divider(height: 32.0),
//                           Text(
//                             'created on :: ${DateFormat('dd/MM/yyyy').format(item.createdAt!.toLocal())}',
//                             style: AppTextStyles.label,
//                           ),
//                           Text(
//                             'item locked :: ${item.isLocked}',
//                             style: AppTextStyles.label,
//                           ),
//                           Text(
//                             'item lost :: ${item.isLost}',
//                             style: AppTextStyles.label,
//                           ),
//                           Text(
//                             'no of updates :: ${itemSnap != null ? itemSnap.length : '0'}',
//                             style: AppTextStyles.label,
//                           ),
//                           Divider(height: 32.0),
//                           Text('log;;', style: AppTextStyles.label),

//                           itemSnap == null
//                               ? Text('loading...', style: AppTextStyles.label)
//                               : Column(
//                                   crossAxisAlignment: .start,
//                                   children: [
//                                     ...List.generate(
//                                       itemSnap.length,
//                                       (index) => Text(
//                                         '{$index:${DateFormat('dd/MM/yyyy').format(itemSnap[index].timestamp!.toLocal())}: location::${itemSnap[index].location}}',
//                                         style: AppTextStyles.label,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class MyListTile extends StatelessWidget {
//   const MyListTile({super.key, required this.item, required this.onTap});

//   final Item item;
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     final date = DateFormat('dd/MM/yy').format(item.updatedAt.toLocal());

//     return Column(
//       children: [
//         ListTile(
//           title: Text(item.name, style: .new(fontSize: 18.0)),
//           subtitle: Column(
//             crossAxisAlignment: .start,
//             children: [
//               Text(item.description.toLowerCase()),
//               Text('::last updated on: $date', style: AppTextStyles.label),
//             ],
//           ),
//           isThreeLine: true,

//           onTap: onTap,
//         ),
//         Divider(),
//       ],
//     );
//   }
// }

// class FabToInputFieldDemo extends StatefulWidget {
//   const FabToInputFieldDemo({super.key});

//   @override
//   State<FabToInputFieldDemo> createState() => _FabToInputFieldDemoState();
// }

// class _FabToInputFieldDemoState extends State<FabToInputFieldDemo> {
//   bool _isInputOpen = false;

//   // This value determines the width of the FAB when closed

//   void _toggleInput() {
//     setState(() {
//       _isInputOpen = !_isInputOpen;
//       if (!_isInputOpen) {}
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         if (!_isInputOpen) // Hide the search button when input is open
//           FloatingActionButton(
//             onPressed: () => ShowCreateSheet.itemSheetAdd(context),
//             heroTag: 'addFab', // Necessary for multiple FABs
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.horizontal(
//                 right: Radius.circular(6.0),
//                 left: Radius.circular(16.0),
//               ),
//             ),
//             child: const Icon(Icons.add),
//           ),

//         if (!_isInputOpen) const SizedBox(width: 2.0),

//         _isInputOpen
//             ? SizedBox(
//                 width: MediaQuery.of(context).size.width - 24,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const .only(left: 12.0),
//                         child: TextField(
//                           autofocus: true,
//                           decoration: InputDecoration(
//                             label: Icon(Icons.search),
//                             hintText: 'Search',
//                             suffixIcon: IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: _toggleInput,
//                             ),
//                           ),
//                           onSubmitted: (value) => _toggleInput(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : FloatingActionButton(
//                 onPressed: _toggleInput,
//                 heroTag: 'searchFab', // Necessary for multiple FABs
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.horizontal(
//                     right: Radius.circular(16.0),
//                     left: Radius.circular(6.0),
//                   ),
//                 ),
//                 child: const Icon(Icons.search),
//               ),
//       ],
//     );
//   }
// }
