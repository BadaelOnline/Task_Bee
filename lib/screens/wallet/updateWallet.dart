import 'package:flutter/material.dart';

import 'package:test_database_floor/models/currency.dart';

import 'package:test_database_floor/screens/myhomepage.dart';
import 'package:test_database_floor/screens/wallet/wallet_home.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';

import 'package:test_database_floor/widget/custom_widgets.dart';

import '../../services/wallet_cubit/states.dart';
import '../../services/wallet_cubit/cubit.dart';

class Updatewallet extends StatelessWidget {
  final walletId;
  final String walletName;
  final walletCurrencyId;
  final walletbalance;

  String image = 'assets/wallet/dollar.png';

  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  Updatewallet(
      {Key key,
      this.walletId,
      this.walletName,
      this.walletCurrencyId,
      this.walletbalance,
      this.image})
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
        child:
            BlocConsumer<WalletCubit, WalletStates>(listener: (context, state) {
          if (state is UpdateWalletsToDatabaseState) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WalletHome()));
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.all(15),
            child:
                // ConstrainedBox(
                //   constraints: BoxConstraints(
                //       minHeight: MediaQuery.of(context).size.height,
                //       maxHeight: MediaQuery.of(context).size.height),
                Column(children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  image: DecorationImage(
                    scale: 9,
                    image: AssetImage(image),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  border: Border.all(
                    color: Colors.amber[400],
                    width: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Cash',
                style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              customFormField(
                  label: 'Wallet Name',
                  controller: nameController = TextEditingController(
                    text: '$walletName',
                  ),
                  type: TextInputType.text,
                  isClickable: true,
                  onChange: (String value) {},
                  onSubmit: (String value) {},
                  onTap: () {}),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: customFormField(
                        label: 'balance ',
                        controller: balanceController =
                            TextEditingController(text: '$walletbalance'),
                        // prefix: Icons.account_balance,
                        type: TextInputType.number),
                  ),
                  BlocConsumer<CurrencyCubit, CurrencyStates>(
                    listener: (context, CurrencyStates state) {},
                    builder: (context, CurrencyStates state) {
                      var x = CurrencyCubit.get(context);
                      print('rrrrrrrrrrrrrrrrrrrrrrrrrr $x');
                      // ignore: unrelated_type_equality_checks
                      return Expanded(
                        flex: 1,
                        child: TextField(
                          // onSubmitted: (value) => _childInfo(context),
                          textAlign: TextAlign.right,
                          readOnly: true,
                          controller: currencyController =
                              TextEditingController(text: '$walletCurrencyId'),
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
                                        bottom: BorderSide(
                                            color: Colors.transparent))),
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
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (val) {},
                        checkColor: Colors.amber,
                      ),
                      Text('Hide Wallet'),
                    ],
                  ),
                  Text(
                      'The wallet and its balance will be hidden \n You can create any transactions even unhide'),
                ],
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
                  return customRaisedButton(
                      text: 'Edit',
                      onPressed: () {
                        WalletCubit.get(context).updateWalletDatabase(
                            isId: walletId,
                            icon: image,
                            walletName: nameController.text,
                            walletBalance: balanceController.text,
                            currencyId: CurrencyCubit.get(context)
                                .getCurrencyId(
                                    currencyName: currencyController.text));
                      });
                },
              )
            ]),
          );
        }),
      ),
    );
  }
}
