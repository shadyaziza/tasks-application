import 'package:caching/utility.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/core/router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'localization/providers.dart';

Future<void> main() async {
  /// TODO: 7. Make the application suitable for internationalization.
  ///
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefInstance = await sharedPreferencesInstance;
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesPod.overrideWithValue(sharedPrefInstance),
      ],
      child: const MyApp(),
    ),
  );
}

/// TODO: 3. Implement a navigation (using go_router package) that supports changing urls and back button in the browser.
///
/// TODO: 7. Make the application suitable for internationalization.
///

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    ref.watch(appLocalizationsControllerPod);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.read(appLocalizationsControllerPod.notifier).currentLocale,
      routerConfig: router,
      title: 'Task list App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
