import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/business_logic/app_cubit/app_cubit.dart';
import 'package:todo_app/presentation/widgets/default_text.dart';
import 'package:todo_app/presentation/widgets/default_text_button.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  TextEditingController taskController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AppCubit cubit;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    cubit = AppCubit.get(context)
      ..createDatabase();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AppGetTasksLoadingState) {
          // Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: DefaultText(
              text: cubit.titles[cubit.currentIndex],
              textColor: Colors.white,
              weight: FontWeight.bold,
              textSize: 20.sp,
            ),
          ),
          body: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              if(state is AppGetTasksLoadingState|| state is AppGetDoneLoadingState){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is AppGetTasksErrorState || state is AppGetDoneErrorState){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error,
                      size: 70.sp,
                      color: Colors.red,
                    ),
                    DefaultText(text: "Error",
                      textSize: 20.sp,
                      textColor: Colors.red,
                    ),
                  ],
                );
              }else{
                return cubit.screens[cubit.currentIndex];
              }

            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            currentIndex: cubit.currentIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: (index) => cubit.changeNavigationAppBar(index),
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: cubit.titles[0]),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.done), label: cubit.titles[1]),
            ],
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            elevation: 1,
            backgroundColor: Colors.blue,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.showBottomSheet((context) {
                return Wrap(
                  children: [
                    Container(
                      color: Colors.blue,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
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
                                  hintText: "Add task",
                                  hintStyle:
                                  const TextStyle(color: Colors.white)),
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "contacts can't be empty...";
                                }
                                return null;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DefaultTextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: DefaultText(
                                    text: "Cancel",
                                    textColor: Colors.white,
                                    textSize: 13.sp,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                DefaultTextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.pop(context);
                                      await AppCubit.get(context).insertTasks(
                                          task: taskController.text);
                                      taskController.text = "";
                                    }
                                  },
                                  child: DefaultText(
                                    text: "Add",
                                    textColor: Colors.white,
                                    textSize: 13.sp,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
            },
          ),
        );
      },
    );
  }
}
