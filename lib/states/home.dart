// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:ungcarregister/models/info_car_model.dart';
import 'package:ungcarregister/states/add_new_car.dart';
import 'package:ungcarregister/states/edit_info_car.dart';
import 'package:ungcarregister/states/show_list_service.dart';
import 'package:ungcarregister/utility/my_constant.dart';
import 'package:ungcarregister/utility/my_dialog.dart';
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
    if (infoCarModels != null) {
      if (infoCarModels!.isNotEmpty) {
        infoCarModels!.clear();
      }
    }
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
            )).then((value) => readAllCar()),
      ),
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
      ),
      body: load
          ? const ShowProgress()
          : haveData!
              ? ListView.builder(
                  itemCount: infoCarModels!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      print('You Click');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowListService(
                              infoCarModel: infoCarModels![index],
                            ),
                          ));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ShowText(
                                  label: infoCarModels![index].idRegister,
                                  textStyle: MyConstant().h1Style(),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditInfoCar(
                                          infoCarModel: infoCarModels![index],
                                        ),
                                      ),
                                    ).then((value) => readAllCar());
                                  },
                                  icon: const Icon(Icons.edit_outlined),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    print(
                                        'delete at idRegister ==> ${infoCarModels![index].idRegister}');
                                    await MyDialog(context: context)
                                        .deleteInfoCarDialog(
                                            infoCarModels![index]);
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                            ShowText(
                              label: infoCarModels![index].province,
                              textStyle: MyConstant().h2Style(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ShowText(
                                      label:
                                          'ยี่ห้อ = ${infoCarModels![index].car}'),
                                  ShowText(
                                      label:
                                          'สี = ${infoCarModels![index].color}'),
                                  ShowText(
                                      label:
                                          'รุ่น = ${infoCarModels![index].model}'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: ShowText(
                    label: 'No Car',
                    textStyle: MyConstant().h1Style(),
                  ),
                ),
    );
  }
}
