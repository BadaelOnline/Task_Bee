import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_database_floor/screens/transaction/add_transaction.dart';
import 'package:test_database_floor/screens/transaction/update_transaction.dart';
import 'package:test_database_floor/services/contact_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/exchange_cubit/cubit.dart';
import 'package:test_database_floor/services/transaction_cubit/cubit.dart';
import 'package:test_database_floor/services/transaction_cubit/states.dart';
import 'package:test_database_floor/services/wallet_cubit/cubit.dart';
import 'package:test_database_floor/services/wallet_cubit/states.dart';
import 'package:test_database_floor/screens/wallet/update_cash_Wallet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:test_database_floor/widget/TransAction_Card_1.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';

class TransactionHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              TransactionCubit()..createDatabase(),
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
        BlocProvider(
          create: (BuildContext context) => CurrencyCubit()..createDatabase(),
        ),
      ],
      child: BlocConsumer<TransactionCubit, TransactionStates>(
        listener: (BuildContext context, TransactionStates state) {},
        builder: (BuildContext context, TransactionStates state) {
          TransactionCubit transactionCubit = TransactionCubit.get(context);
          ContactCubit contactCubit = ContactCubit.get(context);
          ExchangeCubit exchangeCubit = ExchangeCubit.get(context);
          WalletCubit walletCubit = WalletCubit.get(context);
          CurrencyCubit currencyCubit = CurrencyCubit.get(context);
          return Scaffold(
              appBar: CustomAppBar(Icon(Icons.wallet_giftcard), 'Transaction'),
              body: ConditionalBuilder(
                condition: true,
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (context) {
                  return ListView.builder(
                    itemCount: transactionCubit.transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardTransaction(
                          contact: '${contactCubit.contacts[index].name}',
                          datetime:
                              '${transactionCubit.transactions[index].transactionDate}',
                          iconExchang: Image.asset(
                              '${exchangeCubit.exchanges[index].icon}'),
                          imageWallet:
                              Image.asset('${walletCubit.wallets[index].icon}'),
                          iconMoneyType:
                              Image.asset('${walletCubit.wallets[index].icon}'),
                          note:
                              '${transactionCubit.transactions[index].description}',
                          payedMoney:
                              '${transactionCubit.transactions[index].paid}',
                          totaleMoney:
                              '${transactionCubit.transactions[index].total}',
                          restMoney:
                              '${transactionCubit.transactions[index].rest}',
                          titleExchange:
                              '${exchangeCubit.exchanges[index].name}',
                          walletType: '${walletCubit.wallets[index].name}',
                          currency: '${currencyCubit.currencies[index].name}');
                      // return Card(
                      //     child: Column(
                      //   children: [
                      //     ListTile(
                      //       contentPadding: EdgeInsets.all(8.0),
                      //       title: Text(
                      //           transactionCubit.transactions[index].total),

                      //       leading: IconButton(
                      //         icon: Icon(Icons.delete),
                      //         onPressed: () {
                      //           // walletCubit.deleteWalletFromDatabase(id:currencyCubit.getWalletId(id: cubit.wallets[index].id ));
                      //           transactionCubit.deleteTransactionFromDatabase(
                      //               id: transactionCubit
                      //                   .transactions[index].id);
                      //           // transactionCubit.getmixesFromDatabase();
                      //         },
                      //       ),
                      //       // subtitle:BlocConsumer<WalletCubit,WalletStates>(
                      //       //     listener: (BuildContext context,WalletStates state){},
                      //       //     builder: (BuildContext context, WalletStates state){
                      //       //       return Text(walletCubit.getCurrencyOfWallet(walletId: cubit.wallets[index].id));
                      //       //     }
                      //       // ) ,
                      //       onTap: () => Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => UpdateTransaction(
                      //                   transactionId: transactionCubit
                      //                       .transactions[index].id))),
                      //     ),
                      //     Text(
                      //         'paid is : ${transactionCubit.transactions[index].paid}'),
                      //     Text(
                      //         'rest is : ${transactionCubit.transactions[index].rest}'),
                      //     Text(
                      //         'des is : ${transactionCubit.transactions[index].description}'),
                      //     Text(
                      //         'wallet id is : ${transactionCubit.transactions[index].walletId}'),
                      //     Text(
                      //         'contact id is : ${transactionCubit.transactions[index].contactId}'),
                      //     Text(
                      //         'category id is : ${transactionCubit.transactions[index].exchangeId}'),
                      //     Text(
                      //         'date is : ${transactionCubit.transactions[index].transactionDate}'),
                      //     Text(
                      //         'income is : ${transactionCubit.transactions[index].isIncome}'),
                      //   ],
                      // ));
                    },
                  );
                  ;
                },
              ),
              // Text(basselCubit.bassels[index].name)
              // FutureBuilder(
              //   future: cubit.dao.retrieveUsers(),
              //   builder: (BuildContext context, AsyncSnapshot<List<Wallet>> snapshot) {
              //     if (snapshot.hasData) {
              //       return ListView.builder(
              //         itemCount: snapshot.data?.length,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Card(
              //               child: ListTile(
              //                 contentPadding: EdgeInsets.all(8.0),
              //                 title: Text(snapshot.data[index].name),
              //                 leading: IconButton(
              //                   icon: Icon(Icons.delete),
              //                   onPressed: () {
              //
              //                       cubit.dao.deleteUser(snapshot.data[index].id);
              //
              //                   },
              //                 ),
              //               ));
              //         },
              //       );
              //     } else {
              //       return Center(child: CircularProgressIndicator());
              //     }
              //   },
              // ),
              floatingActionButton: customFloatinActionButton(
                icon: Icon(Icons.add),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddTransaction())),
              )
              // FloatingActionButton(
              //   child: Icon(Icons.add),
              //   onPressed: () => Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => AddTransaction())),
              // ),
              );
        },
      ),
    );
  }

  Future<void> _showMyDialog(context, String walletName, String total, rest,
      paid, desc, date, contact, category) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('wallet is: $walletName'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('total is : $total .'),
                Text('rest is : $rest .'),
                Text('paid is : $paid .'),
                Text('desc is : $desc .'),
                Text('date is : $date .'),
                Text('contact is : $contact .'),
                Text('category is : $category .'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
