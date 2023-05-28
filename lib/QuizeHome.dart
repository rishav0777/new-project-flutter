import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class quizeHome extends StatefulWidget{
  @override
  quizeHomeState createState()=>quizeHomeState();

}

class quizeHomeState extends State<quizeHome>{
  List<String> Questions=["what is your name?","What is your country name?"];
  List<int> Answers=[2,1];
  List<List<String>> Options=[["Rahul","Rishav","Rishu","chahal"],
                              ["India","England","japan","China"]];
  List<bool>selectOption=[false,false,false,false];
  List<bool>selectAns=[false,false,false,false];
  int time=60;

  late int queNo=0;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time=60;
    startTimer();
  }

  void startTimer(){
    timer=Timer(Duration(seconds: 1), () {setState(() {
      time--;

    }); if(time==-1)moveNextQuestion(); startTimer();});
  }


   void moveNextQuestion(){
       setState(() {
         queNo++;
         for(int j=0;j<4;j++) {
           selectOption[j]=false;
           selectAns[j]=false;
         }

         if(Questions.length<=queNo)queNo=0;
       });
  }

  void checkForAns(int answer){
     setState(() {
       selectAns[answer-1]=true;
       selectAns[Answers[queNo]-1]=true;
       if(Answers[queNo]==answer)selectOption[answer-1]=true;
       else selectOption[Answers[queNo]-1]=true;
     });
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.grey,
       appBar: AppBar(title: Text("MyQuize"),backgroundColor: Colors.blueGrey,
       actions: [Row(children: [Text('Time Left: ${time}')],)],
       ),
       body: Padding(
         padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Text("${queNo+1})",style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),),
                  title: Text(Questions[queNo],style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                      itemBuilder:(BuildContext context,int index){
                        return Card(
                          child: ListTile(
                            leading: Text('${index+1}'),
                            title: Text(Options[queNo][index]),
                            selectedTileColor: selectOption[index] ? Colors.greenAccent:Colors.redAccent,
                            selected: selectAns[index]? true:false,
                            onTap: (){checkForAns(index+1);},
                          ),
                        );
                      }
                  ),
                ),

              ],
            ),
          ),

       ),
       floatingActionButton: FloatingActionButton.small(
         onPressed: () {moveNextQuestion();},
         backgroundColor: Colors.blueGrey,
         child: const Icon(Icons.arrow_right),
       ),
     );
  }

}