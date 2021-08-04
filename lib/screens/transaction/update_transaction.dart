import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:test_database_floor/database/database.dart';
import 'package:test_database_floor/models/contact.dart';
import 'package:test_database_floor/models/exchange_category.dart';
import 'package:test_database_floor/models/wallet.dart';
import 'package:test_database_floor/screens/myhomepage.dart';
import 'package:test_database_floor/screens/transaction/transaction_home.dart';
import 'package:test_database_floor/screens/wallet/wallet_home.dart';
import 'package:test_database_floor/services/contact_cubit/cubit.dart';
import 'package:test_database_floor/services/contact_cubit/states.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/states.dart';
import 'package:test_database_floor/services/dao/dao_wallet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/services/exchange_cubit/cubit.dart';
import 'package:test_database_floor/services/exchange_cubit/states.dart';
import 'package:test_database_floor/services/transaction_cubit/cubit.dart';
import 'package:test_database_floor/services/transaction_cubit/states.dart';
import 'package:test_database_floor/widget/custom_textFormField.dart';

import '../../services/wallet_cubit/states.dart';
import '../../services/wallet_cubit/cubit.dart';

class UpdateTransaction extends StatelessWidget {
  final transactionId;

  TextEditingController totalController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  TextEditingController restController = TextEditingController();
  TextEditingController transactionDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController exchangeIdController = TextEditingController();
  TextEditingController walletIdController = TextEditingController();
  TextEditingController contactIdController = TextEditingController();
  TextEditingController isIncomeController = TextEditingController();




  UpdateTransaction({Key key, this.transactionId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:MultiBlocProvider(
        providers:[
          BlocProvider(
            create: (BuildContext context) => TransactionCubit()..createDatabase(),
          ),
          BlocProvider(
            create: (BuildContext context) => ExchangeCubit()..createDatabase(),
          ),
          BlocProvider(
            create: (BuildContext context) => ContactCubit()..createDatabase(),
          ),
          BlocProvider(
            create: (BuildContext context) => WalletCubit()..createDatabase(),
          ),
        ],


        child: BlocConsumer<TransactionCubit,TransactionStates>(
          listener: (context,state){
            if(state is UpdateTransactionsToDatabaseState){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TransactionHome()));
            }
          },
          builder: (context,state){
            TransactionCubit cubit = TransactionCubit.get(context);
            return ListView(children: [
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                  'total transaction',
                  totalController,
                  Icon(Icons.person),
                      (){},
                      (){},
                  TextInputType.number),
              // TextFormField(
              //   controller: totalController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'total transaction',
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                  'paid',
                  paidController,
                  Icon(Icons.person),
                      (){},
                      (){},
                  TextInputType.number),
              // TextFormField(
              //   controller: paidController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'paid',
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                  'rest',
                  restController,
                  Icon(Icons.person),
                      (){},
                      (){},
                  TextInputType.number),
              // TextFormField(
              //   controller: restController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'rest',
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                  'transactionDate',
                  transactionDateController,
                  Icon(Icons.date_range),
                      (){},
                      (){},
                  TextInputType.text),
              // TextFormField(
              //   controller: transactionDateController,
              //   keyboardType: TextInputType.datetime,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'transactionDate',
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                  'description',
                  descriptionController,
                  Icon(Icons.description),
                      (){},
                      (){},TextInputType.text),
              // TextFormField(
              //   controller: descriptionController,
              //   keyboardType: TextInputType.text,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'description',
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                  'isIncome',
                  isIncomeController,
                  Icon(Icons.person),
                      (){},
                      (){},
                  TextInputType.number),
              // TextFormField(
              //   controller: isIncomeController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'isIncome',
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              BlocConsumer<ExchangeCubit,ExchangeStates>(
                listener: (context,ExchangeStates state){},
                builder:(context,ExchangeStates state){
                  var x = ExchangeCubit.get(context);
                  // ignore: unrelated_type_equality_checks
                  return TextField(
                    // onSubmitted: (value) => _childInfo(context),
                    textAlign: TextAlign.right,
                    readOnly: true,
                    controller: exchangeIdController,
                    style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                    decoration: InputDecoration(
                      labelStyle: new TextStyle(
                        color: Colors.amberAccent,

                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.amberAccent),
                      ),
                      prefixIcon: new DropdownButton<String>(
                        underline: Container(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.transparent))
                          ),
                        ),
                        icon: new Icon(Icons.keyboard_arrow_down),
                        items: x.exchanges.map((ExchangeCategory value) {
                          return new DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name) ,
                          );
                        }).toList(),
                        onChanged: (String value){
                          exchangeIdController.text =value;
                        },
                      ),
                      hintText: 'Exchange Category',
                      hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                      hoverColor: Colors.amberAccent,
                      focusColor: Colors.amberAccent,
                    ),
