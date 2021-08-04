import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/screens/currency/currency_home.dart';
import 'package:test_database_floor/services/currency_cubit/cubit.dart';
import 'package:test_database_floor/services/currency_cubit/states.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_textFormField.dart';

class AddCurrency extends StatelessWidget {


  TextEditingController nameController = TextEditingController();

  int isID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          Icon(Icons.wallet_giftcard),
          'Add Currency'),
      body:MultiBlocProvider(
        providers:[
          BlocProvider(
            create: (BuildContext context) => CurrencyCubit()..createDatabase(),
          ),
        ],


        child: BlocConsumer<CurrencyCubit,CurrencyStates>(
          listener: (context,CurrencyStates state){
            if(state is InsertCurrenciesToDatabaseState){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CurrencyHome()));
            }
          },
          builder: (context,state){
            return ListView(children: [

              SizedBox(height: 20,),
              CustomTextFormField(
                  'Name Currency',
                  nameController,
                  Icon(Icons.money),
                      (){},
                      (){},
                  TextInputType.text),
              // TextFormField(
              //   controller: nameController,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'Name Currency',
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                  child: Text('save'),
                  onPressed: () {
                    CurrencyCubit.get(context).insertToDatabase(
                      isId: isID,
                      basselName: nameController.text,

                    );


                  })
            ]);
          },
        ),
      ),
    );
  }
}

