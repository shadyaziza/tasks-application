import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/localization/providers.dart';

class TeamsPage extends ConsumerWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(appLocalizationsControllerPod);
    return Center(
      // TODO: labels should be in app localization file
      child: Text(loc.teams),
    );
  }
}
