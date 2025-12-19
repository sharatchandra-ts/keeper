import 'package:flutter/material.dart';
import 'package:keeper/enums/app_enums.dart';

class AppText extends StatelessWidget {
  final String text;
  final String? query;
  final TextStyle? style;
  final TextStyle? highlightedStyle;
  final TextType mode;

  const AppText._(
    this.text, {
    super.key,
    this.style,
    required this.mode,
    this.highlightedStyle,
    this.query,
  });

  factory AppText(String text, {Key? key, TextStyle? style}) {
    return AppText._(text, key: key, style: style, mode: TextType.normal);
  }

  factory AppText.highlighted(
    String text,
    String query, {
    Key? key,
    TextStyle? style,
    TextStyle? highlightedStyle,
  }) {
    return AppText._(
      text,
      key: key,
      style: style,
      query: query,
      highlightedStyle: highlightedStyle,
      mode: TextType.highlighted,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case TextType.normal:
        return Text(text, style: style);

      case TextType.highlighted:
        return _highlightText(
          text,
          query ?? '',
          normalStyle: style,
          highlightStyle: highlightedStyle,
        );
    }
  }

  Widget _highlightText(
    String text,
    String query, {
    TextStyle? normalStyle,
    TextStyle? highlightStyle,
  }) {
    if (query.isEmpty) {
      return Text(text, style: normalStyle);
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final startIndex = lowerText.indexOf(lowerQuery);

    if (startIndex == -1) {
      return Text(text, style: normalStyle);
    }

    final endIndex = startIndex + query.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: text.substring(0, startIndex), style: normalStyle),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: highlightStyle,
          ),
          TextSpan(text: text.substring(endIndex), style: normalStyle),
        ],
      ),
    );
  }
}
