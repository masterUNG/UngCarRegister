// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ungcarregister/models/info_car_model.dart';
import 'package:ungcarregister/models/service_car_model.dart';
import 'package:ungcarregister/utility/my_constant.dart';
import 'package:ungcarregister/utility/my_dialog.dart';
import 'package:ungcarregister/utility/sqlite_helper.dart';
import 'package:ungcarregister/widgets/show_button.dart';
import 'package:ungcarregister/widgets/show_form.dart';
import 'package:ungcarregister/widgets/show_text.dart';

class AddService extends StatefulWidget {
  final InfoCarModel infoCarModel;
  const AddService({
    Key? key,
    required this.infoCarModel,
  }) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  InfoCarModel? infoCarModel;
  DateTime currentDateTime = DateTime.now();
  String? startDate, expireDate, service;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    infoCarModel = widget.infoCarModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Add Service'),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraine) {
          return Column(
            children: [
              newIdRegister(),
              newProvince(),
              newService(),
              newStart(constraine),
              newExpire(constraine),
              newAddService(constraine),
            ],
          );
        }),
      ),
    );
  }

  Container newAddService(BoxConstraints constraine) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: constraine.maxWidth * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShowButton(
              label: 'Add Service',
              pressFunc: () {
                if (service?.isEmpty ?? true) {
                  MyDialog(context: context).normalDialog(
                      'ยังไม่ได้กรอก Service', 'กรุณากรอก Service ด้วย คะ');
                } else if (startDate == null) {
                  MyDialog(context: context)
                      .normalDialog('วันเริ่มต้น ?', 'กรุณา เลือกวันเริ่มต้น');
                } else if (expireDate == null) {
                  MyDialog(context: context)
                      .normalDialog('วันสิ้นสุด ?', 'กรุณา เลือกวันสิ้นสุด');
                } else {
                  processInsertServiceToSQLite();
                }
              }),
        ],
      ),
    );
  }

  Column newStart(BoxConstraints constraine) {
    return Column(
      children: [
        SizedBox(
          width: constraine.maxWidth * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShowText(
                label: 'Start :',
                textStyle: MyConstant().h2Style(),
              ),
              IconButton(
                onPressed: () {
                  processChooseStart();
                },
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
        ),
        SizedBox(
          width: constraine.maxWidth * 0.6,
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              ShowText(label: startDate ?? 'dd/MM/yyyy'),
            ],
          ),
        ),
      ],
    );
  }

  Column newExpire(BoxConstraints constraine) {
    return Column(
      children: [
        SizedBox(
          width: constraine.maxWidth * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShowText(
                label: 'Expire :',
                textStyle: MyConstant().h2Style(),
              ),
              IconButton(
                onPressed: () {
                  processChooseExpire();
                },
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
        ),
        SizedBox(
          width: constraine.maxWidth * 0.6,
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              ShowText(label: expireDate ?? 'dd/MM/yyyy'),
            ],
          ),
        ),
      ],
    );
  }

  ShowForm newService() {
    return ShowForm(
      label: 'Service :',
      hint: 'เปลี่ยนนำ้มันเครื่อง',
      changeFunc: (String string) {
        service = string.trim();
      },
    );
  }

  ShowText newProvince() => ShowText(label: infoCarModel!.province);

  ShowText newIdRegister() {
    return ShowText(
      label: infoCarModel!.idRegister,
      textStyle: MyConstant().h1Style(),
    );
  }

  Future<void> processChooseStart() async {
    await showDatePicker(
            context: context,
            initialDate: currentDateTime,
            firstDate: DateTime(currentDateTime.year),
            lastDate: DateTime(currentDateTime.year + 5))
        .then((value) {
      print('You Choose date ==> $value');
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      setState(() {
        startDate = dateFormat.format(value!);
      });
    });
  }

  Future<void> processChooseExpire() async {
    await showDatePicker(
            context: context,
            initialDate: currentDateTime,
            firstDate: DateTime(currentDateTime.year),
            lastDate: DateTime(currentDateTime.year + 5))
        .then((value) {
      print('You Choose date ==> $value');
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      setState(() {
        expireDate = dateFormat.format(value!);
      });
    });
  }

  Future<void> processInsertServiceToSQLite() async {
    ServiceCarModel serviceCarModel = ServiceCarModel(
      idInfoCar: infoCarModel!.idRegister,
      service: service!,
      start: startDate!,
      end: expireDate!,
      status: 'wait',
    );

    await SQLiteHelper()
        .inserServiceCar(serviceCarModel)
        .then((value) => Navigator.pop(context));
  }
}
