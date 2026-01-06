import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/destination_screen.dart';
import 'package:kh_logistics_internal_demo/activity/input_or_scan_item.dart';
import 'package:kh_logistics_internal_demo/activity/select_van.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class MoveItemFromVan extends StatefulWidget {
  const MoveItemFromVan({super.key});

  @override
  State<MoveItemFromVan> createState() => _MoveItemFromVanState();
}

class _MoveItemFromVanState extends State<MoveItemFromVan> {
  DateTime? selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool all = false;

  String generateSysCode({int length = 10}) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();

    return List.generate(
      length,
      (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  @override
  void dispose() {
    ValueStatics.destinationFromTitle = '';
    ValueStatics.vanName = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Move Item from Van'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'date'.tr,
                style: TextStyle(fontSize: 16),
              ),
              InkWell(
                onTap: () {
                  _selectDate();
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white, // optional background color
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColor.baseColors, // yellow border
                      width: 2, // thickness of border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'),
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 25,
                          color: AppColor.baseColors,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('branch'.tr, style: TextStyle(fontSize: 16)),
              InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DestinationScreen(
                              destinationTitle: 'destination_from'.tr,
                              destinationType: 1,
                            )),
                  );
                  if (result != null) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white, // optional background color
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColor.baseColors, // yellow border
                      width: 2, // thickness of border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ValueStatics.destinationFromTitle.isEmpty
                            ? 'please_select'.tr
                            : ValueStatics.destinationFromTitle),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: AppColor.baseColors,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('van'.tr, style: TextStyle(fontSize: 16)),
                  InkWell(
                    onTap: () {
                      _onAllChanged(true);
                    },
                    child: Row(
                      children: [
                        Icon(
                            all
                                ? Icons.check_box // when true
                                : Icons.check_box_outline_blank,
                            color: all ? AppColor.baseColors : Colors.grey),
                        Text('all'.tr)
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VanScreen()),
                  );
                  if (result != null) {
                    setState(() {});
                  }
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white, // optional background color
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColor.baseColors, // yellow border
                      width: 2, // thickness of border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ValueStatics.vanName.isEmpty
                            ? 'please_select'.tr
                            : ValueStatics.vanName),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: AppColor.baseColors,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InputOrScanItem(
                                  moveType: 2,
                                  date:
                                      '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}',
                                  branchId: ValueStatics.destinationFromId ?? 0,
                                  vanId: all ? 0 : ValueStatics.vanId ?? 0,
                                  sysCode: generateSysCode(),
                                )),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.baseColors,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'continue'.tr,
                          style: TextStyle(
                              color: AppColor.whiteTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            useMaterial3: false,
            colorScheme: ColorScheme.light(
              primary: AppColor.baseColors, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.baseColors, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _onAllChanged(bool? value) {
    setState(() {
      if (all == true && value == true) {
        all = false;
      } else {
        all = true;
      }
    });
  }
}
