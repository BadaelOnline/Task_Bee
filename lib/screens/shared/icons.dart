import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:test_database_floor/screens/contact/contact_home.dart';
import 'package:test_database_floor/screens/currency/currency_home.dart';
import 'package:test_database_floor/screens/exchange/exchange_home.dart';
import 'package:test_database_floor/screens/transaction/transaction_home.dart';
import 'package:test_database_floor/screens/wallet/wallet_home.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/wallet_cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';



class IconsScreen extends StatelessWidget {


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
              'Honey Bee'),
          body:
          Center(
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank -green.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank- red.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank-blue.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank-yellow.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/card green.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/card red.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/card-nlue.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/card yellow.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank -green.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank- red.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank-blue.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank-yellow.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank -green.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank- red.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank-blue.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank-yellow.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank -green.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank- red.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank-blue.png'),
                          ),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            radius: 25,
                            child: Image.asset('assets/image_wallet/bank-yellow.png'),
                          ),
                        ),
                      ],
                    ),
              ],
            )),
          ),
        )


    );
  }
}
