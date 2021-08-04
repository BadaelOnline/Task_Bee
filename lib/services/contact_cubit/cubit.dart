import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/database/database.dart';
import 'package:test_database_floor/models/contact.dart';
import 'package:test_database_floor/services/contact_cubit/states.dart';
import 'package:test_database_floor/services/dao/dao_contact.dart';


class ContactCubit extends Cubit<ContactStates>{
  ContactCubit() : super(ContactIntialState());

  static ContactCubit get(context) => BlocProvider.of(context);

  AppDatabase database ;
  ContactDao dao  ;
  List<Contact> contacts = [];
  int lastId ;

  void createDatabase(){
    $FloorAppDatabase.databaseBuilder('database_wallet.db').build().then((value) {
      database = value;
      dao = database.contactDao;
      emit(ContactCreateDatabaseState());

      getContactsFromDatabase();
    });
  }

  void getContactsFromDatabase(){
    this.dao.retrieveContacts().then((value) {
      contacts = value;
      if(value.length > 0){
        lastId = value[value.length -1].id;
      }else{
        lastId = 0;
      }

      emit(GetContactsFromDatabaseState());


    });
  }



  Future<void> insertToDatabase({
    @required int isId,
    @required String contactName,
  }){
    dao.insertContact(Contact(isId, contactName, 1, 1)).then((value) {
      emit(InsertContactsToDatabaseState());
      getContactsFromDatabase();

    });
  }

  Future<void> updateContactDatabase({
    @required int isId,
    @required String contactName,
  }){
    dao.updateContact(Contact(isId, contactName, 1,1)).then((value) {
      emit(UpdateContactsToDatabaseState());
      getContactsFromDatabase();

    });
  }

  void deleteContactFromDatabase({
    @required int id,
  }){
    dao.deleteContact(id).then((value)  {
      emit(DeleteContactsFromDatabaseState());
      getContactsFromDatabase();
    });
  }

  int getContactId({
    @required String contactName,
  }){
    for(int i = 0 ; i <contacts.length;i++){
      if(contacts[i].name == contactName){
        return contacts[i].id;
      }
    }
    return 0;
  }




}