import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_database_floor/database/database.dart';
import 'package:test_database_floor/models/contact.dart';
import 'package:test_database_floor/models/mix_data.dart';
import 'package:test_database_floor/models/transaction.dart';
import 'package:test_database_floor/services/dao/dao_transaction.dart';
import 'package:test_database_floor/services/transaction_cubit/states.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  TransactionCubit() : super(TransactionIntialState());

  static TransactionCubit get(context) => BlocProvider.of(context);

  AppDatabase database;
  TransactionDao dao;
  List<Transaction> transactions = [];
  Mix mix;
  List<Mix> mixes;
  List<Mix> transactionByContact;
  int lastId;

  void createDatabase() {
    $FloorAppDatabase
        .databaseBuilder('database_wallet.db')
        .build()
        .then((value) {
      print('oooooooooooooooooo ${value.transactionDao}');
      database = value;
      dao = database.transactionDao;
      emit(TransactionCreateDatabaseState());

      getTransactionsFromDatabase();
    });
  }

  void getTransactionsFromDatabase() {
    this.dao.findAllTransaction().then((value) {
      // getmixesFromDatabase();
      // print('111111111111111111 $value');
      transactions = value;
      if (value.length > 0) {
        lastId = value[value.length - 1].id;
      } else {
        lastId = 0;
      }

      emit(GetTransactionsFromDatabaseState());
    }).catchError((onError) {
      print('2222222222222 $onError');
    });
  }

  // void getmixFromDatabase(){
  //   this.dao.mixData().then((value) {
  //     print('111111111111111111 ${value.walletName}');
  //     mix = value;
  //     emit(GetTransactionsFromDatabaseState());
  //   });
  // }

  void getTransactionByContactFromDatabase({
    @required int contactId,
    @required int walletId,
    @required int categoryId,
    int currencyID,
  }) {
    this
        .dao
        .transactionByContact(contactId, walletId, categoryId)
        .then((value) {
      transactionByContact = value;
      emit(GetTransactionsFromDatabaseState());
    });
  }

  // void getmixesFromDatabase(){
  //   this.dao.mixesData().then((value) {
  //     for(int i = 0 ; i <value.length ;i++){
  //       print('111111111111111111 ${value[i].walletName},${value[i].exchangeCategoryName},${value[i].contactName}');
  //     }
  //     print('xxxxxxxxxxxxxxxxxxxxxx ${value.length}');
  //     mixes = value;
  //     emit(GetTransactionsFromDatabaseState());
  //   });
  // }

  Future<void> insertToDatabase(
      {@required int isId,
      @required String total,
      @required String paid,
      @required String rest,
      @required String transactionDate,
      @required String description,
      @required int exchangeId,
      @required int walletId,
      @required int contactId,
      @required int isIncome}) {
    dao
        .insertTransaction(Transaction(isId, total, paid, rest, transactionDate,
            description, 1, 1, isIncome, exchangeId, walletId, contactId))
        .then((value) {
      emit(InsertTransactionsToDatabaseState());
      getTransactionsFromDatabase();
    });
  }

  Future<void> updateTransactionDatabase({
    @required int isId,
    @required String total,
    @required String paid,
    @required String rest,
    @required String transactionDate,
    @required String description,
    @required int exchangeId,
    @required int walletId,
    @required int contactId,
  }) {
    dao
        .updateTransaction(Transaction(isId, total, paid, rest, transactionDate,
            description, 1, 1, 1, exchangeId, walletId, contactId))
        .then((value) {
      emit(UpdateTransactionsToDatabaseState());
      getTransactionsFromDatabase();
    });
  }

  void deleteTransactionFromDatabase({
    @required int id,
  }) {
    dao.deleteTransaction(id).then((value) {
      emit(DeleteTransactionsFromDatabaseState());
      getTransactionsFromDatabase();
    });
  }
}