//                        onSubmitted: (value) =>  Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => ChildInfo(children[0]))) ,
                  );
                } ,
              ),
              SizedBox(
                height: 50,
              ),
              BlocConsumer<ContactCubit,ContactStates>(
                listener: (context,ContactStates state){},
                builder:(context,ContactStates state){
                  var x = ContactCubit.get(context);
                  // ignore: unrelated_type_equality_checks
                  return TextField(
                    // onSubmitted: (value) => _childInfo(context),
                    textAlign: TextAlign.right,
                    readOnly: true,
                    controller: contactIdController,
                    style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                    decoration: InputDecoration(
                      labelStyle: new TextStyle(
                        color: Colors.amberAccent,

                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.amberAccent),
                      ),
                      prefixIcon: new DropdownButton<String>(
                        underline: Container(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.transparent))
                          ),
                        ),
                        icon: new Icon(Icons.keyboard_arrow_down),
                        items: x.contacts.map((Contact value) {
                          return new DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name) ,
                          );
                        }).toList(),
                        onChanged: (String value){
                          contactIdController.text =value;
                        },
                      ),
                      hintText: 'Contact',
                      hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                      hoverColor: Colors.amberAccent,
                      focusColor: Colors.amberAccent,
                    ),
//                        onSubmitted: (value) =>  Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => ChildInfo(children[0]))) ,
                  );
                } ,
              ),
              SizedBox(
                height: 50,
              ),
              BlocConsumer<WalletCubit,WalletStates>(
                listener: (context,WalletStates state){},
                builder:(context,WalletStates state){
                  var x = WalletCubit.get(context);
                  // ignore: unrelated_type_equality_checks
                  return TextField(
                    // onSubmitted: (value) => _childInfo(context),
                    textAlign: TextAlign.right,
                    readOnly: true,
                    controller: walletIdController,
                    style: TextStyle(fontSize: 18.0 , color: Colors.amberAccent,),cursorColor: Colors.amberAccent,
                    decoration: InputDecoration(
                      labelStyle: new TextStyle(
                        color: Colors.amberAccent,

                      ),
                      focusedBorder:UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.amberAccent, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.amberAccent),
                      ),
                      prefixIcon: new DropdownButton<String>(
                        underline: Container(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.transparent))
                          ),
                        ),
                        icon: new Icon(Icons.keyboard_arrow_down),
                        items: x.wallets.map((Wallet value) {
                          return new DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name) ,
                          );
                        }).toList(),
                        onChanged: (String value){
                          walletIdController.text =value;
                        },
                      ),
                      hintText: 'Wallet',
                      hintStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                      hoverColor: Colors.amberAccent,
                      focusColor: Colors.amberAccent,
                    ),
//                        onSubmitted: (value) =>  Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => ChildInfo(children[0]))) ,
                  );
                } ,
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                  child: Text('save'),
                  onPressed: () {
                    cubit.updateTransactionDatabase(

                      isId: transactionId,
                      contactId: ContactCubit.get(context).getContactId(contactName: contactIdController.text),
                      description: descriptionController.text,
                      exchangeId: ExchangeCubit.get(context).getExchangeId(exchangeName: exchangeIdController.text),
                      paid: paidController.text,
                      rest: restController.text,
                      total: totalController.text,
                      transactionDate: transactionDateController.text,
                      walletId: WalletCubit.get(context).getWalletId(walletName: walletIdController.text),

                    );


                  })
            ]);
          },
        ),
      ),
    );
  }
}

