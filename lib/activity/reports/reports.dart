import 'package:flutter/material.dart';
import 'package:kh_logistics_internal_demo/activity/reports/report_agency_send.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReportAgencySend()),
                );
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.baseColors,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 3,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    'របាយការណ៍កំរៃជើងសារ(ផ្ញើ)',
                    style: const TextStyle(
                      color: AppColor.background_color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.baseColors,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 3,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    'របាយការណ៍កំរៃជើងសារ(ទទួល)',
                    style: const TextStyle(
                      color: AppColor.background_color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.baseColors,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 3,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    'របាយការណ៍ទូទាត់សម្រាប់(ភ្នាក់ងារ)',
                    style: const TextStyle(
                      color: AppColor.background_color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
