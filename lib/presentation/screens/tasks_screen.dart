import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/app_cubit/app_cubit.dart';
import 'package:todo_app/presentation/views/tasks_list_builder.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late List<Map> tasksList;
  @override
  void didChangeDependencies() {
    tasksList = AppCubit.get(context).tasks;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return TasksListBuilder(
          tasks: tasksList,
          noTasksText: "No Inserted Tasks Yet..",
          taskType: "all",
        );
      },
    );
  }
}
