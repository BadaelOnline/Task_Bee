import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:test_database_floor/screens/exchange/add_exchange.dart';
import 'package:test_database_floor/screens/exchange/update_exchange.dart';
import 'package:test_database_floor/services/exchange_cubit/cubit.dart';
import 'package:test_database_floor/services/exchange_cubit/states.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';

class ExchangeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ExchangeCubit()..createDatabase(),
        ),
      ],
      child: BlocConsumer<ExchangeCubit, ExchangeStates>(
        listener: (BuildContext context, ExchangeStates state) {},
        builder: (BuildContext context, ExchangeStates state) {
          ExchangeCubit cubit = ExchangeCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('Exchang Category'),
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
                    itemCount: cubit.exchanges.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(1),
                        color: Colors.white,
                        child: Column(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child:cubit.exchanges[index].icon == '' ? CircleAvatar():
                                           CircleAvatar(
                                           child: Image.asset(cubit.exchanges[index].icon),
                                           )
                      ),
                                  Container(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        cubit.exchanges[index].name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.analytics_outlined,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateExchange(
                                                  exchangeId:
                                                      cubit.exchanges[index].id,
                                                  exchangeName: cubit
                                                      .exchanges[index].name,
                                                ))),
                                    icon: Icon(
                                      Icons.edit,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cubit.deleteExchangeFromDatabase(
                                          id: cubit.exchanges[index].id);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                      );
                      // Card(
                      //     child: ListTile(
                      //   contentPadding: EdgeInsets.all(8.0),
                      //   title: Text(cubit.exchanges[index].name),
                      //   leading: IconButton(
                      //     icon: Icon(Icons.delete),
                      //     onPressed: () {
                      //       cubit.deleteExchangeFromDatabase(
                      //           id: cubit.exchanges[index].id);
                      //     },
                      //   ),
                      //   onTap: () => Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => UpdateExchange(
                      //                 exchangeId: cubit.exchanges[index].id,
                      //                 exchangeName: cubit.exchanges[index].name,
                      //               ))),
                      // ));
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
                    MaterialPageRoute(builder: (context) => AddExchange(catImage: '',))),
              )
              // FloatingActionButton(
              //   child: Icon(Icons.add),
              //   onPressed: () => Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => AddExchange())),
              // ),
              );
        },
      ),
    );
  }
}
