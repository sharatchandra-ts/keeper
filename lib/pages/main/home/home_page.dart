import 'package:flutter/material.dart' hide SearchBar;
import 'package:keeper/pages/main/home/widgets/item_serch_bar.dart';
import 'package:keeper/pages/main/home/widgets/sort_popup_menu.dart';
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
      setState(() => searchQuery = value.toLowerCase().trim());

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

    return GestureDetector(
      onTap: () => searchFocusNode.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 16.0),

                _HeaderWidget(),

                Expanded(
                  child: Padding(
                    padding: .fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: AppContainer.list(
                      child: ItemListView(
                        items: items,
                        searchQuery: searchQuery,
                      ),
                    ),
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

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: AppContainer(
        child: Padding(
          padding: const .symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'ITEMS DATA',
                  style: AppTextStyles.h1.copyWith(color: AppColors.gray900),
                ),
              ),
              SortPopupMenu(),
            ],
          ),
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
        style: AppTextStyles.labelMedium.copyWith(color: AppColors.textOnDark),
      ),
    );
  }
}
