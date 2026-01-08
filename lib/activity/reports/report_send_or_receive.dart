import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/api/report_request.dart';
import 'package:kh_logistics_internal_demo/models/report/agency_send_model.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class ReportSendOrReceive extends StatefulWidget {
  final int reportType;
  final String dateFrom;
  final String dateTo;
  final int branchId;
  const ReportSendOrReceive({
    super.key,
    required this.reportType,
    required this.dateFrom,
    required this.dateTo,
    required this.branchId,
  });

  @override
  State<ReportSendOrReceive> createState() => _ReportSendOrReceiveState();
}

class _ReportSendOrReceiveState extends State<ReportSendOrReceive> {
  List reportList = [];
  String? titleAppbar;
  String? totalAmount;
  String? totalQuantity;
  bool? isLoading;

  @override
  void initState() {
    log('Branch ID: ${widget.branchId}');
    if (widget.reportType == 1) {
      titleAppbar = 'របាយការណ៍កំរៃជើងសារ(ផ្ញើ)';
      //BranchRespone respone = await Branch().getBranch('');
    } else if (widget.reportType == 2) {
      titleAppbar = 'របាយការណ៍កំរៃជើងសារ(ទទួល)';
    }
    loadReport();
    // TODO: implement initState
    super.initState();
  }

  void loadReport() async {
    setState(() {
      isLoading = true;
    });

    if (widget.reportType == 1) {
      AgencySendModel respone = await ReportRequest()
          .getAgencySend(widget.dateFrom, widget.dateTo, widget.branchId);

      setState(() {
        reportList = respone.body?.data ?? [];
        totalAmount =
            reportList.isNotEmpty ? reportList[0].totalCommission : '0';
        totalQuantity =
            reportList.isNotEmpty ? reportList[0].totalTransaction : '0';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppbar!),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  '${totalAmount ?? '0'}',
                  style: TextStyle(fontSize: 25, color: AppColor.baseColors),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text('date'.tr),
                    SizedBox(width: 10),
                    Text(':'),
                    SizedBox(width: 10),
                    Text('${widget.dateFrom} '),
                    SizedBox(width: 10),
                    Text('-'),
                    SizedBox(width: 10),
                    Text('${widget.dateTo}'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('quantity'.tr),
                    SizedBox(width: 10),
                    Text(':'),
                    SizedBox(width: 10),
                    Text('${totalQuantity ?? 0}')
                  ],
                ),
                SizedBox(height: 15),
                Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ],
            ),

            Expanded(
              child: isLoading == true
                  ? Center(child: CircularProgressIndicator())
                  : reportList.isEmpty ||
                          reportList[0].agencySendListResponseList.isEmpty
                      ? Center(child: Text('data not found'))
                      : ListView.builder(
                          itemCount:
                              reportList[0].agencySendListResponseList.length,
                          itemBuilder: (context, index) {
                            final item =
                                reportList[0].agencySendListResponseList[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 1,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(item.date ?? ''),
                                                  Spacer(),
                                                  Text(item.fee ?? ''),
                                                ],
                                              ),
                                              Text(item.code ?? ''),
                                              Text(item.destinationTo ?? ''),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              item.commission ?? '',
                                              style: TextStyle(
                                                  color: AppColor.baseColors),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
            // Expanded(
            //     child: Container(
            //   child: reportList[0].agencySendListResponseList.length == 0
            //       ? Center(
            //           child: Text('data not found'),
            //         )
            //       : ListView.builder(
            //           itemCount: reportList[0]
            //               .agencySendListResponseList
            //               .length, // Specifies the number of items
            //           itemBuilder: (context, index) {
            //             // This function is called for each visible item
            //             return Padding(
            //               padding: const EdgeInsets.only(bottom: 10),
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(10),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: Colors.grey.withOpacity(0.3),
            //                       spreadRadius: 0.8,
            //                       blurRadius: 1,
            //                       offset: Offset(1, 1),
            //                     ),
            //                   ],
            //                 ),
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(10),
            //                   child: IntrinsicHeight(
            //                     child: Row(
            //                       children: [
            //                         Container(
            //                           // color: Colors.blue,
            //                           width: MediaQuery.of(context).size.width *
            //                               0.6,
            //                           child: Column(
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Row(
            //                                 children: [
            //                                   Text(
            //                                       '${reportList[index].agencySendListResponseList[0].date}'),
            //                                   Spacer(),
            //                                   Text(
            //                                       '${reportList[index].agencySendListResponseList[0].fee}')
            //                                 ],
            //                               ),
            //                               Text(
            //                                   '${reportList[index].agencySendListResponseList[0].code}'),
            //                               Text(
            //                                   '${reportList[index].agencySendListResponseList[0].destinationTo}'),
            //                             ],
            //                           ),
            //                         ),
            //                         SizedBox(width: 10),
            //                         Container(
            //                           width: 1,
            //                           height: double.infinity,
            //                           color: Colors.grey,
            //                         ),
            //                         SizedBox(width: 10),
            //                         Expanded(
            //                             child: Center(
            //                           child: Text(
            //                             '${reportList[index].agencySendListResponseList[0].commission}',
            //                             style: TextStyle(
            //                                 color: AppColor.baseColors),
            //                           ),
            //                         ))
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            // ))
          ],
        ),
      ),
    );
  }
}
