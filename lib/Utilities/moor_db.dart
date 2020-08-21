import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_db.g.dart';

//flutter packages pub run build_runner build

class Master extends Table {
  TextColumn get directoryName => text().withLength(min: 1, max: 200)();
  TextColumn get directoryPath => text().withLength(min: 1, max: 200)();
  TextColumn get created => text().withLength(min: 1, max: 200)();
  TextColumn get lastModified => text().withLength(min: 1, max: 200)();
  TextColumn get imagePath => text().withLength(min: 1, max: 200)();
  IntColumn get idx => integer().nullable()();

  @override
  Set<Column> get primaryKey => {imagePath};
}

@UseMoor(tables: [Master])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;

  Future<List<MasterData>> getAllDirectories() => select(master).get();

  Stream<List<MasterData>> watchAllDirectories() => select(master).watch();

  Future insert(MasterData data) => into(master).insert(data);

  Future updateDirectory(MasterData data) =>
      update(master).replace(data);

  Future deleteDirectory(MasterData data) =>
      delete(master).delete(data);
}
