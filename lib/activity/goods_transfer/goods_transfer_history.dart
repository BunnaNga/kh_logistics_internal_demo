import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/back_to_destination_from.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/change_destination.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/change_telephone.dart';
import 'package:kh_logistics_internal_demo/api/goods_transfer_request.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/goods_transfer_history_respone.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class GoodsTransferHistory extends StatefulWidget {
  const GoodsTransferHistory({super.key});

  @override
  State<GoodsTransferHistory> createState() => _GoodsTransferHistoryState();
}

class _GoodsTransferHistoryState extends State<GoodsTransferHistory> {
  TextEditingController historyController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List listGoodsTransferHistory = [];

  List<String> statusListText = [
    'ផ្ញើបញ្ញើ',
    'ដឹកជញ្ជូន',
    'ដល់ទិសដៅ',
    'បានទទួល',
  ];

  @override
  void initState() {
    loadGoodsTransferHistory();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list
      log("Reached the end of the list!");
      // You can add logic here to load more data (infinite scrolling/pagination)
    }
  }

  void loadGoodsTransferHistory() async {
    GoodsTransferHistoryRespone respone =
        await GoodsTransferRequest().getListGoodsTransferHistory('');
    setState(() {
      listGoodsTransferHistory = respone.body?.data ?? [];
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColors,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.whiteTextColor,
            )),
        title: SafeArea(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: historyController,
              cursorColor: AppColor.baseColors,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: AppColor.background_color,
                hintText: "goods_transfer_history".tr,
                suffixIcon: const Icon(Icons.search),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.1, color: AppColor.background_color),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.1, color: AppColor.baseColors),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 0.1, color: AppColor.baseColors),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: listGoodsTransferHistory.length,
        itemBuilder: (context, index) {
          final item = listGoodsTransferHistory[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.background_color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    // offset: Offset(1, 1),
                    offset: Offset.zero,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            statusListText[item.status - 1],
                            style: TextStyle(
                              color: const Color(0XFFdc6b00),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      color: Colors.white,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BackToDestinationFrom(
                                                                id: item.id,
                                                                code: item.code,
                                                                desFromId: item
                                                                    .destinationFromId,
                                                                desFrom: item
                                                                    .destinationFrom,
                                                                desTo: item
                                                                    .destinationTo,
                                                                senderTelephone:
                                                                    item.senderTel,
                                                                receiverTelephone:
                                                                    item.receiverTel,
                                                              )));
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      child: Image.asset(
                                                          'assets/images/ic_back_to_destination_from.png'),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Text(
                                                      'back_to_destination_from',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                height: 20,
                                                thickness: 1,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChangeDestination(
                                                                id: item.id,
                                                                code: item.code,
                                                                desFrom: item
                                                                    .destinationFrom,
                                                                desTo: item
                                                                    .destinationTo,
                                                                senderTel: item
                                                                    .senderTel,
                                                                receiverTel: item
                                                                    .receiverTel,
                                                              )));
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      child: Image.asset(
                                                          'assets/images/ic_change_destination.png'),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Text(
                                                      'change_destination',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                height: 20,
                                                thickness: 1,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChangeTelephone(
                                                                code: item.code,
                                                                senderTelephone:
                                                                    item.senderTel,
                                                                receiverTelephone:
                                                                    item.receiverTel,
                                                              )));
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                      child: Image.asset(
                                                          'assets/images/ic_call.png'),
                                                    ),
                                                    SizedBox(width: 20),
                                                    Text(
                                                      'change_telephone',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                height: 20,
                                                thickness: 1,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                    child: Image.asset(
                                                        'assets/images/printer.png'),
                                                  ),
                                                  SizedBox(width: 20),
                                                  Text(
                                                    'reprint',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                height: 20,
                                                thickness: 1,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "cancel",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.more_horiz_outlined,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "transfer_goods",
                          ),
                          Text('${item.code}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "date",
                          ),
                          Text('${item.date}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "sender_telephone",
                          ),
                          Text('${item.senderTel}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "receiver_telephone",
                          ),
                          Text('${item.receiverTel}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "destination_from",
                          ),
                          Text('${item.destinationFrom}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "destination_to",
                          ),
                          Text('${item.destinationTo}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
