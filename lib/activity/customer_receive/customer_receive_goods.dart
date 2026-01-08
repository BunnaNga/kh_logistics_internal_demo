import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/api/customer_receive_request.dart';
import 'package:kh_logistics_internal_demo/models/receive/customer_receive_check_model.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class CustomerReceiveGoods extends StatefulWidget {
  final CustomerReceiveCheckModel data;
  final String qrcodeScan;
  const CustomerReceiveGoods(
      {super.key, required this.data, required this.qrcodeScan});

  @override
  State<CustomerReceiveGoods> createState() => _CustomerReceiveGoodsState();
}

class _CustomerReceiveGoodsState extends State<CustomerReceiveGoods> {
  List item = [];
  @override
  void initState() {
    log('data is: ${widget.data.body}');
    item = widget.data.body?.data ?? [];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Receive'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'code'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${item[0].code}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'sender_telephone'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${item[0].senderTelephone}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'receiver_telephone'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${item[0].receiverTelephone}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'to_destination'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '${item[0].destinationTo}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const CustomerReceiveCheck()),
                        // );
                        log('on click');
                        CustomerReceiveRequest()
                            .customerReceive(widget.qrcodeScan, context);
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColor.baseColors,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'received'.tr,
                            style: TextStyle(
                                color: AppColor.whiteTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
