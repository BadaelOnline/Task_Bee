import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:test_database_floor/models/contact.dart';
import 'package:test_database_floor/screens/contact/contact_home.dart';
import 'package:test_database_floor/services/contact_cubit/cubit.dart';
import 'package:test_database_floor/services/contact_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';
class UpdateContact extends StatelessWidget {
  final contactId;
  final contactName;

  TextEditingController nameController = TextEditingController();

  UpdateContact({Key key, this.contactId, this.contactName}) : super(key: key);

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
        title: Text('Update Contact'),
        backgroundColor: Colors.amber[400],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ContactCubit()..createDatabase(),
          ),
        ],
        child: BlocConsumer<ContactCubit, ContactStates>(
          listener: (context, state) {
            if (state is UpdateContactsToDatabaseState) {
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
                          controller: nameController =
                              TextEditingController(text: '$contactName'),
                          prefix: Icons.person)),
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      customRaisedButton(
                          text: 'Update',
                          onPressed: () {
                            ContactCubit.get(context).updateContactDatabase(
                              isId: contactId,
                              contactName: nameController.text,
                            );
                          }),
                      customRaisedButton(
                          text: 'Cansel',
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ContactHome()));
                          }),
                    ])
              ])),
            );
          },
        ),
      ),
    );
  }
}
