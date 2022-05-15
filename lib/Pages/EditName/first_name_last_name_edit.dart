import 'package:flutter/material.dart';
import 'package:mind_orbit_todo/Models/RegisterModel/register_model.dart';
import 'package:mind_orbit_todo/Pages/AppBars/app_bars.dart';
import 'package:mind_orbit_todo/Pages/HomePage/home_page.dart';
import 'package:mind_orbit_todo/Repositories/sign_up_repositories.dart';
import 'package:mind_orbit_todo/screen_heigt_with.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../InputForm/input_form.dart';
import '../NecessaryStrings/necessary_strings.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({Key? key}) : super(key: key);

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBars(
          context: context,
          titleColor: Colors.black87,
          title: "Edit First And Last Name",
          bgColor: Colors.white),
      body: const EditName(),
    );
  }
}

class EditName extends StatefulWidget {
  const EditName({Key? key}) : super(key: key);

  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final ApiService _apiService = ApiService();
  String? fName,lName,_id;
  late RegistrationModel reg;
  @override
  void initState() {
    _getName();
    super.initState();
  }
  _getName()async{
    print("aschi");

     SharedPreferences pref = await SharedPreferences.getInstance();

     if(pref.containsKey(id)) {

         _id = pref.getString(id);
         reg = await _apiService.getSingleUser(_id!);

         _firstNameController.text = reg.firstname!;
         _lastNameController.text = reg.lastname!;
     }
  }
  @override
  Widget build(BuildContext context) {

    final width = HeightWidth(context).screenWidth;
    final height = HeightWidth(context).screenHeight;
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: width * 0.1),
                Text("First Name",
                    style:
                        TextStyle(color: Colors.black, fontSize: width * 0.05)),
                SizedBox(height: width * 0.01),
                InputForm(
                  hintText: userNameHint,
                  suffixVisibilityIcon: false,
                  obscureCharacter: '*',
                  obscured: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _firstNameController,
                ),
                SizedBox(height: width * 0.05),
                Text("Last Name",
                    style:
                        TextStyle(color: Colors.black, fontSize: width * 0.05)),
                SizedBox(height: width * 0.01),
                InputForm(
                    hintText: passwordHint,
                    suffixVisibilityIcon: false,
                    obscureCharacter: '*',
                    obscured: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: _lastNameController),
                SizedBox(height: width * 0.1),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {

                      print("$_id");
                      var response = await _apiService.updateUser(_id!,
                          _firstNameController.text,_lastNameController.text);

                      if (response == 200) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Update Successful.")));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomePage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Something Wrong")));
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: HeightWidth(context).screenWidth * 0.05),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        maximumSize: Size(width * 0.8, height * 0.05)),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
