import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/business_logic/app_cubit/app_cubit.dart';
import 'package:todo_app/presentation/widgets/default_text.dart';

class EditDialog extends StatefulWidget {
  final Map taskModel;
  const EditDialog({super.key, required this.taskModel});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController taskController = TextEditingController(text: widget.taskModel["task"]);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h),
      child: Column(
        children: [
          Dialog(
            child: Form(
              key: _formKey,
              child: Container(
                height: 20.h,
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.sp),
                  color: Colors.blue,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 1.h, start: 1.w, end: 1.w),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.text,
                        controller: taskController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.title_outlined,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.5.sp,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5.sp,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5.sp,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1.5.sp,
                              ),
                            ),
                            hintText: "Edit task",
                            hintStyle: const TextStyle(color: Colors.white)),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "contacts can't be empty...";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 3.6.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: DefaultText(
                              text: "Cancel",
                              textSize: 14.sp,
                              textColor: Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: ()async{
                              await AppCubit.get(context).editTasks(task: taskController.text, id: widget.taskModel["id"],);
                              if(mounted) {
                                Navigator.pop(context);
                              }
                              Fluttertoast.showToast(
                                  msg: "Modified",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            },
                            child: DefaultText(
                              text: "Save",
                              textSize: 14.sp,
                              textColor: Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
