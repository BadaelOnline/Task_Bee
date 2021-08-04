import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:test_database_floor/database/database.dart';
import 'package:test_database_floor/models/currency.dart';
import 'package:test_database_floor/models/wallet.dart';
import 'package:test_database_floor/screens/myhomepage.dart';
import 'package:test_database_floor/screens/wallet/wallet_home.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/states.dart';
import 'package:test_database_floor/services/dao/dao_wallet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_textFormField.dart';

import '../../services/wallet_cubit/states.dart';
import '../../services/wallet_cubit/cubit.dart';

class Updatewallet extends StatelessWidget {
  final walletId;
  final walletName;
  final walletCurrencyId;

  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  Updatewallet({Key key, this.walletId, this.walletName, this.walletCurrencyId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(Icon(Icons.wallet_giftcard), 'Update Wallet'),
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
            if (state is UpdateWalletsToDatabaseState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WalletHome()));
            }
          },
          builder: (context, state) {
            return ListView(children: [
              SizedBox(
                height: 50,
              ),

              CustomTextFormField(
                  'Name Wallet',
                  nameController = TextEditingController(text: '$walletName'),
                  Icon(Icons.drive_file_rename_outline),
                  () {},
                  () {},
                  TextInputType.text),
              // TextFormField(
              //   controller: nameController,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'Name Wallet',
              //   ),
              // ),
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
              // SizedBox(
              //   height: 50,
              // ),
              // TextFormField(
              //   controller: currencyController,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'currency',
              //   ),
              // ),
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
                      hintText: 'Wallet',
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
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  }
                },
                builder: (context, state) {
                  return TextButton(
                      child: Text('save'),
                      onPressed: () {
                        WalletCubit.get(context).updateWalletDatabase(
                            isId: walletId,
                            walletName: nameController.text,
                            walletBalance: balanceController.text,
                            currencyId: CurrencyCubit.get(context)
                                .getCurrencyId(
                                    currencyName: currencyController.text));
                      });
                },
              )
            ]);
          },
        ),
      ),
    );
  }
}
