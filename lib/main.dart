import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/business_logic/app_cubit/app_cubit.dart';
import 'package:todo_app/presentation/router/app_router.dart';

import 'core/my_bloc_observer.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (context) => AppCubit()..createDatabase(),
          child: MaterialApp(
            title: 'ToDo App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}