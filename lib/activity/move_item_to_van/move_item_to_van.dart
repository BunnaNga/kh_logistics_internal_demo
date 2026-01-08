import 'dart:developer';
import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/destination_screen.dart';
import 'package:kh_logistics_internal_demo/activity/select_branch.dart';
import 'package:kh_logistics_internal_demo/activity/input_or_scan_item.dart';
import 'package:kh_logistics_internal_demo/activity/select_van.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class MoveItemToVan extends StatefulWidget {
  const MoveItemToVan({super.key});

  @override
  State<MoveItemToVan> createState() => _MoveItemToVanState();
}

class _MoveItemToVanState extends State<MoveItemToVan> {
  DateTime? selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool goodsIn = false;
  bool goodsOut = false;
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
  initState() {
    // log('Generated sys code: ${generateSysCode()}');
    super.initState();
  }

  @override
  void dispose() {
    ValueStatics.branchTitle = '';
    ValueStatics.branchId = null;
    ValueStatics.destinationToTitle = '';
    ValueStatics.destinationToId = null;
    ValueStatics.vanId = null;

    ValueStatics.vanName = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Move Item to Van'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
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
                    MaterialPageRoute(builder: (context) => BranchScreen()),
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
                        Text(ValueStatics.branchTitle.isEmpty
                            ? 'please_select'.tr
                            : ValueStatics.branchTitle),
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
              Text('item_type'.tr, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),

              Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          _onGoodsInChanged(true);
                        },
                        child: Row(
                          children: [
                            Icon(
                                goodsIn
                                    ? Icons.check_box // when true
                                    : Icons.check_box_outline_blank,
                                color: goodsIn
                                    ? AppColor.baseColors
                                    : Colors.grey),
                            Text('goods_in'.tr)
                          ],
                        ),
                      ),
                      SizedBox(width: 40),
                      InkWell(
                        onTap: () {
                          _onGoodsOutChanged(true);
                        },
                        child: Row(
                          children: [
                            Icon(
                                goodsOut
                                    ? Icons.check_box // when true
                                    : Icons.check_box_outline_blank,
                                color: goodsOut
                                    ? AppColor.baseColors
                                    : Colors.grey),
                            Text('goods_out'.tr)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
              SizedBox(height: 20),
              Text('destination_to'.tr, style: TextStyle(fontSize: 16)),
              InkWell(
                onTap: all == false
                    ? () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DestinationScreen(
                                    destinationTitle: 'destination_to'.tr,
                                    destinationType: 2,
                                  )),
                        );
                        if (result != null) {
                          setState(() {});
                        }
                      }
                    : null,
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
                        Text(ValueStatics.destinationToTitle.isEmpty
                            ? 'please_select'.tr
                            : ValueStatics.destinationToTitle),
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
              Text('van'.tr, style: TextStyle(fontSize: 16)),
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
              SizedBox(height: 20),
              Text('departure_time'.tr, style: TextStyle(fontSize: 16)),
              InkWell(
                onTap: () {
                  _selectTime(context);
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
                        Text('${selectedTime.hour}:${selectedTime.minute}:00'
                            .tr),
                        Icon(
                          Icons.watch_later_outlined,
                          size: 25,
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
                      // required this.date,
                      // required this.branchId,
                      // required this.destinationToId,
                      // this.vanId,
                      // this.departureTime,
                      // this.scanCode,
                      // this.sysCode,
                      // this.type,
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InputOrScanItem(
                                  moveType: 1,
                                  date:
                                      '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}',
                                  branchId: ValueStatics.branchId ?? 0,
                                  destinationToId: all != true
                                      ? ValueStatics.destinationToId ?? 0
                                      : 0,
                                  vanId: ValueStatics.vanId ?? 0,
                                  departureTime:
                                      '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00',
                                  sysCode: generateSysCode(),
                                  type: goodsIn == true ? 1 : 2,
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
              // OutlinedButton(
              //     onPressed: _selectDate, child: const Text('Select Date')),
            ],
          ),
        ));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            useMaterial3: false,
            colorScheme: ColorScheme.light(
              primary: AppColor.baseColors,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.baseColors,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              hourMinuteTextColor: AppColor.baseColors,
              dayPeriodTextColor: AppColor.baseColors,
              dialBackgroundColor: Colors.grey[200],
              dialHandColor: AppColor.baseColors,
              entryModeIconColor: AppColor.baseColors,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
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
      all = !all;
    });
  }

  void _onGoodsInChanged(bool? value) {
    setState(() {
      goodsIn = !goodsIn;
      if (goodsIn) {
        goodsOut = false;
      }
    });
  }

  void _onGoodsOutChanged(bool? value) {
    setState(() {
      goodsOut = !goodsOut;
      if (goodsOut) {
        goodsIn = false;
      }
    });
  }
}
