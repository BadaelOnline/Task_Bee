import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/screens/exchange/exchange_home.dart';
import 'package:test_database_floor/services/exchange_cubit/cubit.dart';
import 'package:test_database_floor/services/exchange_cubit/states.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';
import 'category.dart';

class UpdateExchange extends StatelessWidget {
  final exchangeId;
  final exchangeName;
  final String catImage;

  TextEditingController nameController = TextEditingController();

  UpdateExchange({
    Key key,
    this.exchangeId,
    this.exchangeName,
    this.catImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ExchangeHome()));
          },
        ),
        centerTitle: true,
        title: Text('Update Exchang Category'),
        backgroundColor: Colors.amber[400],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ExchangeCubit()..createDatabase(),
          ),
        ],
        child: BlocConsumer<ExchangeCubit, ExchangeStates>(
          listener: (context, state) {
            if (state is UpdateExchangesToDatabaseState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ExchangeHome()));
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Category()));
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                image: DecorationImage(
                                  scale: 0.5,
                                  image: AssetImage('$catImage'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                border: Border.all(
                                  color: Colors.amber[400],
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: customFormField(
                                  label: 'Name Category',
                                  controller: nameController =
                                      TextEditingController(
                                          text: '$exchangeName'),
                                  prefix: Icons.category)),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customRaisedButton(
                              onPressed: () {
                                ExchangeCubit.get(context)
                                    .updateExchangeDatabase(
                                  isId: exchangeId,
                                  exchangeName: nameController.text,
                                  icon: catImage,
                                );
                              },
                              text: 'Update'),
                          customRaisedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ExchangeHome()));
                              },
                              text: 'Cansel'),
                        ],
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
