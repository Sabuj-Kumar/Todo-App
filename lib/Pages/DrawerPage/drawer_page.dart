import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mind_orbit_todo/Bloc/bloc_provider.dart';
import 'package:mind_orbit_todo/Bloc/todo_state.dart';
import 'package:mind_orbit_todo/Models/todo_model.dart';
import 'package:mind_orbit_todo/screen_heigt_with.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Bloc/todo_event.dart';
import '../InputForm/input_form.dart';
import '../NecessaryStrings/necessary_strings.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool doneOrNot = false;
  bool stopOrNot = false;
  bool failedOrNot = false;
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

  @override
  Widget build(BuildContext context) {
    final height = HeightWidth(context).screenHeight;
    final width = HeightWidth(context).screenWidth;
    final TextEditingController _todoNameController = TextEditingController();
    final TextEditingController _todoDescriptionController = TextEditingController();
    DateTime? date;
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.grey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.1),
              Text(
                "Todo List",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.08,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(height: height * 0.05),
              BlocConsumer<TodoBloc, TodoState>(
                  builder: (context, state) => Expanded(
                        child: ListView.builder(
                            itemCount: state.allTodo.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: state.allTodo[index].todoDone!
                                            ? Colors.deepPurple
                                            : Colors.grey,
                                      ),

                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: width * 0.02,vertical: width * 0.02),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${state.allTodo[index].todoName}",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: width * 0.03),
                                                ),
                                                SizedBox(height: height * 0.02),
                                                Text(
                                                    "${state.allTodo[index].description}",
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize:
                                                            width * 0.03)),
                                            SizedBox(height: height * 0.02),
                                                Text(
                                                    "${state.allTodo[index].date}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            width * 0.03)),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Align(
                                                  alignment:Alignment.centerRight,
                                                  child: FlutterSwitch(
                                                      value: state.allTodo[index]
                                                          .todoDone!,
                                                      width: 30.0,
                                                      height: 20.0,
                                                      valueFontSize: 8.0,
                                                      toggleSize: 6.0,
                                                      borderRadius: 10.0,
                                                      padding: 2.0,
                                                      showOnOff: true,
                                                      onToggle: (val) async{
                                                        BlocProvider.of<TodoBloc>(
                                                                context)
                                                            .add(DoneOrNotDone(
                                                                todoModel:
                                                                    state.allTodo[
                                                                        index]));
                                                        SharedPreferences pref = await SharedPreferences.getInstance();
                                                        await pref.remove(todoList);
                                                        pref.setString(todoList,jsonEncode(state.allTodo));
                                                      }),
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      primary: Colors.red,
                                                      minimumSize: Size(width * 0.001 , height * 0.0002)
                                                    ),
                                                    onPressed: () async{
                                                      BlocProvider.of<TodoBloc>(
                                                              context)
                                                          .add(DeleteTodo(
                                                              todoModel:
                                                                  state.allTodo[
                                                                      index]));
                                                      SharedPreferences pref = await SharedPreferences.getInstance();
                                                      pref.setString(todoList,jsonEncode(state.allTodo));
                                                    },
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              width * 0.025),
                                                    )),
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Colors.green,
                                                        minimumSize: Size(width * 0.001 , height * 0.0002)
                                                    ),
                                                    onPressed: () async{
                                                      setState(() {});
                                                      _todoNameController.text = state.allTodo[index].todoName!;
                                                      _todoDescriptionController.text = state.allTodo[index].description!;
                                                      Navigator.pop(context);
                                                      showBottomSheet(context: context, builder: (context) => StatefulBuilder(
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
                                                                              print("${date?.day}/ ${date?.month}/${date?.year}");
                                                                            },
                                                                            child:Text(
                                                                              date?.year != null ?"${date?.day} / ${date?.month} / ${date?.year}" : "Select Date",
                                                                              style: TextStyle(
                                                                                  color: Colors.white, fontSize: width * 0.05),
                                                                            ))),
                                                                    Center(
                                                                        child: ElevatedButton(
                                                                            onPressed: () async {
                                                                              BlocProvider.of<TodoBloc>(context).add(EditTodo(todoModel: TodoModel(
                                                                                  id: _todoNameController.text,
                                                                                  todoName: _todoNameController.text,
                                                                                  description: _todoDescriptionController.text,
                                                                                  todoDone: state.allTodo[index].todoDone,
                                                                                  date: date == null ? state.allTodo[index].date: "${date?.day} / ${date?.month} / ${date?.year}"
                                                                              ), previousTodo: state.allTodo[index],
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
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                          width * 0.025),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    )
                                  ],
                                )),
                      ),
                  listener: (context, state) {})
            ],
          ),
        ),
      ),
    );
  }
}
