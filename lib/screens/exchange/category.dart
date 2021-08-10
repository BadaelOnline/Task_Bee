import 'package:flutter/material.dart';
import 'package:test_database_floor/screens/exchange/add_exchange.dart';
import 'package:test_database_floor/services/exchange_cubit/cubit.dart';
import 'package:test_database_floor/services/exchange_cubit/states.dart';
import 'package:test_database_floor/screens/exchange/exchange_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .pop(MaterialPageRoute(builder: (context) => AddExchange()));
            },
          ),
          centerTitle: true,
          title: Text('Add Exchang Category'),
          backgroundColor: Colors.amber[400],
        ),
        body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) =>
                    ExchangeCubit()..createDatabase(),
              ),
            ],
            child: BlocConsumer<ExchangeCubit, ExchangeStates>(
              listener: (context, ExchangeStates state) {
                if (state is InsertExchangesToDatabaseState) {
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => ExchangeHome()));
                }
              },
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: InkWell(
                    onTap: () {},
                    child: GridView.extent(
                      mainAxisSpacing: 7.0,
                      maxCrossAxisExtent: 75.0,
                      crossAxisSpacing: 7.0,
                      children: _buildGridImages(65, context),
                    ),
                  ),
                );
              },
            )));
  }
}

List<Widget> _buildGridImages(numberOfImage, context) {
  List<Container> containers =
      List<Container>.generate(numberOfImage, (int index) {
    final imageName = index < 9
        ? 'assets/category/image0${index + 1}.png'
        : 'assets/category/image${index + 1}.png';
    return Container(
      child: InkWell(
        child: Image.asset(imageName),
        onTap: () {
          print('image name is $imageName');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AddExchange(
                        catImage: imageName,
                      )));
        },
      ),
    );
  });
  return containers;
}
