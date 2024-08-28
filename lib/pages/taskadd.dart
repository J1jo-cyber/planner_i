 // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/provider_theme.dart';
import 'package:intl/intl.dart';

class Taskadd extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  const Taskadd({super.key,required this.onSave});

  @override
  State<Taskadd> createState() => _TaskaddState();
}

class _TaskaddState extends State<Taskadd> {
  //stepper
  int currentstep=0;
  //next function
  void continuestepfun(){
    if(currentstep<3){
    setState(() {
      currentstep=currentstep+1;
     });
    }else{
      submitdata();
    }
  }
  //back function
  void cancelstepfun(){
    if(currentstep>0){
      setState(() {
        currentstep=currentstep-1;
      });
    }
  }
  //naviagte steps function 
  void onstepfun(int value){
    setState(() {
      currentstep=value;
    });
  }
  //submit data function
  void submitdata(){
    final taskData = {
      'title': title.text,
      'note': note.text,
      'date': d1.text,
      'priority': selectedbutton.toString(),
    };

    widget.onSave(taskData); // Call the callback function with the task data
    Navigator.pop(context); // Close the Taskadd page
  }
  // stepper button builder
  Widget controlsBuilder(context,details){
    return Row(
      children: [
        //next button
        ElevatedButton(onPressed: details.onStepContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white 
        ),
        //save button
         child: currentstep>2 ? Text("Save",style: TextStyle(fontWeight: FontWeight.bold),)
         : Text("Next",style: TextStyle(fontWeight: FontWeight.bold),)
         ),

         SizedBox(width: 10,),
         
         //back button
         ElevatedButton(onPressed: details.onStepCancel,
         style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[600],
          foregroundColor: Colors.white
         ),
         child: Text("Back")),
      ],
    );
  }
  //textfield variable and dateformat variable
  var d1=TextEditingController();
  final DateFormat formatDate = DateFormat('dd-MM-yyyy');
  //date picking funtion
  void datefunction()async{
    final DateTime? datetime=await showDatePicker(context: context,
      firstDate: DateTime(1800), 
      lastDate: DateTime(2500),
      initialDate: DateTime.now()); 
      //check if the picked date is not null
     if (datetime!=null){
      setState(() {
        d1.text=formatDate.format(datetime);
      });
     }
  }
  //title and note values
  var title=TextEditingController();
  var note=TextEditingController();
  //priority variables and function
  Color button1=Colors.red;
  Color button2=Colors.amber;
  Color button3=Colors.blue;
  Color button4=Colors.cyan; 

  Color selected=Colors.green;
  int selectedbutton=0;
  void onpressfun(int buttonindex){
    setState(() {
      button1=Colors.red;
      button2=Colors.red;
      button3=Colors.red;
      button4=Colors.red;

      switch(buttonindex){
        case 1:
          button1=selected;
          break;
        case 2:
          button2=selected;
          break;
        case 3:
          button3=selected;
          break;
        case 4:
          button4=selected;
          break;
      }
      //storing the index
      selectedbutton=buttonindex;
    });
  }
  @override
  Widget build(BuildContext context) {
    //appbar color change
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: uiProvider.dark ? Colors.indigo : Colors.grey[900],
        elevation: 15,
        backgroundColor: uiProvider.dark ? Colors.grey[900] : Colors.indigo,
        leading: BackButton(color: Colors.white,),
        title: Text("Add Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white,letterSpacing: 1),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white,),
          tooltip: "Search",
          )
        ],
      ),
      body: SingleChildScrollView(child: 
      //stepper
      Column(
        children: [
          SizedBox(height: 40,),
          Text("Add your task here.",
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,
          color: uiProvider.dark ? Colors.white : Colors.grey[900],letterSpacing: 1),),
          Padding(
            padding: const EdgeInsets.only(left: 80,right: 80,top: 5),
            child: Divider(
              thickness: 1.5,color: Colors.indigo,
            ),
          ),
          SizedBox(height: 20,),
          Stepper(
            connectorThickness: 2,
            currentStep: currentstep,
            onStepContinue: continuestepfun,
            onStepCancel: cancelstepfun,
            onStepTapped: onstepfun,
            controlsBuilder: controlsBuilder,
            steps: [
              //title
            Step(title: Text("Title"),
            isActive: currentstep>=0,
            stepStyle: currentstep>0 ? StepStyle(boxShadow: BoxShadow(color: Colors.green,blurRadius: 20),
                color: Colors.green)
                : StepStyle(color: Colors.indigo),
            state: currentstep>0 ? StepState.complete : StepState.indexed,
             content: Column(
               children: [
                 TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: "What are you planning ?",
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),
                SizedBox(height: 20,)
               ],
             )),
            //note or description
            Step(title: Text("Description"), 
            isActive: currentstep>=1,
            stepStyle: currentstep>1 ? StepStyle(boxShadow: BoxShadow(color: Colors.green,blurRadius: 20),
                color: Colors.green)
                : StepStyle(color: Colors.indigo),
            state: currentstep>1 ? StepState.complete : StepState.indexed,
             content: Column(
               children: [
                 TextField(
                  controller: note,
                  maxLength: 1000,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Notes",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                ),
               ],
             )),
            //date
            Step(title: Text("Date"),
            isActive: currentstep>=2,
            stepStyle: currentstep>2 ? StepStyle(boxShadow: BoxShadow(color: Colors.green,blurRadius: 20),
                color: Colors.green)
                : StepStyle(color: Colors.indigo),
            state: currentstep>2 ? StepState.complete : StepState.indexed,
             content: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(right: 200),
                   child: TextField(
                      controller: d1,
                      decoration: InputDecoration(
                        hintText: "Date",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.date_range_sharp)
                      ),
                      onTap: (){ datefunction(); },
                     ),
                 ),
                 SizedBox(height: 20,)
               ],
             )),
            //priority buttons
            Step(title: Text("Priority"),
            isActive: currentstep>=3,
            stepStyle: currentstep>3 ? StepStyle(boxShadow: BoxShadow(color: Colors.green,blurRadius: 20),
                color: Colors.green)
                : StepStyle(color: Colors.indigo),
            state: currentstep>3 ? StepState.complete : StepState.indexed,
             content: Container(
              padding: EdgeInsets.only(top: 15,bottom: 1),//space inside box
              margin: EdgeInsets.all(10),//space outside box
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo,width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
               child: Column(
                 children: [
                   Text("Select your priority level",style: TextStyle(color: Colors.indigo,fontSize: 15,fontWeight: FontWeight.w400),),
                   SizedBox(height: 5,),
                   //buttons
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Padding(
                   padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
                   child: MaterialButton(onPressed: (){
                    onpressfun(1);
                               },
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                    ),
                    textColor: Colors.white, 
                    hoverColor: Colors.green, 
                    splashColor: Colors.white,
                    color: button1,
                    child: Text("Low",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                 ),
              //priority button 2 
              Padding(
                padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
                child: MaterialButton(onPressed: (){
                    onpressfun(2);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  textColor: Colors.white,
                  hoverColor: Colors.green,
                  splashColor: Colors.white,
                  color: button2,
                  child: Text("Medium",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
              ),
              //priority button 3 
                 Padding(
                   padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
                   child: MaterialButton(onPressed: (){
                    onpressfun(3);
                    },
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                    ),
                  textColor: Colors.white,
                  hoverColor: Colors.green,
                  splashColor: Colors.white,
                  color: button3,
                  child: Text("High",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                 ),
                //priority button 4
                Padding(
                  padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
                  child: MaterialButton(onPressed: (){
                    onpressfun(4);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  textColor: Colors.white,
                  hoverColor: Colors.green,
                  splashColor: Colors.white,
                  color: button4,
                  child: Text("Urgent",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                 ),
                ]
               ),SizedBox(height: 10,)
             ]
            )
           )
          ),//next step
               ]
              ),
        ],
      )
   ));
  }
}