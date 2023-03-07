import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TextEditingController amountController=TextEditingController();
  var id;
  var balance;

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
  @override
  void initState() {
    super.initState();
    getData();
  }

  depositMoney() async{
   var url=Uri.parse('http://172.16.8.176:9092/api/v1/operations/deposit/5');

   var data={
     'amount': amount,
   };
   http.Response response= await http.post(url,headers: <String, String>{
     'Content-Type': 'application/json; charset=UTF-8',
   },body: jsonEncode(data));
   //print(response.statusCode);
   if (response.statusCode == 200) {
     var res=jsonDecode(response.body);
     setState(() {
       // this.id= res['id'];
       // this.balance= res['balance'];
       var data1=res['data'];
       var data2=data1['walletDto'];
       var data3=data2['balance'];
       print(res['data']);
       print(data3);
       id=data3;
       // print(res['balance']);
     });
   } else {
     print('error fetching data');
   }


  }
  withdrawMoney(){

  }
  double amount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Transaction'),),
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Container(
              alignment: Alignment.center,
              child: Text('Wallet Balance :  $balance DH',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            Container(
               margin: EdgeInsets.only(top: 60),
               alignment: Alignment.center,
               width: 200,
               child:
               TextFormField(
                 controller: amountController,
                 textAlign: TextAlign.center,
                 decoration: InputDecoration(
                     hintText: 'Amount'
                 ),
               ),
                 // SizedBox(height: 50,),

            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    amount = double.parse(amountController.text);
                    depositMoney();
                  }, child: Text('Deposit'),),
                  ElevatedButton(onPressed: withdrawMoney, child: Text('Withraw')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
