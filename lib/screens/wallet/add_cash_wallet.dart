import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_database_floor/models/currency.dart';
import 'package:test_database_floor/screens/currency/currency_home.dart';
import 'package:test_database_floor/screens/wallet/wallet_home.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';
import '../../services/wallet_cubit/states.dart';
import '../../services/wallet_cubit/cubit.dart';
import 'wallets_list.dart';

class AddCashWallet extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  int dropdownValue = 1;

  int isID;
  String image = 'assets/wallet/dollar.png';

  AddCashWallet(
      {this.walletId,
      this.walletName,
      this.walletCurrencyId,
      this.walletbalance,
      this.currnceyName});
  final walletId;
  final String walletName;
  final walletCurrencyId;
  final walletbalance;
  final String currnceyName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cash Wallet'),
        centerTitle: true,
        backgroundColor: Colors.amber[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => WalletsList()));
          },
        ),
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
                  MaterialPageRoute(builder: (context) => WalletHome()));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        image: DecorationImage(
                          scale: 7,
                          image: AssetImage(image),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        // border: Border.all(
                        //   color: Colors.amber[400],
                        //   width: 2,
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Cash',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    customFormField(
                        label: 'Wallet Name',
                        controller: nameController,
                        type: TextInputType.text,
                        isClickable: true,
                        onChange: (String value) {},
                        onSubmit: (String value) {},
                        onTap: () {}),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: customFormField(
                              label: 'balance ',
                              controller: balanceController,
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
                              // child: Container(
                              //   color: Colors.grey[300],
                              //   height: 57,
                              //   child: InkWell(
                              //       onTap: () => Navigator.of(context)
                              //               .push(MaterialPageRoute(
                              //             builder: (_) => CurrencyHome(),
                              //           )),
                              //       child: Center(
                              //           child: Text(
                              //         currnceyName,
                              //         style: TextStyle(
                              //             fontSize: 20,
                              //             color: Colors.grey[700]),
                              //       ))),
                              // ),
                              child: TextField(
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
                                    borderSide:
                                        BorderSide(color: Colors.amberAccent),
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
                      height: 40,
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
                    BlocConsumer<CurrencyCubit, CurrencyStates>(
                      listener: (context, state) {
                        if (state is InsertCurrenciesToDatabaseState) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WalletHome()));
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
                            SizedBox(
                              height: 35,
                            ),
                            Container(
                              child: customRaisedButton(
                                  text: 'save',
                                  onPressed: () {
                                    WalletCubit.get(context).insertToDatabase(
                                        isId: walletId,
                                        icon: image,
                                        walletName: nameController.text,
                                        walletBalance: balanceController.text,
                                        currencyId: CurrencyCubit.get(context)
                                            .getCurrencyId(
                                                currencyName:
                                                    currencyController.text));
                                    // CurrencyCubit.get(context).insertToDatabase(
                                    //     isId: isID,
                                    //     basselName: currencyController.text,
                                    //     ownerId:WalletCubit.get(context).lastId != null?  WalletCubit.get(context).lastId + 1 : 1);
                                  }),
                            ),
                          ],
                        );
                      },
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
