import 'package:flutter/material.dart' hide SearchBar;
import 'package:keeper/pages/main/home/widgets/item_serch_bar.dart';
import 'package:keeper/themes/app_tokens.dart';
import 'package:keeper/themes/app_typography.dart';
import 'package:keeper/widgets/app_container.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:keeper/models/item.dart';

import 'widgets/item_list_view.dart';
import 'widgets/home_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearchOpen = false;
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void makeSearch(String value) =>
      setState(() => searchQuery = value.toLowerCase());

  void clearSearch() {
    searchController.clear();
    setState(() => searchQuery = '');
    _toggleSearch();
  }

  void _toggleSearch() {
    if (!_isSearchOpen) {
      searchFocusNode.requestFocus();
    } else {
      searchFocusNode.unfocus();
    }
    setState(() => _isSearchOpen = !_isSearchOpen);
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<List<Item>?>();

    if (items == null) {
      return const Scaffold(body: LinearProgressIndicator());
    }

    List<Item> searchResult = searchQuery.isNotEmpty
        ? items
              .where((item) => item.name.toLowerCase().contains(searchQuery))
              .toList()
        : items;

    return GestureDetector(
      onTap: () => searchFocusNode.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: AppContainer.list(
                    child: ItemListView(items: searchResult),
                  ),
                ),
                _BottomMarquee(items: items),
              ],
            ),

            BottomSearchAnimator(
              isSearchOpen: _isSearchOpen,
              searchController: searchController,
              searchBar: ItemSearchBar(
                onChanged: makeSearch,
                onClear: clearSearch,
                textController: searchController,
                textFocusNode: searchFocusNode,
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _isSearchOpen ? null : HomeFab(onSearch: _toggleSearch),
        ),
      ),
    );
  }
}

class _BottomMarquee extends StatelessWidget {
  final List<Item> items;
  const _BottomMarquee({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 20,
      child: Marquee(
        text:
            'NO OF ITEMS STORED: ${items.length} :: NO OF ITEMS LOST: ${items.where((i) => i.isLost).length} :: ',
        style: AppTextStyles.label.copyWith(color: AppColors.onDark),
      ),
    );
  }
}
