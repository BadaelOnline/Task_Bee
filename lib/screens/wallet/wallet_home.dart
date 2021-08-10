import 'package:flutter/material.dart';
import 'package:test_database_floor/screens/wallet/add_cash_wallet.dart';
import 'package:test_database_floor/screens/wallet/updateWallet.dart';
import 'package:test_database_floor/screens/wallet/wallets_list.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/wallet_cubit/cubit.dart';
import 'package:test_database_floor/services/wallet_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';

class WalletHome extends StatelessWidget {
  WalletHome(
      {this.walletId,
      this.walletName,
      this.walletCurrencyId,
      this.walletbalance,
      this.image});
  final walletId;
  final walletName;
  final walletCurrencyId;
  final walletbalance;
  String image;

  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

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
      child: BlocConsumer<WalletCubit, WalletStates>(
        listener: (BuildContext context, WalletStates state) {},
        builder: (BuildContext context, WalletStates state) {
          WalletCubit cubit = WalletCubit.get(context);
          CurrencyCubit currencyCubit = CurrencyCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('My Wallet'),
                centerTitle: true,
                backgroundColor: Colors.amber[400],
              ),
              body: ConditionalBuilder(
                condition: true,
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (context) {
                  return ListView.builder(
                    itemCount: cubit.wallets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onDoubleTap: () {
                          if (cubit.wallets[index].icon ==
                              'assets/wallet/dollar.png') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Updatewallet(
                                      walletId: cubit.wallets[index].id,
                                      walletName: cubit.wallets[index].name,
                                      walletCurrencyId:
                                          currencyCubit.currencies[index].name,
                                      walletbalance:
                                          cubit.wallets[index].balance,
                                      image: cubit.wallets[index].icon,
                                    )));
                          } else if (cubit.wallets[index].icon ==
                              'assets/wallet/card.png') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => WalletsList()));
                          }
                        },
                        child: customContainerWallet(
                          title: cubit.wallets[index].name,
                          circleAvatar: Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                scale: 0.5,
                                image: AssetImage(cubit.wallets[index].icon),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          deletMethod: () {
                            showDialog(
                              context: context,
                              builder: (_) => customAlertDialog(
                                // title: 'Alart',
                                content:
                                    'This wallet will be deleted along with all transactions made on it \n and delete associated debt transactions',
                                cancelMethod: () {
                                  Navigator.of(context).pop();
                                },
                                submitMethod: () {
                                  cubit.deleteWalletFromDatabase(
                                      id: cubit.wallets[index].id);
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                          TransactionMethod: () {},
                          balance: cubit.wallets[index].balance,
                        ),
                      );
                    },
                  );
                },
              ),
              floatingActionButton: customFloatinActionButton(
                icon: Icon(Icons.add),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WalletsList())),
              ));
        },
      ),
    );
  }
}
