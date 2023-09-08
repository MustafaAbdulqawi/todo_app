import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/business_logic/app_cubit/app_cubit.dart';
import 'package:todo_app/presentation/views/tasks_list_builder.dart';
import 'package:todo_app/presentation/widgets/default_text.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  late List<Map> doneList;
  @override
  void didChangeDependencies() {
    doneList = AppCubit.get(context).done;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
  builder: (context, state) {
    return TasksListBuilder(
      tasks: doneList,
      noTasksText: "No Tasks Done",
      taskType: "done",
    );
  },
);
  }
}
