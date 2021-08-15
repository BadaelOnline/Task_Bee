import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:test_database_floor/screens/currency/add_currency.dart';
import 'package:test_database_floor/screens/currency/update_currency.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/states.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';

class CurrencyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => CurrencyCubit()..createDatabase(),
        ),
      ],
      child: BlocConsumer<CurrencyCubit, CurrencyStates>(
        listener: (BuildContext context, CurrencyStates state) {},
        builder: (BuildContext context, CurrencyStates state) {
          CurrencyCubit cubit = CurrencyCubit.get(context);
          return Scaffold(
              appBar: CustomAppBar(Icon(Icons.wallet_giftcard), 'My Currency'),
              body: ConditionalBuilder(
                condition: true,
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                builder: (context) {
                  return ListView.builder(
                    itemCount: cubit.currencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(cubit.currencies[index].name),
                        leading: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            cubit.deleteCurrencyFromDatabase(
                                id: cubit.currencies[index].id);
                          },
                        ),
                        // onTap: () {
                        //   // // String currencyName =
                        //   // //     cubit.currencies[index].name;
                        //   // Navigator.of(context).pop(cubit.getCurrenciesFromDatabase(

                        //   // ));
                        // }
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateCurrency(
                                    currencyId: cubit.currencies[index].id,
                                    currencyName:
                                        cubit.currencies[index].name))),
                      ));
                    },
                  );
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
                    MaterialPageRoute(builder: (context) => AddCurrency())),
              )
              // FloatingActionButton(
              //   child: Icon(Icons.add),
              //   onPressed: () => Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => AddCurrency())),
              // ),
              );
        },
      ),
    );
  }
}
