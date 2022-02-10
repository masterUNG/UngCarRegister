// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ungcarregister/models/info_car_model.dart';
import 'package:ungcarregister/utility/my_constant.dart';
import 'package:ungcarregister/utility/my_dialog.dart';
import 'package:ungcarregister/utility/sqlite_helper.dart';
import 'package:ungcarregister/widgets/show_button.dart';
import 'package:ungcarregister/widgets/show_form.dart';

class EditInfoCar extends StatefulWidget {
  final InfoCarModel infoCarModel;
  const EditInfoCar({
    Key? key,
    required this.infoCarModel,
  }) : super(key: key);

  @override
  State<EditInfoCar> createState() => _EditInfoCarState();
}

class _EditInfoCarState extends State<EditInfoCar> {
  InfoCarModel? infoCarModel;
  TextEditingController idRegisterCarController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController carController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  bool change = false;
  Map<String, dynamic>? map;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    infoCarModel = widget.infoCarModel;
    map = infoCarModel!.toMap();

    idRegisterCarController.text = infoCarModel!.idRegister;
    provinceController.text = infoCarModel!.province;
    carController.text = infoCarModel!.car;
    colorController.text = infoCarModel!.color;
    modelController.text = infoCarModel!.model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Edit Car'),
      ),
      body: Center(
        child: Column(
          children: [
            newIdRegister(),
            newProcince(),
            newCar(),
            newColor(),
            newModel(),
            newSave(),
          ],
        ),
      ),
    );
  }

  ShowButton newSave() => ShowButton(
      label: 'Save Edit Car',
      pressFunc: () async {
        if (change) {
          InfoCarModel model = InfoCarModel.fromMap(map!);

          await SQLiteHelper()
              .editInfoCar(model)
              .then((value) => Navigator.pop(context));
        } else {
          MyDialog(context: context)
              .normalDialog('No Change ?', 'Pleae Change Some One For Edit');
        }
      });

  ShowForm newIdRegister() {
    return ShowForm(
        controller: idRegisterCarController,
        label: 'ทะเบียนรถ',
        hint: '12 กก 1234',
        changeFunc: (String string) {
          change = true;
          map!['idRegister'] = string.trim();
        });
  }

  ShowForm newProcince() {
    return ShowForm(
        controller: provinceController,
        label: 'จังหวัด',
        hint: '',
        changeFunc: (String string) {
          change = true;
          map!['province'] = string.trim();
        });
  }

  ShowForm newCar() {
    return ShowForm(
        controller: carController,
        label: 'ยี่ห้อ',
        hint: '',
        changeFunc: (String string) {
          change = true;
          map!['car'] = string.trim();
        });
  }

  ShowForm newColor() {
    return ShowForm(
        controller: colorController,
        label: 'สีรถ',
        hint: '',
        changeFunc: (String string) {
          change = true;
          map!['color'] = string.trim();
        });
  }

  ShowForm newModel() {
    return ShowForm(
        controller: modelController,
        label: 'รุ่นรถ',
        hint: '',
        changeFunc: (String string) {
          change = true;
          map!['model'] = string.trim();
        });
  }
}
