import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/app_navigation_bar.dart';
import 'package:task_list_app/localization/change_locale_widget.dart';
import 'package:task_list_app/localization/providers.dart';

// This class does not have to be used. It should be replaced with class
// handling navigation using go_router package

/// TODO: 3. Implement a navigation (using go_router package) that supports changing urls and back button in the browser.
/// [HomePage] is our AppShell
///
class HomePage extends ConsumerWidget {
  const HomePage({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// TODO: 7. Make the application suitable for internationalization.
    ///
    final loc = ref.watch(appLocalizationsControllerPod);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.tasksApplication),
        actions: [
          ChangeLocaleWidget(),
        ],
      ),
      body: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 200, maxWidth: 300),
            child: AppNavigationBar(),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
