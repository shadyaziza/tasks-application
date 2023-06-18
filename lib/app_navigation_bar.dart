import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/common/app_style.dart';

import 'package:task_list_app/core/utils.dart';
import 'package:task_list_app/localization/providers.dart';

final navItemsProvider = Provider((ref) {
  final loc = ref.watch(appLocalizationsControllerPod);
  return [
    // TODO: labels should be in app localization file
    NavigationBarItem(name: loc.tasks, url: '/tasks'),
    NavigationBarItem(name: loc.projects, url: '/projects'),
    NavigationBarItem(name: loc.teams, url: '/teams'),
  ];
});

/// I am using this now instead of
/// ```
/// final currentLocation = ref.watch(
///      routerProvider.select(
///       (value) => value.location,
///      ),
///    );

/// ```
/// because I noticed wierd behavior with this approach
///
final currentSelectedLocationProvider =
    NotifierProvider<CurrentSelectedLocationProviderNotifier, String>(() {
  return CurrentSelectedLocationProviderNotifier();
});

class CurrentSelectedLocationProviderNotifier extends Notifier<String> {
  @override
  String build() {
    return '/tasks';
  }

  void setCurrentLocation(String url) {
    state = url;
  }
}

class AppNavigationBar extends ConsumerWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navItems = ref.watch(navItemsProvider);
    return ColoredBox(
      color: AppStyle.darkBlue,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 64),
        itemCount: navItems.length,
        itemBuilder: (context, index) => _NavigationBarListItem(
          item: navItems[index],
        ),
        separatorBuilder: (context, index) => const Divider(
          color: AppStyle.mediumBlue,
          height: 1,
          endIndent: 16,
          indent: 16,
        ),
      ),
    );
  }
}

class _NavigationBarListItem extends ConsumerWidget {
  const _NavigationBarListItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final NavigationBarItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(currentSelectedLocationProvider);

    return InkWell(
      onTap: () {
        /// TODO: 3. Implement a navigation (using go_router package) that supports changing urls and back button in the browser.
        context.go(item.url);
        ref
            .read(currentSelectedLocationProvider.notifier)
            .setCurrentLocation(item.url);

        if (Responsive.isMobile(context)) {
          /// in case of mobile view, close the drawer upon selection
          Navigator.of(context).pop();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            16,
          ),
          color: currentLocation == item.url ? AppStyle.orangeColor : null,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          item.name,
          style: const TextStyle(
            color: AppStyle.lightTextColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class NavigationBarItem {
  final String name;
  final String url;

  NavigationBarItem({required this.name, required this.url});
}
