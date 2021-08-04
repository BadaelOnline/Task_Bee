import 'package:flutter/material.dart';
import 'package:test_database_floor/screens/contact/contact_home.dart';
import 'package:test_database_floor/services/contact_cubit/cubit.dart';
import 'package:test_database_floor/services/contact_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';


class AddContact extends StatelessWidget {
  TextEditingController nameController = TextEditingController();

  int isID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ContactHome()));
          },
        ),
        centerTitle: true,
        title: Text('Add Contact'),
        backgroundColor: Colors.amber[400],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ContactCubit()..createDatabase(),
          ),
        ],
        child: BlocConsumer<ContactCubit, ContactStates>(
          listener: (context, ContactStates state) {
            if (state is InsertContactsToDatabaseState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ContactHome()));
            }
          },
          builder: (context, state) {
            return Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/user.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: customFormField(
                            label: 'Name Contact',
                            controller: nameController,
                            prefix: Icons.person)),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      customRaisedButton(
                          onPressed: () {
                            ContactCubit.get(context).insertToDatabase(
                              isId: isID,
                              contactName: nameController.text,
                            );
                          },
                          text: 'Save'),
                      customRaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ContactHome()));
                          },
                          text: 'Cansel'),
                    ],
                  )
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
