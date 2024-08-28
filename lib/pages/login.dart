// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_i/model/login_functions.dart';
import 'package:project_i/pages/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    
    String username="geo";
    String password="1";
    final username_controller=TextEditingController();
    final password_controller=TextEditingController();

    void checklogin()async{
      if(username==username_controller.text && password==password_controller.text){
        await savedata(true);
        Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
      }else{
        print("not");
      }
    }

    return Scaffold(
      body: SingleChildScrollView(child:
       SafeArea(
         child: Container(
          padding: EdgeInsets.symmetric(horizontal: 60,vertical: 120),
          child: Column(
            children: [
              //text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome.",style: TextStyle(
                    fontSize: 45,fontWeight: FontWeight.bold,
                    letterSpacing: 6,),),
                    Text("back",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                ],
              ),
              //lines
              Divider(thickness: 2,indent: 50,endIndent: 50,
              color: Colors.blue,height: 10,),
         
              Divider(thickness: 2,indent: 20,endIndent: 20,
              color: Colors.blue,height: 0,),
         
              SizedBox(height: 50,),  
              //username  
              TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person)
                ),
              ),
         
              SizedBox(height: 30,),
              //password
              TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.lock)
                ),obscureText: true,
              ),
         
              SizedBox(height: 70,),
              //button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Signup",style: TextStyle(fontSize: 30,
                  fontWeight: FontWeight.w700,color: Colors.indigo,
                  letterSpacing: 2.5),),
         
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: IconButton(onPressed: (){
                      checklogin();
                    }, 
                    icon: Icon(Icons.arrow_forward,size: 35,color: Colors.grey[900],)),
                  ), 
                ],
              ), 
            ],
          ),
         ),
       )
      ),
    );
  }
}