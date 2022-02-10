// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';

import 'package:ungcarregister/models/info_car_model.dart';
import 'package:ungcarregister/models/service_car_model.dart';
import 'package:ungcarregister/states/add_service.dart';
import 'package:ungcarregister/utility/my_constant.dart';
import 'package:ungcarregister/utility/sqlite_helper.dart';
import 'package:ungcarregister/widgets/show_button.dart';
import 'package:ungcarregister/widgets/show_progress.dart';
import 'package:ungcarregister/widgets/show_text.dart';

class ShowListService extends StatefulWidget {
  final InfoCarModel infoCarModel;
  const ShowListService({
    Key? key,
    required this.infoCarModel,
  }) : super(key: key);

  @override
  State<ShowListService> createState() => _ShowListServiceState();
}

class _ShowListServiceState extends State<ShowListService> {
  InfoCarModel? infoCarModel;
  bool load = true;
  var serviceCarModels = <ServiceCarModel>[];

  @override
  void initState() {
    super.initState();
    infoCarModel = widget.infoCarModel;
    readServiceWhereIdRegister();
  }

  Future<void> readServiceWhereIdRegister() async {
    if (serviceCarModels.isNotEmpty) {
      serviceCarModels.clear();
    }

    String idRegister = infoCarModel!.idRegister;
    print('ทะเบียนรถ ที่หา $idRegister');
    await SQLiteHelper().readServiceCar().then((value) {
      print('value ที่ได้จาก SQLite Service ==> $value');

      if (value.isNotEmpty) {
        for (var item in value) {
          if (idRegister == item.idInfoCar) {
            setState(() {
              serviceCarModels.add(item);
              load = false;
            });
          } else {
            setState(() {
              load = false;
            });
          }
        }
      } else {
        setState(() {
          load = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ShowButton(
        label: 'Add Service',
        pressFunc: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddService(
              infoCarModel: infoCarModel!,
            ),
          ),
        ).then((value) => readServiceWhereIdRegister()),
      ),
      appBar: newAppbar(),
      body: load
          ? const ShowProgress()
          : serviceCarModels.isEmpty
              ? Center(
                  child: ShowText(
                    label: 'No Service Data',
                    textStyle: MyConstant().h1Style(),
                  ),
                )
              : ListView.builder(
                  itemCount: serviceCarModels.length,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShowText(
                            label: serviceCarModels[index].service,
                            textStyle: MyConstant().h2Style(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ShowText(label: 'Start :'),
                              ShowText(
                                label: serviceCarModels[index].start,
                                textStyle: MyConstant().h3GreenStyle(),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ShowText(label: 'Expair :'),
                              ShowText(
                                label: serviceCarModels[index].end,
                                textStyle: MyConstant().h3RedStyle(),
                              ),
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ShowText(label: 'Status : ${serviceCarModels[index].status}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  AppBar newAppbar() {
    return AppBar(
      backgroundColor: MyConstant.primary,
      title: Text(infoCarModel!.idRegister),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 48),
              child: ShowText(
                label: infoCarModel!.province,
                textStyle: MyConstant().h3WhiteStyle(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
