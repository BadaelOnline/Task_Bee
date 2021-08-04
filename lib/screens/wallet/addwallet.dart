import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_database_floor/models/currency.dart';
import 'package:test_database_floor/screens/myhomepage.dart';
import 'package:test_database_floor/screens/wallet/wallet_home.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_textFormField.dart';
import 'package:test_database_floor/widget/text_form.dart';

import '../../services/wallet_cubit/states.dart';
import '../../services/wallet_cubit/cubit.dart';

class Addwallet extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  int dropdownValue = 1;

  int isID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallet'),
        centerTitle: true,
        backgroundColor: Colors.amber[400],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => WalletCubit()..createDatabase(),
          ),
          BlocProvider(
            create: (BuildContext context) => CurrencyCubit()..createDatabase(),
          ),
        ],
        child: BlocConsumer<WalletCubit, WalletStates>(
          listener: (context, state) {
            if (state is InsertWalletsToDatabaseState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            }
          },
          builder: (context, state) {
            return ListView(children: [
              SizedBox(
                height: 50,
              ),
              defaultFormField(
                  label: 'Wallet',
                  controller: nameController,
                  prefix: Icons.wallet_giftcard,
                  type: TextInputType.text,
                  isClickable: true,
                  onChange: (String value) {},
                  onSubmit: (String value) {},
                  onTap: () {}),
              SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                  'balance',
                  balanceController,
                  Icon(Icons.account_balance),
                  () {},
                  () {},
                  TextInputType.number),
              SizedBox(
                height: 50,
              ),
              BlocConsumer<CurrencyCubit, CurrencyStates>(
                listener: (context, CurrencyStates state) {},
                builder: (context, CurrencyStates state) {
                  var x = CurrencyCubit.get(context);
                  print('rrrrrrrrrrrrrrrrrrrrrrrrrr $x');
                  // ignore: unrelated_type_equality_checks
                  return TextField(
                    // onSubmitted: (value) => _childInfo(context),
                    textAlign: TextAlign.right,
                    readOnly: true,
                    controller: currencyController,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.amberAccent,
                    ),
                    cursorColor: Colors.amberAccent,
                    decoration: InputDecoration(
                      labelStyle: new TextStyle(
                        color: Colors.amberAccent,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.amberAccent, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amberAccent),
                      ),
                      prefixIcon: new DropdownButton<String>(
                        underline: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.transparent))),
                        ),
                        icon: new Icon(Icons.keyboard_arrow_down),
                        items: x.currencies.map((Currency value) {
                          return new DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          currencyController.text = value;
                        },
                      ),
                      hintText: 'Currency',
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      hoverColor: Colors.amberAccent,
                      focusColor: Colors.amberAccent,
                    ),
//                        onSubmitted: (value) =>  Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => ChildInfo(children[0]))) ,
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              BlocConsumer<CurrencyCubit, CurrencyStates>(
                listener: (context, state) {
                  if (state is InsertCurrenciesToDatabaseState) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => WalletHome()));
                  }
                },
                builder: (context, state) {
                  var x = CurrencyCubit.get(context).currencies;
                  print('******************** $x');
                  return Column(
                    children: [
                      // x!= [] ? myDropdown(
                      //      currencies: x,
                      //      currencyController: currencyController,
                      //   onChanged: (String value){
                      //        print('oooooooooooooooooo $value');
                      //        currencyController.text = value;
                      //        print('ttttttttttttttttttttttttttt ${currencyController.text}');
                      //   }
                      //  ):Container(),
                      FlatButton(
                          child: Text('save'),
                          onPressed: () {
                            WalletCubit.get(context).insertToDatabase(
                                isId: isID,
                                walletName: nameController.text,
                                walletBalance: balanceController.text,
                                currencyId: CurrencyCubit.get(context)
                                    .getCurrencyId(
                                        currencyName: currencyController.text));
                            // CurrencyCubit.get(context).insertToDatabase(
                            //     isId: isID,
                            //     basselName: currencyController.text,
                            //     ownerId:WalletCubit.get(context).lastId != null?  WalletCubit.get(context).lastId + 1 : 1);
                          }),
                    ],
                  );
                },
              )
            ]);
          },
        ),
      ),
    );
  }
}
