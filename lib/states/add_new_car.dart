import 'package:flutter/material.dart';
import 'package:ungcarregister/models/info_car_model.dart';
import 'package:ungcarregister/utility/my_dialog.dart';
import 'package:ungcarregister/utility/sqlite_helper.dart';
import 'package:ungcarregister/widgets/show_button.dart';
import 'package:ungcarregister/widgets/show_form.dart';

class AddNewCart extends StatefulWidget {
  const AddNewCart({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewCart> createState() => _AddNewCartState();
}

class _AddNewCartState extends State<AddNewCart> {
  String? idRegister, province, car, color, model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            newCarRegister(),
            newProvince(),
            newCar(),
            newCarColor(),
            newCarModel(),
            newSaveCar(),
          ],
        ),
      ),
    );
  }

  Container newSaveCar() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: 250,
      child: ShowButton(
        label: 'Save Car',
        pressFunc: () {
          print(
              'idRegister = $idRegister, province = $province, \n car = $car, color = $color, model = $model');

          if ((idRegister?.isEmpty ?? true) ||
              (province?.isEmpty ?? true) ||
              (car?.isEmpty ?? true) ||
              (color?.isEmpty ?? true) ||
              (model?.isEmpty ?? true)) {
            MyDialog(context: context)
                .normalDialog('มีช่องว่าง ?', 'กรุณากรอก ทุกช่อง คะ');
          } else {
            processSaveCar();
          }
        },
      ),
    );
  }

  ShowForm newCarRegister() {
    return ShowForm(
      label: 'เลยทะเบียน',
      hint: '00 กข 0000',
      changeFunc: (String string) {
        idRegister = string.trim();
      },
    );
  }

  ShowForm newProvince() {
    return ShowForm(
      label: 'จังหวัด',
      hint: 'กรุงเทพมหานคร',
      changeFunc: (String string) {
        province = string.trim();
      },
    );
  }

  ShowForm newCar() {
    return ShowForm(
      label: 'ยี่ห้อรถ',
      hint: 'Nissan',
      changeFunc: (String string) {
        car = string.trim();
      },
    );
  }

  ShowForm newCarColor() {
    return ShowForm(
      label: 'สี่ของรถ',
      hint: 'แดง',
      changeFunc: (String string) {
        color = string.trim();
      },
    );
  }

  ShowForm newCarModel() {
    return ShowForm(
      label: 'รุ่นของรถ',
      hint: 'Almalar',
      changeFunc: (String string) {
        model = string.trim();
      },
    );
  }

  Future<void> processSaveCar() async {
    InfoCarModel infoCarModel = InfoCarModel(
      idRegister: idRegister!,
      province: province!,
      car: car!,
      color: color!,
      model: model!,
    );

    print('infoCarModel ==> ${infoCarModel.toMap()}');

    await SQLiteHelper()
        .inserInfoCar(infoCarModel)
        .then((value) => Navigator.pop(context));
  }
}
