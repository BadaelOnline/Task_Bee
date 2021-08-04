import 'package:flutter/material.dart';
import 'package:test_database_floor/services/contact_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/exchange_cubit/cubit.dart';
import 'package:test_database_floor/services/transaction_cubit/cubit.dart';
import 'package:test_database_floor/services/transaction_cubit/states.dart';
import 'package:test_database_floor/services/wallet_cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/transaction_card.dart';
import 'package:conditional_builder/conditional_builder.dart';

class TransactionsByContact extends StatelessWidget {
  final int contactId;
  final int walletId;
  final int categoryId;

  const TransactionsByContact({Key key, this.contactId,this.walletId,this.categoryId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => WalletCubit()..createDatabase(),
          ),
          BlocProvider(
            create: (BuildContext context) => TransactionCubit()..createDatabase(),
          ),
          BlocProvider(
            create: (BuildContext context) => ContactCubit()..createDatabase(),
          ),
          BlocProvider(
            create: (BuildContext context) => ExchangeCubit()..createDatabase(),
          )
        ],

        child:BlocConsumer<TransactionCubit,TransactionStates>(
          listener: (context,TransactionStates states){},
          builder: (context,TransactionStates states){
            TransactionCubit transactionCubit = TransactionCubit.get(context);
            // transactionCubit.getTransactionByContactFromDatabase(contactId: contactId);
            return Scaffold(
              appBar: CustomAppBar(
                  Icon(Icons.wallet_giftcard),
                  'Reports'),
              body: ConditionalBuilder(
                condition: transactionCubit.transactionByContact != null,
                fallback: (context) {
                  transactionCubit.getTransactionByContactFromDatabase(contactId: contactId,walletId: walletId,categoryId: categoryId);

                  return Center(child: CircularProgressIndicator(),);
                },
                builder: (context){
                  if(transactionCubit.transactionByContact == null){
                    transactionCubit.getTransactionByContactFromDatabase(contactId: contactId,walletId: walletId,categoryId: categoryId);
                  }
                  return Center(
                    child: ListView.builder(
                        itemCount: transactionCubit.transactionByContact.length,
                        itemBuilder: (BuildContext context, int index){
                          return transactionItem(transactionCubit.transactionByContact[index],context);
                        }
                    ),
                  );
                } ,
              ),
            );
          },
        )
    );
  }
}
