part of 'app_cubit.dart';
abstract class AppState {}

class AppInitial extends AppState {}
class AppChangeNavigationAppBar extends AppState {}
class AppGetTasksLoadingState extends AppState {}
class AppGetDoneLoadingState extends AppState {}
class AppGetTasksDoneState extends AppState {}
class AppGetDoneDoneState extends AppState {}
class AppInsertTasksDoneState extends AppState {}
class AppAddOrRemoveDoneState extends AppState {}
class AppEditTaskState extends AppState {}
class AppDeleteTaskState extends AppState {}
class AppGetTasksErrorState extends AppState {}
class AppGetDoneErrorState extends AppState {}
