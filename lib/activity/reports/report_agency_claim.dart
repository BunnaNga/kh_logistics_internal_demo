import 'package:flutter/material.dart';
import 'package:kh_logistics_internal_demo/api/report_request.dart';
import 'package:kh_logistics_internal_demo/models/report/agency_claim_model.dart';

class ReportAgencyClaim extends StatefulWidget {
  final int reportType;
  final String branchTitle;
  final String dateFrom;
  final String dateTo;
  final int branchId;
  const ReportAgencyClaim({
    super.key,
    required this.reportType,
    required this.branchTitle,
    required this.dateFrom,
    required this.dateTo,
    required this.branchId,
  });

  @override
  State<ReportAgencyClaim> createState() => _ReportAgencyClaimState();
}

class _ReportAgencyClaimState extends State<ReportAgencyClaim> {
  bool? isLoading;
  List reportList = [];

  @override
  void initState() {
    loadReport();
    // TODO: implement initState
    super.initState();
  }

  void loadReport() async {
    setState(() {
      isLoading = true;
    });

    ReportAgencyClaimModel respone = await ReportRequest()
        .getAgencyClaim(widget.dateFrom, widget.dateTo, widget.branchId);

    setState(() {
      reportList = respone.body?.data ?? [];
      // totalAmount = reportList.isNotEmpty ? reportList[0].totalCommission : '0';
      // totalQuantity =
      //     reportList.isNotEmpty ? reportList[0].totalTransaction : '0';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('របាយការណ៍ទូទាត់សម្រាប់(ភ្នាក់ងារ)'),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 70),
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child:
                            Image.asset('assets/images/kh_logistic_logo.png'),
                      ),
                    ),
                  ),
                  Text(
                    'របាយការណ៍ចំណូលសម្រាប់ (ភ្នាក់ងារ)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ពី: ${widget.dateFrom} ថ្ងៃ: ${widget.dateTo}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ភ្នាក់ងារ: ${widget.branchTitle}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          '1.សរុបកំរៃជើងសារទទួលអីវ៉ាន់ភ្នាក់ងារ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(':'),
                      Text('${reportList[0].totalReceive}')
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          '2.សរុបកំរៃជើងសារផ្ញើអីវ៉ាន់ភ្នាក់ងារ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(':'),
                      Text('${reportList[0].totalAddGoods}'),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 - 20,
                        child: Text(
                          'សរុបចំនួនដែលត្រូវទូទាត់មកក្រុមហ៊ុន',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(fontSize: 17),
                      ),
                      Expanded(
                        child: Text(
                          '${reportList[0].totalClaim}\nCOD (ប្រមូលថ្លៃអីវ៉ាន់ជំនួស)\n${reportList[0].totalCod}',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
