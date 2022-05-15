import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:mind_orbit_todo/Models/RegisterModel/register_model.dart';
import '../Models/data_model.dart';
import '../Pages/NecessaryStrings/necessary_strings.dart';

class ApiService {

    Future<String> createUser(Data data) async{

        final response = await http.post(
            Uri.parse(baseApiLink),
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String,String>{
                "firstname": data.firstName!,
                "lastname":data.lastName!,
                "username":data.userName!,
                "password":data.password!,
                "token":data.token! + " " + data.userName!
            }),
        );
        if (response.statusCode == 201){
            return "201";
        }else{
            return  "202";
        }
    }
    
    Future<List<RegistrationModel>> getUser(int? id,bool flag)async{

        if(flag == false) {
            final response = await http.get(
                Uri.parse(baseApiLink),
            );
            if (response.statusCode == 200) {

                List<RegistrationModel> list = [];
                for(var element in json.decode(response.body)){
                    list.add(RegistrationModel.fromJson(element));
                }
                return list;
            }
            else {
                throw Exception('Failed to load album');
            }
        }else{
            final response = await http.get(
                Uri.parse(baseApiLink+"/:${id!}"),
            );
            if (response.statusCode == 200) {
                List<RegistrationModel> list = [];

                for(var element in json.decode(response.body)){
                    list.add(RegistrationModel.fromJson(element));
                }
                return list;
            }
            else {
                throw Exception('Failed to load');
            }
        }
    }

    Future<RegistrationModel> getSingleUser(String id)async{
        print("repo $id");

       try {
           final response = await http.get(
               Uri.parse(baseApiLink + "/:$id"),
           );

           if (response.statusCode == 200) {
               return RegistrationModel.fromJson(jsonDecode(response.body));
           }
           else {
               throw Exception('Failed to load');
           }
       }catch(e){
           throw Exception(e);
       }
    }

    Future<int> updateUser(String id,String? firstName,String? lastName)async{

        try{
            final response = await http.put(
                Uri.parse(baseApiLink + "/:$id"),
                headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String,String>{
                    "firstname":firstName!,
                    "lastname":lastName!,
                }),
            );
            if (response.statusCode == 200) {

                return 200;
            }
            else {
                throw Exception('Failed to load');
            }}
            catch(e){
                throw Exception(e);
        }
    }
}