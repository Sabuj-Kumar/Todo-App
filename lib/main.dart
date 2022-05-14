import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_orbit_todo/Bloc/todo_event.dart';
import 'package:mind_orbit_todo/Models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bloc/bloc_provider.dart';
import 'Pages/NecessaryStrings/necessary_strings.dart';
import 'Pages/SplashScreen/splash_screen.dart';

void main() {
  BlocOverrides.runZoned(() => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoBloc()),
      ],
      child: BlocProvider(
        create:(context) => TodoBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context)
                    .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
              ),
              primaryColor: Colors.grey[500]),
          home: const RunPage(),
        ),
      ),
    );
  }
}

class RunPage extends StatefulWidget {
  const RunPage({Key? key}) : super(key: key);

  @override
  State<RunPage> createState() => _RunPageState();
}

class _RunPageState extends State<RunPage> {

  @override
  void initState() {
    _getReadyTodoList();
    super.initState();
  }

  _getReadyTodoList() async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.containsKey(todoList)){
      var list = pref.getString(todoList);
      print("$list");
     for(var item in jsonDecode(list!)){
       BlocProvider.of<TodoBloc>(context).add(AddTodo(todoModel: TodoModel.fromJson(item)));
     }
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
