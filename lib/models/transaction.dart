import 'package:floor/floor.dart';
import 'package:test_database_floor/models/wallet.dart';

import 'contact.dart';
import 'exchange_category.dart';

@Entity(
  tableName: 'transaction',
  primaryKeys: ['id'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['exchange_id'],
      parentColumns: ['id'],
      entity: ExchangeCategory,
    ),
    ForeignKey(
      childColumns: ['wallet_id'],
      parentColumns: ['id'],
      entity: Wallet,
    ),
    ForeignKey(
      childColumns: ['contact_id'],
      parentColumns: ['id'],
      entity: Contact,
    ),
  ],
)
class Transaction {
  @PrimaryKey()
  final int id;

  final String total;
  final String paid;
  final String rest;

  @ColumnInfo(name: 'transaction_date')
  final String transactionDate;
  final String description;

  @ColumnInfo(name: 'is_active')
  final int isActive;

  @ColumnInfo(name: 'is_appear')
  final int isAppear;

  @ColumnInfo(name: 'is_income')
  final int isIncome;

  @ColumnInfo(name: 'exchange_id')
  final int exchangeId;

  @ColumnInfo(name: 'wallet_id')
  final int walletId;

  @ColumnInfo(name: 'contact_id')
  final int contactId;

  Transaction(this.id,  this.total, this.paid, this.rest, this.transactionDate, this.description, this.isActive, this.isAppear, this.isIncome, this.exchangeId, this.walletId, this.contactId);
}
