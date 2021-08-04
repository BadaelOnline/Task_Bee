import 'package:flutter/material.dart';
import 'package:test_database_floor/screens/contact/add_contact.dart';
import 'package:test_database_floor/screens/contact/update_contact.dart';
import 'package:test_database_floor/services/contact_cubit/cubit.dart';
import 'package:test_database_floor/services/contact_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:test_database_floor/widget/custom_appBar.dart';
import 'package:test_database_floor/widget/custom_widgets.dart';

class ContactHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ContactCubit()..createDatabase(),
        ),
      ],
      child: BlocConsumer<ContactCubit, ContactStates>(
        listener: (BuildContext context, ContactStates state) {},
        builder: (BuildContext context, ContactStates state) {
          ContactCubit cubit = ContactCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title: Text('My Contact'),
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
                    itemCount: cubit.contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            cubit.deleteContactFromDatabase(
                                id: cubit.contacts[index].id);
                          },
                        ),
                        contentPadding: EdgeInsets.all(8.0),
                        title: Row(
                          children: [
                            Image.asset(
                              'assets/image/user.png',
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(cubit.contacts[index].name),
                          ],
                        ),
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateContact(
                                      contactId: cubit.contacts[index].id,
                                      contactName: cubit.contacts[index].name,
                                    ))),
                      ));
                    },
                  );
                },
              ),
              floatingActionButton: customFloatinActionButton(
                icon: Icon(Icons.add),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddContact())),
              ));
        },
      ),
    );
  }
}
