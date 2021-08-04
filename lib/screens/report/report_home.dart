import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:test_database_floor/screens/contact/contact_home.dart';
import 'package:test_database_floor/screens/currency/currency_home.dart';
import 'package:test_database_floor/screens/exchange/exchange_home.dart';
import 'package:test_database_floor/screens/report/transaction_by_contact.dart';
import 'package:test_database_floor/screens/transaction/transaction_home.dart';
import 'package:test_database_floor/screens/wallet/wallet_home.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/wallet_cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';

import 'all-transaction.dart';

class ReportHome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => WalletCubit()..createDatabase(),
          ),
          BlocProvider(
            create: (BuildContext context) => CurrencyCubit()..createDatabase(),
          )
        ],

        child:Scaffold(
          appBar: CustomAppBar(
              Icon(Icons.wallet_giftcard),
              'Reports'),
          body: Center(
            child: SingleChildScrollView(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  color: Colors.amberAccent,
                  child:customRaisedButton(
                      text: 'all transaction',
                      onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllTransaction())
                  ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  color: Colors.amberAccent,
                  child:customRaisedButton(
                    text: 'transaction by contact',
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TransactionByContact())
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
          ),
        )
    );
  }
}
