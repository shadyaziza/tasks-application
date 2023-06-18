import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/service/network_service.dart';

import '../../../common/app_style.dart';
import '../../../model/task.dart';

/// TODO: 4. Add a side menu or navigation bar with 3 pages (Tasks, Projects and Teams).
///

/// TODO: 5. Use _getTasks_ method from _network_service.dart_ file to get data for the _Tasks_ page.
///
final taskDetailsProvider = FutureProviderFamily<Task?, int>(
  (ref, int taskId) async {
    final service = ref.read(networkServiceProvider);
    return (await service.getTasks()).firstWhere(
      (t) => t.id == taskId.toString(),
      orElse: () => throw UnimplementedError(
        'There is not task of id = $taskId',
      ),
    );
  },
);

class TasksDetailsPage extends ConsumerWidget {
  const TasksDetailsPage({Key? key, required this.taskId})
      // this check is for when we debug the app and completely froget to pass this param in pathParamters
      // we can mitigate this by simply using generated routes from go_router to ensure typed params if prefered
      : assert(taskId >= 1),
        super(key: key);

  final int taskId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskDetailsProvider(taskId));
    return Center(
      child: task.when(
        data: (task) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task $taskId',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Divider(
                color: AppStyle.darkBlue,
                height: 16,
                thickness: 2,
              ),
              const SizedBox(
                height: 32,
              ),
              Text(task!.formatedDateTime,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey.shade600,
                      )),
              const SizedBox(
                height: 8,
              ),
              Text(
                task.description!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => Text('$error \n $stackTrace'),
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
