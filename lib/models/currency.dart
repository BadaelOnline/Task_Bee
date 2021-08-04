import 'package:floor/floor.dart';
import 'package:test_database_floor/models/wallet.dart';

@Entity(
  tableName: 'currency',
)
class Currency {
  @PrimaryKey()
  final int id;

  final String name;
  final String code;
  final String icon;



  Currency(this.id, this.name, this.code, this.icon);
}
