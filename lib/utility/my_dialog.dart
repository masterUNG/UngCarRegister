// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungcarregister/models/info_car_model.dart';
import 'package:ungcarregister/states/home.dart';
import 'package:ungcarregister/utility/my_constant.dart';
import 'package:ungcarregister/utility/sqlite_helper.dart';
import 'package:ungcarregister/widgets/show_button.dart';
import 'package:ungcarregister/widgets/show_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> deleteInfoCarDialog(InfoCarModel infoCarModel) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: ListTile(
                leading: const Icon(
                  Icons.delete_forever_outlined,
                  size: 48,
                  color: Colors.red,
                ),
                title: ShowText(
                  label: 'Delete ${infoCarModel.idRegister} ?',
                  textStyle: MyConstant().h2Style(),
                ),
                subtitle: ShowText(
                    label:
                        'ยี่ห้อ ${infoCarModel.car}, สี่ ${infoCarModel.color}, \n รุ่น ${infoCarModel.model}'),
              ),
              actions: [
                ShowButton(
                    label: 'Delete',
                    pressFunc: () async {
                      await SQLiteHelper()
                          .deleteRecordInfoCar(infoCarModel.id!)
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                            (route) => false);

                        return;
                      });
                    }),
                ShowButton(
                    label: 'Cancel',
                    pressFunc: () {
                      Navigator.pop(context);
                    }),
              ],
            ));
  }

  Future<void> normalDialog(String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ShowText(
          label: title,
          textStyle: MyConstant().h2Style(),
        ),
        content: ShowText(label: message),
        actions: [
          ShowButton(label: 'OK', pressFunc: () => Navigator.pop(context))
        ],
      ),
    );
  }
}
