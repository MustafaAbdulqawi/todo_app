import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/presentation/views/tasks_list_item.dart';
import 'package:todo_app/presentation/widgets/default_lists_separator.dart';
import 'package:todo_app/presentation/widgets/default_text.dart';

class TasksListBuilder extends StatelessWidget {
  final List<Map> tasks;
  final String noTasksText;
  final String taskType;
  const TasksListBuilder({
    super.key,
    required this.tasks,
    required this.noTasksText,
    required this.taskType,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_accounts,
              size: 50.sp,
              color: Colors.blue,
            ),
            DefaultText(
              text: noTasksText,
              textSize: 20.sp,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
      visible: tasks.isNotEmpty,
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 1.h),
        child: ListView.separated(
          itemBuilder: (context, index) => TasksListItem(
            tasksModel: tasks[index],
          ),
          separatorBuilder: (context, index) =>  const DefaultListsSeparator(),
          itemCount: tasks.length,
        ),
      ),
    );
  }
}
