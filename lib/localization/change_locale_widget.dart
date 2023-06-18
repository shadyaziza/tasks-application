import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../localization/localization.dart';

class ChangeLocaleWidget extends HookConsumerWidget {
  const ChangeLocaleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return AppLocalizations.supportedLocales
            .map(
              (Locale locale) => PopupMenuItem(
                onTap: () => ref
                    .read(appLocalizationsControllerPod.notifier)
                    .setLocale(locale),
                child: Row(
                  children: [
                    Text(locale.uiString),
                    const Spacer(),
                    Icon(
                      Icons.check,
                      color: ref
                              .read(appLocalizationsControllerPod.notifier)
                              .isSameLocale(locale.languageCode)
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            )
            .toList();
      },
    );
  }
}
