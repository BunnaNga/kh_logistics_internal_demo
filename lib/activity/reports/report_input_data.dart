import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/destination_screen.dart';
import 'package:kh_logistics_internal_demo/activity/reports/report_agency_claim.dart';
import 'package:kh_logistics_internal_demo/activity/reports/report_send_or_receive.dart';
import 'package:kh_logistics_internal_demo/activity/select_branch.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class ReportInputData extends StatefulWidget {
  final String titleAppbar;
  final int type;
  const ReportInputData(
      {super.key, required this.titleAppbar, required this.type});

  @override
  State<ReportInputData> createState() => _ReportInputDataState();
}

class _ReportInputDataState extends State<ReportInputData> {
  DateTime? selectedDateFrom;
  DateTime? selectedDateTo;

  @override
  void initState() {
    log('Report Type: ${widget.type}');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleAppbar),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'from'.tr} *',
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              onTap: () {
                _selectDateFrom();
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
                      Text(selectedDateFrom == null
                          ? 'please_select'.tr
                          : '${selectedDateFrom!.year}-${selectedDateFrom!.month}-${selectedDateFrom!.day}'),
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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '${'to'.tr} *',
                style: TextStyle(fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () {
                _selectDateTo();
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
                      Text(selectedDateTo == null
                          ? 'please_select'.tr
                          : '${selectedDateTo!.year}-${selectedDateTo!.month}-${selectedDateTo!.day}'),
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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Text('branch'.tr),
                  SizedBox(width: 5),
                  Text(
                    '*',
                    style: TextStyle(color: AppColor.baseColors),
                  ),
                ],
              ),
            ),
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
                      )
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
                    if (widget.type != 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => ReportSendOrReceive(
                            reportType: widget.type,
                            dateFrom:
                                '${selectedDateFrom!.year}-${selectedDateFrom!.month.toString().padLeft(2, '0')}-${selectedDateFrom!.day.toString().padLeft(2, '0')}',
                            dateTo:
                                '${selectedDateTo!.year}-${selectedDateTo!.month.toString().padLeft(2, '0')}-${selectedDateTo!.day.toString().padLeft(2, '0')}',
                            branchId: ValueStatics.branchId!,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => ReportAgencyClaim(
                            reportType: widget.type,
                            branchTitle: ValueStatics.branchTitle,
                            dateFrom:
                                '${selectedDateFrom!.year}-${selectedDateFrom!.month.toString().padLeft(2, '0')}-${selectedDateFrom!.day.toString().padLeft(2, '0')}',
                            dateTo:
                                '${selectedDateTo!.year}-${selectedDateTo!.month.toString().padLeft(2, '0')}-${selectedDateTo!.day.toString().padLeft(2, '0')}',
                            branchId: ValueStatics.branchId!,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.baseColors,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'search'.tr,
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
      ),
    );
  }

  Future<void> _selectDateFrom() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
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
        selectedDateFrom = pickedDate;
      });
    }
  }

  Future<void> _selectDateTo() async {
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
        selectedDateTo = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ValueStatics.branchTitle = '';
    ValueStatics.branchId = null;
    super.dispose();
  }
}
