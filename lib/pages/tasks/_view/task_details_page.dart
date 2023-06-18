import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/service/network_service.dart';

import '../../../model/task.dart';

/// TODO: 4. Add a side menu or navigation bar with 3 pages (Tasks, Projects and Teams).
///

final taskDetailsProvider = FutureProviderFamily<Task?, int>(
  (ref, int taskId) async {
    final service = ref.read(networkServiceProvider);
    return (await service.getTasks()).firstWhere(
      (t) => t.id == taskId,
      orElse: () => throw UnimplementedError(
        'There is not task of id = $taskId',
      ),
    );
  },
);

class TasksDetailsPage extends StatelessWidget {
  const TasksDetailsPage({Key? key, required this.taskId})
      // this check is for when we debug the app and completely froget to pass this param in pathParamters
      // we can mitigate this by simply using generated routes from go_router to ensure typed params if prefered
      : assert(taskId >= 1),
        super(key: key);

  final int taskId;
  @override
  Widget build(BuildContext context) {
    return Center(
      // TODO: labels should be in app localization file
      child: Text('Tasks Details $taskId'),
    );
  }
}
