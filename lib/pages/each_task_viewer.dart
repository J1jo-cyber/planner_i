// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_i/themes/provider_theme.dart';
import 'package:provider/provider.dart';

class EachTask extends StatelessWidget {
  final String tsktitle;
  final String tsknote;
  final String tskdate;
        String tskprio;
        bool iscomplete;

  EachTask({super.key,
  required this.tsktitle,
  required this.tsknote,
  required this.tskdate,
  required this.tskprio,
  required this.iscomplete
  });

  @override
  Widget build(BuildContext context) {
    final uiProvider=Provider.of<UiProvider>(context);
    return AlertDialog(
      backgroundColor: uiProvider.dark ? Colors.grey[900] : Colors.white,
      content: Container(
        height: 500, width: 300,
        child: Column(
          children: [
            Row(
              children: [
              //priority
              Container(
                padding: EdgeInsets.only(left: 9,right: 9,top: 5,bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (tskprio=="No priority") ? Colors.transparent
                              :iscomplete ? Colors.green
                              :(tskprio=="Low")
                              ? Colors.red
                              :(tskprio=="Medium")
                              ? Colors.amber
                              :(tskprio=="High")
                              ? Colors.blue
                              :(tskprio=="Urgent")
                              ? Colors.cyan
                              : Colors.transparent
                ),child: Text(tskprio,style: TextStyle(
                  fontSize: 13,fontWeight: FontWeight.bold,
                  decoration: iscomplete ? TextDecoration.lineThrough : TextDecoration.none
                ),),
              ),
              Spacer(),
              //more icon button
              IconButton(onPressed: (){
                PopupMenuButton(itemBuilder: (context)=>[
                  PopupMenuItem(child: Text("data"))
                ]
                );
              }, icon: Icon(Icons.more_vert))
            ],),
            SizedBox(height: 15,),
            //task title
            Text(tsktitle,style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold,
              decoration: iscomplete ? TextDecoration.lineThrough : TextDecoration.none
            ),),
            Divider(thickness: 3,height: 20,),
            //descrition / notes
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10),
                      child: Text(tsknote,style: TextStyle(
                        fontSize: 15,fontWeight: FontWeight.w500,
                        decoration: iscomplete ? TextDecoration.lineThrough : TextDecoration.none
                      ),),
                    )
                  ],),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(iscomplete ? "Completed" : 
                    "Not Completed",style: TextStyle(
                      fontSize: 15,fontWeight: FontWeight.bold,
                      color: iscomplete ? Colors.green : Colors.red
                    ),
                    )),
                ),  
                Spacer(),
                //task date
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(tskdate,style: TextStyle(
                    fontSize: 13,fontWeight: FontWeight.bold,
                    decoration: iscomplete ? TextDecoration.lineThrough : TextDecoration.none
                    ),),
                  ),
                )
            ])
          ],
        ),
      ),
    );
  }
}