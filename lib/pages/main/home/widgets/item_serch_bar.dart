import 'package:flutter/material.dart';
import 'package:keeper/themes/app_tokens.dart';

class ItemSearchBar extends StatelessWidget {
  const ItemSearchBar({
    super.key,
    required this.onChanged,
    required this.textController,
    required this.onClear,
    required this.textFocusNode,
  });

  final ValueChanged<String> onChanged;
  final TextEditingController textController;
  final FocusNode textFocusNode;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,

      child: TextField(
        controller: textController,
        focusNode: textFocusNode,
        expands: true,
        maxLines: null,
        decoration: _searchInputDecoration(),
        onChanged: onChanged,
      ),
    );
  }

  InputDecoration _searchInputDecoration() {
    return InputDecoration(
      label: const Icon(Icons.search),
      hintText: 'Search',
      suffixIcon: IconButton(icon: const Icon(Icons.close), onPressed: onClear),
      border: OutlineInputBorder(borderRadius: AppBorders.soft),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppBorders.soft,
        borderSide: AppBorders.thick,
      ),
    );
  }
}

// SearchBar animator
class BottomSearchAnimator extends StatelessWidget {
  const BottomSearchAnimator({
    super.key,
    required this.isSearchOpen,
    required this.searchController,
    required this.searchBar,
  });
  final bool isSearchOpen;
  final TextEditingController searchController;
  final Widget searchBar;

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
            ? MediaQuery.of(context).size.width - 6 * padding
            : 116,
        child: IgnorePointer(
          // Blocks tap when search not open
          ignoring: !isSearchOpen,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: isSearchOpen ? 1 : 0,
            child: searchBar,
          ),
        ),
      ),
    );
  }
}
