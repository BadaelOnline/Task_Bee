import 'package:flutter/material.dart';
import 'package:test_database_floor/models/mix_data.dart';

Widget transactionItem(Mix mix,context) => Card(
  key: Key(mix.transactionId.toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child:SingleChildScrollView(
      child: ListBody(
        children:  <Widget>[
          Text('wallet is: ${mix.walletName}'),
          Text('total is : ${mix.transactionTotal} .'),
          Text('rest is : ${mix.transactionRest} .'),
          Text('paid is : ${mix.transactionPaid} .'),
          Text('desc is : ${mix.transactionDescription} .'),
          Text('date is : ${mix.transactionDate} .'),
          Text('contact is : ${mix.contactName} .'),
          Text('category is : ${mix.exchangeCategoryName} .'),
        ],
      ),
    ),
  ),
  // onDismissed: (direction){
  //   AppCubit.get(context).deleteData(id: model['id']);
  // },
);