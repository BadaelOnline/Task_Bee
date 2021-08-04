import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/screens/exchange/exchange_home.dart';
import 'package:test_database_floor/services/exchange_cubit/cubit.dart';
import 'package:test_database_floor/services/exchange_cubit/states.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_textFormField.dart';

class UpdateExchange extends StatelessWidget {
  final exchangeId;
  final exchangeName;

  TextEditingController nameController = TextEditingController();

  UpdateExchange({Key key, this.exchangeId, this.exchangeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(Icon(Icons.wallet_giftcard), 'Update Exchange'),
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
            return ListView(children: [
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                  'Name Exchange',
                  nameController = TextEditingController(text: '$exchangeName'),
                  Icon(Icons.person),
                  () {},
                  () {},
                  TextInputType.text),
              // TextFormField(
              //   controller: nameController,
              //   // initialValue: walletName,
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     hintText: 'What do people call you?',
              //     labelText: 'Name Exchange',
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                  child: Text('save'),
                  onPressed: () {
                    ExchangeCubit.get(context).updateExchangeDatabase(
                      isId: exchangeId,
                      exchangeName: nameController.text,
                    );
                  })
            ]);
          },
        ),
      ),
    );
  }
}
