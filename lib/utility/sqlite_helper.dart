// ignore_for_file: empty_catches

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ungcarregister/models/info_car_model.dart';
import 'package:ungcarregister/models/service_car_model.dart';

class SQLiteHelper {
  final String nameDatabase = 'car.db';
  final String tableInfo = 'infoCar';
  final String tableService = 'serviceCar';

  final String columnid = 'id';
  final String columnidRegister = 'idRegister';
  final String columnprovince = 'province';
  final String columncar = 'car';
  final String columncolor = 'color';
  final String columnmodel = 'model';

  final String columnidInfoCar = 'idInfoCar';
  final String columnservice = 'service';
  final String columnstart = 'start';
  final String columnend = 'end';
  final String columnstatus = 'status';
  final int version = 1;

  SQLiteHelper() {
    iniDatabase();
  }

  Future<void> iniDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $tableInfo (id INTEGER PRIMARY KEY, $columnidRegister TEXT, $columnprovince TEXT, $columncar TEXT, $columncolor TEXT, $columnmodel TEXT )');
        await db.execute(
            'CREATE TABLE $tableService (id INTEGER PRIMARY KEY, $columnidInfoCar TEXT, $columnservice TEXT, $columnstart TEXT, $columnend TEXT, $columnstatus TEXT )');
      },
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<void> inserInfoCar(InfoCarModel infoCarModel) async {
    Database database = await connectedDatabase();
    print('insertInfoCar work');
    try {
      database.insert(
        tableInfo,
        infoCarModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('insertInfoCar Success');
    } catch (e) {
      print('e insertInfoCar ==> ${e.toString()}');
    }
  }

  Future<void> inserServiceCar(ServiceCarModel serviceCarModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(
        tableService,
        serviceCarModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {}
  }

  Future<List<InfoCarModel>> readInfoCar() async {
    Database database = await connectedDatabase();
    var infoCarModels = <InfoCarModel>[];

    List<Map<String, dynamic>> maps = await database.query(tableInfo);
    if (maps.isNotEmpty) {
      for (var item in maps) {
        InfoCarModel infoCarModel = InfoCarModel.fromMap(item);
        infoCarModels.add(infoCarModel);
      }
    }

    return infoCarModels;
  }

  Future<List<ServiceCarModel>> readServiceCar() async {
    Database database = await connectedDatabase();
    var serviceCarModels = <ServiceCarModel>[];
    List<Map<String, dynamic>> maps = await database.query(tableService);
    if (maps.isNotEmpty) {
      for (var item in maps) {
        ServiceCarModel serviceCarModel = ServiceCarModel.fromMap(item);
        serviceCarModels.add(serviceCarModel);
      }
    }
    return serviceCarModels;
  }

  Future<void> deleteRecordInfoCar(int id) async {
    Database database = await connectedDatabase();
    await database.delete(tableInfo, where: '$columnid = $id');
  }

  Future<void> editInfoCar(InfoCarModel infoCarModel) async {
    Database database = await connectedDatabase();
    await database.update(tableInfo, infoCarModel.toMap(), where: '$columnid = ${infoCarModel.id}');
  }
}
