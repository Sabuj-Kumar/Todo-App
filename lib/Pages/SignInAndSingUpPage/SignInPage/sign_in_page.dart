import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_orbit_todo/Models/RegisterModel/register_model.dart';
import 'package:mind_orbit_todo/Pages/AppBars/app_bars.dart';
import 'package:mind_orbit_todo/Pages/HomePage/home_page.dart';
import 'package:mind_orbit_todo/Repositories/sign_up_repositories.dart';
import 'package:mind_orbit_todo/screen_heigt_with.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Bloc/bloc_provider.dart';
import '../../InputForm/input_form.dart';
import '../../NecessaryStrings/necessary_strings.dart';
import '../SignUpPage/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBars(context: context,titleColor: Colors.black87,title: "Sing In Page",bgColor: Colors.white,),
      body: const SingIn(),
    );
  }
}

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  _SingInState createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
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
                        var response = await _apiService.getUser(null,false);
                        bool flag = false;
                        RegistrationModel? _user;
                        for(var v in response){
                          if(v.username == _userNameController.text){
                              flag = true;
                              _user = v;
                              break;
                          }
                        }
                        if(flag){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Log In Successful.")));
                          String? _token,_id;
                          _token = _user?.token!;
                          _id = _user?.id!;
                            pref.setString(token,_token!);
                            pref.setString(id,_id!);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  const HomePage()));
                        }else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid User or Password")));
                          }
                     },
                     child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: HeightWidth(context).screenWidth * 0.05),),
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
                     Text("If You Haven't account? Please.", style: TextStyle(color: Colors.black,fontSize: HeightWidth(context).screenWidth * 0.04),overflow: TextOverflow.ellipsis,),
                     //SizedBox(width: width * 0.0005),
                     GestureDetector(
                       onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));},
                       child: Card(
                         color: Colors.orange,
                           child: Padding(
                             padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                             child: Text("Sign Up",style:  TextStyle(color: Colors.black,fontSize: HeightWidth(context).screenWidth * 0.05),),
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
