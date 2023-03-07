import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// class _MyHomePageState extends State<MyHomePage> {
//   var userId;
//   var id;
//   var title;
//
//   getData() async{
//     var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
//     //var url = Uri.parse('http://172.16.8.176:9095/api/v1/wallets/get-wallet-by-id/5');
//     http.Response response= await http.get(url);
//     //print(response.statusCode);
//
//     if (response.statusCode == 200) {
//       var res=jsonDecode(response.body);
//       setState(() {
//         this.userId= res[userId];
//         this.id=res ['id'];
//         this.title= res['title'];
//         // print(res['reference']);
//       });
//     } else {
//       print('error fetching data');
//     }
//   }
class _MyHomePageState extends State<MyHomePage> {
  var id;
  var balance;
  var typeId;
  getData() async{
    var url = Uri.parse('http://172.16.8.176:9095/api/v1/wallets/get-wallet-by-id/5');
    http.Response response= await http.get(url);
    //print(response.statusCode);

    if (response.statusCode == 200) {
      var res=jsonDecode(response.body);
      setState(() {
        this.id= res['id'];
        this.balance= res['balance'];
        print(res['id']);
        print(res['balance']);
      });
    } else {
      print('error fetching data');
    }
  }
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wallet infos :'),),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Enter ID",
                ),
                onChanged: (value){
                  if(value!=null)
                  typeId=value;
                },
              ),
            ),
            ElevatedButton(onPressed: getData, child: Text('Add balance')
            ),
            Container(
              child: Text('wallet id is $id',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
            Container(
              child: Text('Balance $balance',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),

    );
  }
}
