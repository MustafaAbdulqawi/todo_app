import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/business_logic/app_cubit/app_cubit.dart';
import 'package:todo_app/presentation/views/edit_dialog.dart';
import 'package:todo_app/presentation/widgets/default_text.dart';

class TasksListItem extends StatelessWidget {
  final Map tasksModel;
  const TasksListItem({super.key, required this.tasksModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 3.w, end: 3.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: Colors.blue,
          ),
          height: 10.h,
          width: 90.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 2.w,top: 3.5.h),
                child: SizedBox(
                  height: 8.h,
                  width: 55.w,
                  child: DefaultText(
                    text: tasksModel["task"],
                    textSize: 14.sp,
                    weight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,

                  ),
                ),
              ),
              Visibility(
                visible: tasksModel["type"] == "done",
                replacement: IconButton(
                  onPressed: () {
                    AppCubit.get(context).addOrRemoveDone(
                      type: "done",
                      id: tasksModel["id"],
                    );
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                  ),
                ),

                child: IconButton(
                  onPressed: () {
                    AppCubit.get(context).addOrRemoveDone(
                      type: "all",
                      id: tasksModel["id"],
                    );
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).editTasks(
                    task: tasksModel["task"],
                    id: tasksModel["id"],
                  );
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => EditDialog(taskModel: tasksModel),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await AppCubit.get(context).deleteTasks(
                    id: tasksModel["id"],
                  );
                  Fluttertoast.showToast(
                      msg: "Deleted",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
