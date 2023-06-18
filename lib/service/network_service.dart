import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/model/task.dart';

final networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

// TODO :  Add Description property to the Task class.
const _desc =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis felis hendrerit, vestibulum dolor a, porttitor massa. Quisque lacinia tempor elit, vitae facilisis elit ornare ut. Ut et molestie tortor. Maecenas nec ipsum quam. Curabitur suscipit tellus at finibus efficitur. Nunc sem ligula, lobortis id maximus a, dignissim sed leo. Suspendisse urna diam, tincidunt ut fringilla sed, commodo quis ante. Vivamus ultrices vulputate arcu, sit amet dictum libero rhoncus nec. Nulla magna sem, tempus vitae egestas sed, tempor vitae felis. Ut tempus, ex in viverra faucibus, ante lorem vestibulum ipsum, eu tincidunt sapien dui vitae turpis. Cras varius lorem blandit quam commodo vulputate. Sed porta nunc eu ipsum consequat iaculis.';

class NetworkService {
  NetworkService();

  Future<List<Task>> getTasks() async {
    final now = DateTime.now();
    return [
      Task(
          id: '1',
          title: 'Read emails from mailbox',
          dateTime: now,
          description: _desc),
      Task(
          id: '2',
          title: 'Check latest news on Flutter',
          dateTime: now,
          description: _desc),
      Task(
          id: '3',
          title: 'Have a call with Flutter team',
          dateTime: now,
          description: _desc),
      Task(
          id: '4',
          title: 'Work on application performance',
          dateTime: now,
          description: _desc),
      Task(
          id: '5',
          title: 'Plan work for next week',
          dateTime: now,
          description: _desc),
      Task(id: '6', title: 'Order lunch', dateTime: now, description: _desc),
      Task(
          id: '7',
          title: 'Create an invoice for last month',
          dateTime: now,
          description: _desc),
    ];
  }
}
