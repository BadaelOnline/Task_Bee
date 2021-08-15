import 'package:flutter/material.dart';
import 'package:test_database_floor/screens/wallet/add_cash_wallet.dart';
import 'package:test_database_floor/screens/wallet/update_cash_Wallet.dart';
import 'package:test_database_floor/screens/wallet/update_bank_account.dart';
import 'package:test_database_floor/screens/wallet/update_credit_card.dart';
import 'package:test_database_floor/screens/wallet/update_planer_save.dart';
import 'package:test_database_floor/screens/wallet/update_priberd_card.dart';
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
                                          currencyCubit.getCurrencyOfWallet(
                                              currencyId: cubit
                                                  .wallets[index].currencyId),
                                      walletbalance:
                                          cubit.wallets[index].balance,
                                      image: cubit.wallets[index].icon,
                                    )));
                          } else if (cubit.wallets[index].icon ==
                              'assets/wallet/account.png') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UpdateBankAccount(
                                      walletId: cubit.wallets[index].id,
                                      walletName: cubit.wallets[index].name,
                                      walletbalance:
                                          cubit.wallets[index].balance,
                                      walletCurrencyId:
                                          currencyCubit.getCurrencyOfWallet(
                                              currencyId: cubit
                                                  .wallets[index].currencyId),
                                      image: cubit.wallets[index].icon,
                                    )));
                          } else if (cubit.wallets[index].icon ==
                              'assets/wallet/card.png') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UpdateCreditCard(
                                      walletId: cubit.wallets[index].id,
                                      walletName: cubit.wallets[index].name,
                                      walletbalance:
                                          cubit.wallets[index].balance,
                                      walletCurrencyId:
                                          currencyCubit.getCurrencyOfWallet(
                                              currencyId: cubit
                                                  .wallets[index].currencyId),
                                      image: cubit.wallets[index].icon,
                                    )));
                          } else if (cubit.wallets[index].icon ==
                              'assets/wallet/credit-cards.png') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UpdatePrepaidCard(
                                      walletId: cubit.wallets[index].id,
                                      walletName: cubit.wallets[index].name,
                                      walletbalance:
                                          cubit.wallets[index].balance,
                                      walletCurrencyId:
                                          currencyCubit.getCurrencyOfWallet(
                                              currencyId: cubit
                                                  .wallets[index].currencyId),
                                      image: cubit.wallets[index].icon,
                                    )));
                          } else if (cubit.wallets[index].icon ==
                              'assets/wallet/revenue.png') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UpdatePlannerSave(
                                      walletId: cubit.wallets[index].id,
                                      walletName: cubit.wallets[index].name,
                                      walletbalance:
                                          cubit.wallets[index].balance,
                                      walletCurrencyId:
                                          currencyCubit.getCurrencyOfWallet(
                                              currencyId: cubit
                                                  .wallets[index].currencyId),
                                      image: cubit.wallets[index].icon,
                                    )));
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
                                // fit: BoxFit.cover,
                                alignment: Alignment.center,
                                scale: 40,
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
                          currency: currencyCubit.getCurrencyOfWallet(
                              currencyId: cubit.wallets[index].currencyId),
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
