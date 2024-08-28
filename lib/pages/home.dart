// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_i/pages/about.dart';
import 'package:project_i/pages/display_task.dart';
import 'package:project_i/pages/privacypolicy.dart';
import 'package:project_i/pages/settings.dart';
import 'package:project_i/pages/taskadd.dart';
import 'package:provider/provider.dart';
import '../themes/provider_theme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_i/model/storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //box reference
  final box=Hive.box('storage');
  //storage class instance
  Storage db=Storage();
  
  //checkbox on off
  void checkboxchange(bool? value,int index){
    setState(() {
      db.tasklist[index][0]=!db.tasklist[index][0];
      //updaing db
      db.updatedata();
    });
  }
  //save task from taskadd to list
  void savetotask()async {
    //navigate to the Taskadd page and wait for the result
      await Navigator.push(context,MaterialPageRoute(builder: (context)=>
      Taskadd(
          onSave: (taskData) {
            //updating the task list with the new task data
            setState(() {
              db.tasklist.add([
                false,
                taskData['title'],
                taskData['note'],
                taskData['date'],
                taskData['priority']
              ]);
              db.updatedata();
            });
          },
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    
    //appbar color change
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      //appbar
      appBar: AppBar(
        shadowColor: uiProvider.dark ? Colors.indigo : Colors.grey[900],
        elevation: 15,
        backgroundColor: uiProvider.dark ? Colors.grey[900] : Colors.indigo,
        //menu button
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            },
             icon:Icon(Icons.menu),color: Colors.white,
             tooltip: "Menu",
             );
          }
        ),
         //text
         title: Text("Planner l",style:TextStyle(
          color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600,letterSpacing: 2)),
          //action/end
          actions: [
            IconButton(onPressed: (){
              
            }, icon: Icon(Icons.search),color: Colors.white,
            tooltip: "Search",
            )
          ],
      ),
      //body
      body: SafeArea(child: 
      Stack(
        children:[
          //gridview task using cards
          GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: db.tasklist.length,
           itemBuilder: (context,index){
           return Tasks(
            istaskcompleted: db.tasklist[index][0],
            taskname: db.tasklist[index][1],
            tasknote: db.tasklist[index][2],
            taskdate: db.tasklist[index][3],
            taskpriority: db.tasklist[index][4],
            onchange: (value){
              checkboxchange(value, index);
             },
           );
           })  
        ]
      ),
     ),
     //floating action button
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
     floatingActionButton:  
     FloatingActionButton(onPressed: (){
        savetotask(); 
      },backgroundColor: Colors.indigo,tooltip: "New Task",
        child: Icon(Icons.add,color: Colors.white,),),
      //drawer 
      drawer: Drawer(
        child: ListView(
          children:[
            Row(
              children: [
                BackButton(),
          //theme change icon change
          Padding(
            padding: const EdgeInsets.only(left: 200,top: 10),
             child: IconButton(
              onPressed: (){
              Provider.of<UiProvider>(context,listen: false).changeTheme();
              },
              icon: Icon(uiProvider.dark ? Icons.dark_mode : Icons.light_mode,
              color: uiProvider.dark ?Colors.indigoAccent : Colors.grey[700]),
              tooltip: uiProvider.dark ? "Light Mode" : "Dark Mode",
             ),
            )
           ],
          ),
          //circleAvatar
          Container(
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: uiProvider.dark ? Colors.indigo : Colors.grey,
                spreadRadius: 1,blurRadius: 20
              )
            ]
            ),
              child: CircleAvatar(
                radius: 95,child: CircleAvatar(
                  radius: 94,
                  backgroundImage: AssetImage("profile.jpg"),
              )),
             ),
             //line
             Padding(
               padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
               child: Divider(thickness: 2,color: Colors.indigoAccent,),
             ),
            SizedBox(height: 20,),
            //settings
            ListTile(
              title: Text("Settings",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.indigoAccent),),
              subtitle: Text("Click for setings."),
              contentPadding: EdgeInsets.only(top: 10,bottom: 5,left: 40,right: 50),
              trailing: Icon(Icons.settings),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> Settings()));
              },
            ),
             //privacy policy
             ListTile(
              title: Text("Privacy Policy",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.indigoAccent),),
              subtitle: Text("View policies."),
              contentPadding: EdgeInsets.only(top: 10,bottom: 5,left: 40,right: 50),
              trailing: Icon(Icons.privacy_tip_rounded),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> Privacypolicy()));
              },
            ),
             //about
             ListTile(
              title: Text("About",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.indigoAccent),),
              subtitle: Text("About Dev."),
              contentPadding: EdgeInsets.only(top: 10,bottom: 5,left: 40,right: 50),
              trailing: Icon(Icons.info),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=> About()));
              },
            ),
            //version
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Text("v 1.0.0",style: TextStyle(fontSize: 10),),
                ),
              ],
            )
        ] 
      ),   
    )
   );
  }
}