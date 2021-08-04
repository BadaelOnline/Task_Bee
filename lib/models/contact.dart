import 'package:floor/floor.dart';

@Entity(tableName: 'contact', primaryKeys: ['id'])
class Contact {
  final int id;

  @ColumnInfo(name: 'name_contact')
  final String name;

  @ColumnInfo(name: 'is_active')
  final int isActive;

  @ColumnInfo(name: 'is_appear')
  final int isAppear;

  Contact(this.id, this.name, this.isActive, this.isAppear);
}
