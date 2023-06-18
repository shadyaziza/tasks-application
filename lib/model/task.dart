import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String? id,
    required String? title,
    required DateTime? dateTime,
    // TODO :  Add Description property to the Task class.
    required String? description,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

/// Extension to convert data on [Task]
extension TaskX on Task {
  String get formatedDateTime {
    return '${DateFormat.Md().format(dateTime!)}, ${DateFormat.Hm().format(dateTime!)}';
  }
}
