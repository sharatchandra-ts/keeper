import 'package:flutter/material.dart' hide SearchBar;
import 'package:keeper/pages/main/home/widgets/item_serch_bar.dart';
import 'package:keeper/themes/app_tokens.dart';
import 'package:keeper/themes/app_typography.dart';
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

  void _toggleSearch() {
    setState(() => _isSearchOpen = !_isSearchOpen);
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<List<Item>?>();

    if (items == null) {
      return const Scaffold(body: LinearProgressIndicator());
    }

    return GestureDetector(
      onTap: () => _toggleSearch(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(child: ItemListView(items: items)),
                _BottomMarquee(items: items),
              ],
            ),

            _BottomSearch(_isSearchOpen),
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

class _BottomSearch extends StatelessWidget {
  const _BottomSearch(this.isSearchOpen);
  final bool isSearchOpen;

  @override
  Widget build(BuildContext context) {
    double padding = 16;

    return Positioned(
      bottom: 32,
      right: padding,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutCubic,
        height: 56,
        width: isSearchOpen
            ? MediaQuery.of(context).size.width - 2 * padding
            : 0,
        child: IgnorePointer(
          // Blocks tap when search not open
          ignoring: !isSearchOpen,
          child: AnimatedOpacity(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 250),
            opacity: isSearchOpen ? 1 : 0,
            child: ItemSearchBar(),
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
        style: AppTextStyles.label.copyWith(color: AppColors.onDark),
      ),
    );
  }
}
