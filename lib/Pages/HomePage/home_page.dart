import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Bloc/bloc_provider.dart';
import '../../Bloc/todo_event.dart';
import '../../Bloc/todo_state.dart';
import '../../Models/todo_model.dart';
import '../../screen_heigt_with.dart';
import '../AppBars/app_bars.dart';
import '../DrawerPage/drawer_page.dart';
import '../EditName/first_name_last_name_edit.dart';
import '../InputForm/input_form.dart';
import '../NecessaryStrings/necessary_strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  Future<DateTime?> pickDate(BuildContext context) async{

    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    return newDate;
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final TextEditingController _todoNameController = TextEditingController();
    final TextEditingController _todoDescriptionController = TextEditingController();
    DateTime? date;
    final width = HeightWidth(context).screenWidth;
    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
            drawer: const NavigationDrawer(),
            appBar: AppBars(
                title: "Todo List",
                titleColor: Colors.white,
                bgColor: Colors.deepPurple,
                context: context),

            body: BlocConsumer<TodoBloc,TodoState>(
              bloc: BlocProvider.of<TodoBloc>(context),
              listener: (context, state) {  },
              builder: (context,state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                   child: GestureDetector(
                     onTap: () {
                       setState(() {});
                       scaffoldKey.currentState!.showBottomSheet((context) => StatefulBuilder(
                         builder: (context, setStater) => Column(
                           children: [
                             Padding(
                               padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                               child: Form(
                                 key: _formKey,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     SizedBox(height: width * 0.1),
                                     Text("Name Of Todo",
                                         style: TextStyle(
                                             color: Colors.black, fontSize: width * 0.05)),
                                     SizedBox(height: width * 0.01),
                                     InputForm(
                                       hintText: todoName,
                                       suffixVisibilityIcon: false,
                                       obscureCharacter: '*',
                                       obscured: false,
                                       keyboardType: TextInputType.text,
                                       textInputAction: TextInputAction.next,
                                       controller: _todoNameController,
                                     ),
                                     SizedBox(height: width * 0.05),
                                     Text("Description",
                                         style: TextStyle(
                                             color: Colors.black, fontSize: width * 0.05)),
                                     SizedBox(height: width * 0.01),
                                     InputForm(
                                         hintText: todoDescription,
                                         suffixVisibilityIcon: false,
                                         obscureCharacter: '*',
                                         obscured: false,
                                         keyboardType: TextInputType.text,
                                         textInputAction: TextInputAction.done,
                                         controller: _todoDescriptionController),
                                     SizedBox(height: width * 0.2),
                                     Center(
                                         child: ElevatedButton(
                                             onPressed: () async {
                                               DateTime? _date = await pickDate(context);
                                               setStater(() {
                                                 date = _date;
                                               });
                                               // print("${date?.day}/ ${date?.month}/${date?.year}");
                                             },
                                             child:Text(
                                               date != null ?"${date?.day} / ${date?.month} / ${date?.year}" : "Select Date",
                                               style: TextStyle(
                                                   color: Colors.white, fontSize: width * 0.05),
                                             ))),
                                     Center(
                                         child: ElevatedButton(
                                             onPressed: () async {
                                               BlocProvider.of<TodoBloc>(context).add(AddTodo(todoModel: TodoModel(
                                                   id: _todoNameController.text,
                                                   todoName: _todoNameController.text,
                                                   description: _todoDescriptionController.text,
                                                   todoDone: false,
                                                   date: "${date?.day} / ${date?.month} / ${date?.year}"
                                               )
                                               ));
                                               SharedPreferences pref = await SharedPreferences.getInstance();
                                               pref.setString(todoList,jsonEncode(state.allTodo));
                                               Navigator.pop(context);
                                             },
                                             child: Text(
                                               "Add Todo",
                                               style: TextStyle(
                                                   color: Colors.white, fontSize: width * 0.05),
                                             ))),
                                   ],
                                 ),
                               ),
                             )
                           ],
                         ),
                       ));
                     },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Create New Todo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: HeightWidth(context).screenWidth * 0.05),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => const EditNamePage()));
                      },
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: HeightWidth(context).screenWidth * 0.05),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          maximumSize: Size(
                              HeightWidth(context).screenWidth * 0.8,
                              HeightWidth(context).screenHeight * 0.05)),
                    ),
                  ),
                  SizedBox(height: HeightWidth(context).screenHeight * 0.1)
                ],
              );}
            )));
  }
}
