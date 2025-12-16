import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final String title;
  final bool loading;
  final Widget child;
  final double expandHeight;

  const AuthScaffold({
    super.key,
    required this.title,
    required this.loading,
    required this.child,
    required this.expandHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: expandHeight,
              flexibleSpace: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  if (loading) const LinearProgressIndicator(),
                  Padding(padding: const EdgeInsets.all(16), child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
