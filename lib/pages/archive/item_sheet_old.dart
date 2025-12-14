// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:keeper/models/item.dart';
// import 'package:keeper/models/item_snapshot.dart';
// import 'package:keeper/models/user.dart';
// import 'package:keeper/services/database.dart';
// import 'package:keeper/themes/app_tokens.dart';
// import 'package:provider/provider.dart';

// class ShowCreateSheet {
//   ShowCreateSheet.itemSheetAdd(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       barrierColor: AppColors.primary.withAlpha((255 * 0.8).round()),
//       isDismissible: true,
//       isScrollControlled: true,
//       enableDrag: true,
//       useSafeArea: true,

//       builder: (_) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//           child: GestureDetector(
//             onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

//             child: DraggableScrollableSheet(
//               expand: false,
//               initialChildSize: 0.75,
//               minChildSize: 0.6,
//               maxChildSize: 1,
//               builder: (_, ScrollController scrollController) => AddItemForm(
//                 parentContext: context,
//                 scrollController: scrollController,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   ShowCreateSheet.itemSheetUpdate(BuildContext context, Item item) {
//     showModalBottomSheet(
//       context: context,
//       barrierColor: AppColors.secondary.withAlpha((255 * 0.8).round()),
//       isDismissible: true,
//       isScrollControlled: true,
//       enableDrag: true,
//       useSafeArea: true,

//       builder: (_) {
//         return BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//           child: DraggableScrollableSheet(
//             expand: false,
//             initialChildSize: 0.75,
//             minChildSize: 0.6,
//             maxChildSize: 1,
//             builder: (_, ScrollController scrollController) => AddItemForm(
//               parentContext: context,
//               scrollController: scrollController,
//               itemInfo: item,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class AddItemForm extends StatefulWidget {
//   final BuildContext parentContext;
//   final ScrollController scrollController;
//   final Item? itemInfo;
//   const AddItemForm({
//     super.key,
//     required this.parentContext,
//     required this.scrollController,
//     this.itemInfo,
//   });

//   @override
//   State<AddItemForm> createState() => _AddItemFormState();
// }

// class _AddItemFormState extends State<AddItemForm> {
//   final _formKey = GlobalKey<FormState>();

//   String? _name, _loc, _desc;
//   bool _imp = false;
//   bool _lost = false;

//   MyUser? myUser;

//   int version = 0;

//   @override
//   void initState() {
//     super.initState();

//     final itemInfo = widget.itemInfo;
//     myUser = widget.parentContext.watch<MyUser?>();

//     if (itemInfo != null) {
//       _name = itemInfo.name;
//       _desc = itemInfo.description;
//       _loc = itemInfo.location;
//       _imp = itemInfo.isLocked;
//       _lost = itemInfo.isLost;

//       version = 1;
//     }
//   }

//   @override
//   Widget build(BuildContext sheetContext) {
//     if (myUser == null) {
//       return Center(child: CircularProgressIndicator());
//     }

//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(
//           24.0,
//           24.0,
//           24.0,
//           24.0 + MediaQuery.of(sheetContext).viewInsets.bottom,
//         ),
//         child: ListView(
//           // shrinkWrap: true,
//           controller: widget.scrollController,
//           children: [
//             Text(
//               version == 1 ? 'update details' : 'item details',
//               style: Theme.of(sheetContext).textTheme.headlineLarge,
//             ),

//             const SizedBox(height: 16.0),

//             // Name Text Input
//             TextFormField(
//               initialValue: _name,
//               decoration: InputDecoration(label: Text('item name*')),
//               validator: (value) => value == null || value.isEmpty
//                   ? 'please enter a item name'
//                   : null,
//               onChanged: (value) => _name = value,
//               textInputAction: .next,
//             ),

//             const SizedBox(height: 16.0),

//             // Location Text Input
//             TextFormField(
//               initialValue: _loc,
//               decoration: InputDecoration(label: Text('location*')),
//               validator: (value) => value == null || value.isEmpty
//                   ? 'please enter a location'
//                   : null,
//               onChanged: (value) => _loc = value,
//               textInputAction: .next,
//             ),

//             const SizedBox(height: 16.0),

//             // Description Text Input
//             TextFormField(
//               initialValue: _desc,
//               decoration: InputDecoration(label: Text('description*')),
//               validator: (value) => value == null || value.isEmpty
//                   ? 'please enter a description'
//                   : null,
//               onChanged: (value) => _desc = value,
//               maxLines: 2,
//               textAlign: .start,
//               textInputAction: .done,
//             ),

//             const SizedBox(height: 16.0),

//             SwitchListTile(
//               shape: RoundedRectangleBorder(borderRadius: AppBorders.hard),
//               value: _imp,
//               onChanged: (value) => setState(() => (_imp = value)),
//               title: Row(
//                 spacing: 8.0,
//                 children: [
//                   Icon(!_imp ? Icons.lock_open : Icons.lock_outline),
//                   Text('secure'),
//                 ],
//               ),

//               activeTrackColor: AppColors.error,
//             ),

//             const SizedBox(height: 8.0),

//             SwitchListTile(
//               shape: RoundedRectangleBorder(borderRadius: AppBorders.hard),

//               value: _lost,
//               onChanged: (value) => setState(() => (_lost = value)),
//               title: Row(
//                 spacing: 8.0,
//                 children: [
//                   Icon(
//                     _lost
//                         ? Icons.location_disabled_outlined
//                         : Icons.location_searching_outlined,
//                   ),
//                   Text('lost'),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 16.0),

//             FloatingActionButton(
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   switch (version) {
//                     case 0:
//                       addItem();
//                     case 1:
//                       updateItem(widget.itemInfo!);
//                   }
//                 }
//               },
//               child: Text(version == 1 ? 'UPDATE' : 'SUBMIT'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void addItem() async {
//     try {
//       Item? itemResponce = await DatabaseService().createItem(
//         Item(
//           ownerId: myUser!.uid,
//           name: _name!,
//           description: _desc!,
//           location: _loc!,
//           isLocked: _imp,
//           isLost: _lost,
//           updatedAt: DateTime.now(),
//         ),
//       );
//       if (itemResponce == null) throw Exception();
//       ItemSnapshot? snapshotResponce = await DatabaseService()
//           .createItemSnapshot(
//             ItemSnapshot(
//               itemId: itemResponce.id!,
//               location: _loc!,
//               changerId: myUser!.uid,
//             ),
//           );
//       if (snapshotResponce == null) throw Exception();

//       if (!widget.parentContext.mounted) return;
//       Navigator.pop(widget.parentContext);
//     } on Exception catch (e) {
//       debugPrint('Unexpected error: $e');
//     }
//   }

//   void updateItem(Item oldItem) async {
//     try {
//       await DatabaseService().updateItem(
//         Item(
//           id: oldItem.id,
//           ownerId: myUser!.uid,
//           name: _name!,
//           description: _desc!,
//           location: _loc!,
//           isLocked: _imp,
//           isLost: _lost,
//           updatedAt: DateTime.now(),
//         ),
//       );

//       if (oldItem.location != _loc) {
//         ItemSnapshot? snapshotResponce = await DatabaseService()
//             .createItemSnapshot(
//               ItemSnapshot(
//                 itemId: oldItem.id!,
//                 location: _loc!,
//                 changerId: myUser!.uid,
//               ),
//             );
//         if (snapshotResponce == null) throw Exception();
//       }

//       if (!widget.parentContext.mounted) return;
//       Navigator.pop(widget.parentContext);
//     } on Exception catch (e) {
//       debugPrint('Unexpected error: $e');
//     }
//   }
// }
