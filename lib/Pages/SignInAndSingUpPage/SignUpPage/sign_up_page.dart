import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_orbit_todo/Pages/AppBars/app_bars.dart';
import 'package:mind_orbit_todo/screen_heigt_with.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Bloc/bloc_provider.dart';
import '../../../Models/data_model.dart';
import '../../../Repositories/sign_up_repositories.dart';
import '../../InputForm/input_form.dart';
import '../../NecessaryStrings/necessary_strings.dart';
import '../SignInPage/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBars(context: context,titleColor: Colors.black87,title: "Sing Up Page",bgColor: Colors.white,),
      body: const SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    final width = HeightWidth(context).screenWidth;
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
                Text("First Name",style: TextStyle(color: Colors.black,fontSize: width * 0.05 )),
                SizedBox(height: width * 0.01),
                InputForm(
                    hintText: firstNameHint,
                    suffixVisibilityIcon: false,
                    obscureCharacter: '*',
                    obscured: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    controller: _firstNameController),
                SizedBox(height: width * 0.05),
                Text("Last Name",style: TextStyle(color: Colors.black,fontSize: width * 0.05 )),
                SizedBox(height: width * 0.01),
                InputForm(
                  hintText: lastNameHint,
                  suffixVisibilityIcon: false,
                  obscureCharacter: '*',
                  obscured: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller:_lastNameController,
                ),
                SizedBox(height: width * 0.05),
                Text("User Name",style: TextStyle(color: Colors.black,fontSize: width * 0.05 )),
                SizedBox(height: width * 0.01),
                InputForm(
                  hintText: userNameHint,
                  suffixVisibilityIcon: false,
                  obscureCharacter: '*',
                  obscured: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _userNameController,
                ),
                SizedBox(height: width * 0.05),
                Text("Password",style: TextStyle(color: Colors.black,fontSize: width * 0.05 )),
                SizedBox(height: width * 0.01),
                InputForm(
                    hintText: passwordHint,
                    suffixVisibilityIcon: true,
                    obscureCharacter: '*',
                    obscured: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: _passController),
                SizedBox(height: width * 0.1),
                Center(
                  child: ElevatedButton(
                    onPressed: ()async{
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      Data data = Data();
                      setState(() {
                        data.firstName = _firstNameController.text;
                        data.lastName = _lastNameController.text;
                        data.userName = _userNameController.text;
                        data.password = _passController.text;
                        data.token = jwtToken;
                      });
                      bool flag = true;
                      var res = await _apiService.getUser(null,false);

                      for(var v in res){
                        if(v.username == _userNameController.text){
                          flag = false;
                          break;
                        }
                      }
                      if(flag) {
                        final response = await _apiService.createUser(data);
                        if (response == '201') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Registration Successful"))
                          );
                          pref.setString(firstName,_firstNameController.text);
                          pref.setString(lastName,_lastNameController.text);
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx) => const SignInPage()));
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("User Name Already Taken. "))
                        );
                      }
                    },
                    child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: HeightWidth(context).screenWidth * 0.05),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        maximumSize: Size(HeightWidth(context).screenWidth * 0.8,HeightWidth(context).screenHeight * 0.05)
                    ),
                  ),
                ),
                SizedBox(height: width * 0.1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("If You Haven account? Please.", style: TextStyle(color: Colors.black,fontSize: HeightWidth(context).screenWidth * 0.04),overflow: TextOverflow.ellipsis,),
                    //SizedBox(width: width * 0.0005),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx) => const SignInPage()));
                      },
                      child: Card(
                          color: Colors.orange,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                            child: Text("Sign In",style:  TextStyle(color: Colors.black,fontSize: HeightWidth(context).screenWidth * 0.05),),
                          )),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
