

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {

  getuser() async {
    var users=[];
    var response= await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    for(var i in jsonData){
      userModel user = userModel(i["name"],i["username"],i["email"]);
      users.add(user);

    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getuser(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return
            ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context,i){
                  return ListTile(title: Text(snapshot.data[i].name),);
                }
            );
          }
          else return  Container(child: Text('Nothing in API'),);



        },
      )

    );
  }
}

class userModel{
  var name;
  var userName;
  var email;

  userModel(this.name,this.email,this.userName);
}
