// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ungcarregister/models/info_car_model.dart';
import 'package:ungcarregister/states/add_new_car.dart';
import 'package:ungcarregister/utility/my_constant.dart';
import 'package:ungcarregister/utility/sqlite_helper.dart';
import 'package:ungcarregister/widgets/show_button.dart';
import 'package:ungcarregister/widgets/show_progress.dart';
import 'package:ungcarregister/widgets/show_text.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<InfoCarModel>? infoCarModels;
  bool load = true;
  bool? haveData;

  @override
  void initState() {
    super.initState();
    readAllCar();
  }

  Future<void> readAllCar() async {
    await SQLiteHelper().readInfoCar().then((value) {
      infoCarModels = value;
      print('infoCarModels ==>> $infoCarModels');

      if (infoCarModels!.isEmpty) {
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        setState(() {
          load = false;
          haveData = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ShowButton(
        label: 'Add New Car',
        pressFunc: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewCart(),
            )),
      ),
      appBar: AppBar(),
      body: load
          ? const ShowProgress()
          : haveData!
              ? Text('Have Data')
              : Center(
                  child: ShowText(
                    label: 'No Car',
                    textStyle: MyConstant().h1Style(),
                  ),
                ),
    );
  }
}
