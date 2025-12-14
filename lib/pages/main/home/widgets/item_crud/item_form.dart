import 'package:flutter/material.dart';
import 'package:keeper/enums/item_form_mode.dart';
import 'package:keeper/models/item.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/pages/main/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class ItemForm extends StatefulWidget {
  final ScrollController scrollController;
  final Item? item;
  final ItemFormMode mode;

  const ItemForm({
    super.key,
    required this.scrollController,
    this.item,
    required this.mode,
  });

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name, _loc, _desc;
  bool _locked = false;
  bool _lost = false;

  bool get isUpdate => widget.mode == ItemFormMode.update;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _name = item?.name ?? '';
    _desc = item?.description ?? '';
    _loc = item?.location ?? '';
    _locked = item?.isLocked ?? false;
    _lost = item?.isLost ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<MyUser?>();

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          24 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ListView(
          controller: widget.scrollController,
          children: [
            Text(
              isUpdate ? 'update details' : 'item details',
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            const SizedBox(height: 16),

            _field('item name', _name, (v) => _name = v),
            _field('location', _loc, (v) => _loc = v),
            _field('description', _desc, (v) => _desc = v, lines: 2),

            SwitchListTile(
              value: _locked,
              onChanged: (v) => setState(() => _locked = v),
              title: const Text('secure'),
            ),

            SwitchListTile(
              value: _lost,
              onChanged: (v) => setState(() => _lost = v),
              title: const Text('lost'),
            ),

            const SizedBox(height: 16),

            FloatingActionButton.extended(
              onPressed: () => _submit(context, user),
              label: Text(isUpdate ? 'UPDATE' : 'SUBMIT'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context, MyUser user) async {
    if (!_formKey.currentState!.validate()) return;

    final controller = context.read<HomeController>();

    if (isUpdate) {
      await controller.updateItem(
        oldItem: widget.item!,
        user: user,
        name: _name,
        desc: _desc,
        loc: _loc,
        locked: _locked,
        lost: _lost,
      );
    } else {
      await controller.addItem(
        user: user,
        name: _name,
        desc: _desc,
        loc: _loc,
        locked: _locked,
        lost: _lost,
      );
    }

    if (context.mounted) Navigator.pop(context);
  }

  Widget _field(
    String label,
    String value,
    Function(String) onChanged, {
    int lines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: value,
        maxLines: lines,
        decoration: InputDecoration(labelText: label),
        validator: (v) => v == null || v.isEmpty ? 'required' : null,
        onChanged: onChanged,
      ),
    );
  }
}
