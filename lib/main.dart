import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/core/router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// TODO: 3. Implement a navigation (using go_router package) that supports changing urls and back button in the browser.

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Task list App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
