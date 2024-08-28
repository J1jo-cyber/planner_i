import 'package:hive/hive.dart';

class Storage{

  //main list in home
  List tasklist=[];

  //box reference
  final storage=Hive.box('storage');

  //dispay data
  void displaydata(){
  final storedData=storage.get("0");
  tasklist=storedData !=null ? List.from(storedData) : [];
    print("display $tasklist");
    print("hive box${storage.get("0")}");
  }
  //update data
  void updatedata(){
    storage.put("0", tasklist);
    print("update $tasklist");
  }
  
  //constructor for data dispaly
  Storage(){
    displaydata();
  }

}