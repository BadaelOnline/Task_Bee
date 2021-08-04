import 'dart:io';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/screens/exchange/category.dart';
import 'package:test_database_floor/screens/exchange/exchange_home.dart';
import 'package:test_database_floor/services/exchange_cubit/cubit.dart';
import 'package:test_database_floor/services/exchange_cubit/states.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_textFormField.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';

class AddExchange extends StatelessWidget {
  final String catImage;
  TextEditingController nameController = TextEditingController();

  int isID;

   AddExchange({Key key, this.catImage}) : super(key: key);

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
        title: Text('Add Exchang Category'),
        backgroundColor: Colors.amber[400],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ExchangeCubit()..createDatabase(),
          ),
        ],
        child: BlocConsumer<ExchangeCubit, ExchangeStates>(
          listener: (context, ExchangeStates state) {
            if (state is InsertExchangesToDatabaseState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ExchangeHome()));
            }
          },
          builder: (context, state) {
            return Container(
              alignment: Alignment.center,
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
                            child: catImage == '' ? CircleAvatar():
                            Container(
                              child: CircleAvatar(
                                radius: 50,
                                child: Image.asset(catImage),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: customFormField(
                                    label: 'Name Category',
                                    controller: nameController,
                                    prefix: Icons.category)),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          customRaisedButton(
                              onPressed: () {
                                ExchangeCubit.get(context).insertToDatabase(
                                  isId: isID,
                                  exchangeName: nameController.text,
                                  catImage: catImage
                                );
                              },
                              text: 'Save'),
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
