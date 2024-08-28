// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_i/pages/login.dart';
import 'package:provider/provider.dart';
import '../themes/provider_theme.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    //app bar color change
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uiProvider.dark ? Colors.black : Colors.white30,
      ),
      body: SafeArea(child: 
      ListView(
        children: [
          //text
          Padding(
            padding: const EdgeInsets.only(left: 40,top: 10),
            child: Text("Settings",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.indigoAccent),),
          ),
          //line
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30,top: 10),
            child: Divider(thickness: 3,color: Colors.indigoAccent,),
          ),
          //logout
           ListTile(
            title: Text("Logout",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
            subtitle: Text("Click here to logout"),
            contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 50),
            trailing: Icon(Icons.logout_outlined,size: 30,),
            onTap: (){
              //dialogbox
              showDialog(context: context,
               builder: (BuildContext context){
                return AlertDialog(
                  title: Text("Logout"),
                  content: Text("Are you sure you want to logout ?",),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("Cancel")),
                    TextButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> Login()));
                    }, child: Text("Ok"))
                  ],
                );
               }
              );
            },
            )
          ],
        )
      ),
    );
  }
}