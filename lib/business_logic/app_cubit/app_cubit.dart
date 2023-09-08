import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/screens/done_screen.dart';
import 'package:todo_app/presentation/screens/tasks_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  int currentIndex = 0;
  void changeNavigationAppBar(int index){
    currentIndex = index;
    emit(AppChangeNavigationAppBar());
  }
  List<String>titles = [
    "Tasks",
    "Done",
  ];
  List<Widget> screens = [
    const TasksScreen(),
    const DoneScreen(),
  ];
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<Map> tasks = [];
  List<Map> done = [];
  void createDatabase(){
    getTasks();
    getDone();
  }
  void getTasks()async{
    emit(AppGetTasksLoadingState());

    await fireStore.collection("tasks").get().then((value) {
      tasks.clear();
      for(QueryDocumentSnapshot<Map<String ,dynamic>> element in value.docs){
        tasks.add(element.data());
      }
      emit(AppGetTasksDoneState());

    }).catchError((error){
      if (kDebugMode) {
        print(error);
      }
      emit(AppGetTasksErrorState());
    });
  }
  void getDone()async{
    emit(AppGetDoneLoadingState());
    await fireStore.collection("tasks").where("type" , isEqualTo: "done").get().then((value) {
      done.clear();
      for(QueryDocumentSnapshot<Map <String , dynamic>>element in value.docs){
        tasks.add(element.data());
      }
      emit(AppGetDoneDoneState());
    }).catchError((error){
      if (kDebugMode) {
        print(error);
      }
      emit(AppGetDoneErrorState());
    });
  }
  Future<void> insertTasks({
    required String task,
})async {
    int uniqueId = DateTime.now().millisecondsSinceEpoch;
    await fireStore.collection("tasks").doc(uniqueId.toString()).set({
      "id":uniqueId,
      "task": task,
      "type": "all",
    }).then((value) {
      emit(AppInsertTasksDoneState());
      getTasks();
      getDone();
    });
  }
  void addOrRemoveDone({
    required String type,
    required int id,
})async{
    await fireStore.collection("tasks").doc(id.toString()).update({"type": type}).then((value) {
      emit(AppAddOrRemoveDoneState());
      getTasks();
      getDone();
    });
  }
  Future<void> editTasks({
    required String task,
    required int id,
})async {
    await fireStore.collection("tasks").doc(id.toString()).update({
      "task": task,
    }).then((value) {
      emit(AppEditTaskState());
      getDone();
      getTasks();
    });
  }
  Future<void>deleteTasks({
    required int id,
})async{
    await fireStore.collection("tasks").doc(id.toString()).delete().then((value) {
      emit(AppDeleteTaskState());
      getTasks();
      getDone();
    });
  }
}
