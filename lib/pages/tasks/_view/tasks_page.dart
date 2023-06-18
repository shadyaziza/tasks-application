import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/common/app_style.dart';

import '../../../model/task.dart';
import '../../../service/network_service.dart';

/// TODO: 4. Add a side menu or navigation bar with 3 pages (Tasks, Projects and Teams).
///
final tasksProvider = FutureProvider<List<Task>>(
  (
    ref,
  ) async {
    final service = ref.read(networkServiceProvider);
    return (await service.getTasks());
  },
);

class TasksPage extends ConsumerWidget {
  const TasksPage({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return Center(
      child: tasks.when(
        data: (tasks) => Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 500,
                maxWidth: 650,
              ),
              child: _TasksList(
                tasks: tasks,
              ),
            ),
            Expanded(child: child),
          ],
        ),
        error: (error, stackTrace) => Text('$error \n $stackTrace'),
        loading: () => CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tasks',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Divider(
            color: AppStyle.darkBlue,
            thickness: 2,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    tileColor: AppStyle.lightTextColor,
                    title: Text('Task ${tasks[index].id}'),
                    trailing: Text(
                      tasks[index].formatedDateTime,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
