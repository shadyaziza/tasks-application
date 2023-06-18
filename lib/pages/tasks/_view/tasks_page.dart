// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/common/app_style.dart';
import 'package:task_list_app/core/router.dart';
import 'package:task_list_app/core/utils.dart';

import '../../../model/task.dart';
import '../../../service/network_service.dart';

/// TODO: 4. Add a side menu or navigation bar with 3 pages (Tasks, Projects and Teams).
///
///
/// TODO: Use _getTasks_ method from _network_service.dart_ file to get data for the _Tasks_ page.
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
        data: (tasks) => ResponiveTasks(
          tasks: tasks,
          child: child,
        ),
        error: (error, stackTrace) => Text('$error \n $stackTrace'),
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class ResponiveTasks extends StatelessWidget {
  const ResponiveTasks({
    super.key,
    required this.child,
    required this.tasks,
  });
  final Widget child;
  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return _TasksMobileView(
        tasks: tasks,
        child: child,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 500,
              maxWidth: 650,
            ),
            child: _TasksList(
              tasks: tasks,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _TasksList extends ConsumerWidget {
  const _TasksList({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTaskLocation =
        ref.watch(routerProvider.select((value) => value.location));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tasks',
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
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () => context.goNamed(AppRouter.kRouteNameTaskDetails,
                      pathParameters: {'taskId': tasks[index].id!}),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                  ),
                  tileColor: AppStyle.lightTextColor,
                  title: Text(
                    'Task ${tasks[index].id}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: currentTaskLocation
                                  .contains('tasks/${tasks[index].id}')
                              ? FontWeight.bold
                              : null,
                        ),
                  ),
                  trailing: Text(
                    tasks[index].formatedDateTime,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class _TasksMobileView extends ConsumerStatefulWidget {
  const _TasksMobileView({super.key, required this.tasks, required this.child});
  final List<Task> tasks;
  final Widget child;

  @override
  ConsumerState<_TasksMobileView> createState() => _TasksMobileViewState();
}

class _TasksMobileViewState extends ConsumerState<_TasksMobileView> {
  late Task selectedTask;
  @override
  void initState() {
    selectedTask = widget.tasks.firstWhere((t) => t.id == '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<Task>(
            value: selectedTask,
            items: widget.tasks
                .map(
                  (t) => DropdownMenuItem<Task>(
                    value: t,
                    child: Text(
                      'Task ${t.id}',
                    ),
                  ),
                )
                .toList(),
            onChanged: (t) {
              context.goNamed(AppRouter.kRouteNameTaskDetails,
                  pathParameters: {'taskId': t!.id!});

              /// needed to update ephemeral state
              setState(() {
                selectedTask = t;
              });
            }),
        Expanded(child: widget.child)
      ],
    );
  }
}
