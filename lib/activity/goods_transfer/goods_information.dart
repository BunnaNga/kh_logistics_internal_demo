import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/choose_currency.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/choose_item_type.dart';
import 'package:kh_logistics_internal_demo/activity/goods_transfer/receipt_print_screen.dart';
import 'package:kh_logistics_internal_demo/api/goods_transfer_request.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/goods_transfer_add_respone.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class GoodsInformation extends StatefulWidget {
  const GoodsInformation({super.key});

  @override
  State<GoodsInformation> createState() => _GoodsInformationState();
}

class _GoodsInformationState extends State<GoodsInformation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController unitFeeController = TextEditingController();
  TextEditingController totalFeeController = TextEditingController();
  int paymentBy = 1; // 1 sender, 2 receiver
  bool isCod = false;
  int? fromId;
  int? toId;

  @override
  void initState() {
    log('des to: ${ValueStatics.destinationToId}');
    // log('Currency Id: ${ValueStatics.currencyId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.baseColors,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.whiteTextColor,
            )),
        title: Text(
          "goods_information".tr,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.whiteTextColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text(
                    'item_type'.tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
                  MaterialPageRoute(
                      builder: (context) => ChooseItemTypeScreen()),
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
                      Text(ValueStatics.itemType.isNotEmpty
                          ? ValueStatics.itemType
                          : 'please_select'.tr),
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
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('item_name'.tr),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: TextField(
                  controller: nameController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: 'enter_item_name'.tr,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.baseColors),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.baseColors),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('item_value'.tr),
                  SizedBox(width: 5),
                  Text(
                    '*',
                    style: TextStyle(color: AppColor.baseColors),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 110,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: valueController,
                      cursorColor: AppColor.baseColors,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.background_color,
                        hintText: '0.00'.tr,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColor.baseColors),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: AppColor.baseColors),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseCurrency()));
                      if (result != null) {
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(width: 2, color: AppColor.baseColors),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ValueStatics.currencySymbol.isEmpty
                                    ? '\$'
                                    : ValueStatics.currencySymbol,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.baseColors,
                                ),
                              ),
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
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Text('quantity'.tr),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: qtyController,
                          cursorColor: AppColor.baseColors,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.background_color,
                            hintText: '0',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColor.baseColors),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColor.baseColors),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onChanged: (value) {
                            calulatePrice();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Text('unit_fee'.tr),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 2 - 25,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: unitFeeController,
                          cursorColor: AppColor.baseColors,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.background_color,
                            hintText: '0',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColor.baseColors),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColor.baseColors),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onChanged: (value) {
                            calulatePrice();
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Text('total_fee'.tr),
                  SizedBox(width: 5),
                  Text(
                    '*',
                    style: TextStyle(color: AppColor.baseColors),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: TextField(
                  controller: totalFeeController,
                  cursorColor: AppColor.baseColors,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.background_color,
                    hintText: '0',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.baseColors),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: AppColor.baseColors),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    showPymentType(context);
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.baseColors,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'paid'.tr,
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

  Future<void> showPymentType(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: AppColor.background_color,
              title: Center(child: Text('paid'.tr)),
              content: SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width * 0.99,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('total_fee'.tr),
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: TextField(
                          controller: totalFeeController,
                          cursorColor: AppColor.baseColors,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.background_color,
                            hintText: '0',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColor.baseColors),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColor.baseColors),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Payment by
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'payment_by'.tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        ListTile(
                          title: const Text("Sender"),
                          leading: Radio(
                            value: 1,
                            groupValue: paymentBy,
                            activeColor: AppColor.baseColors,
                            onChanged: (value) {
                              setStateDialog(() => paymentBy = value!);
                              log('payment by => $paymentBy');
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text("Receiver"),
                          leading: Radio(
                            value: 2,
                            groupValue: paymentBy,
                            activeColor: AppColor.baseColors,
                            onChanged: (value) {
                              setStateDialog(() => paymentBy = value!);
                              log('payment by => $paymentBy');
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isCod,
                          activeColor: AppColor.baseColors,
                          onChanged: (value) {
                            setStateDialog(() {
                              isCod = value!;
                            });
                            log('is cod => $isCod');
                          },
                        ),
                        Text('Is Cod'),
                      ],
                    ),

                    SizedBox(height: 30),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          // log("destinationFromId: ${ValueStatics.destinationFromId + 888823}\n"
                          //     "destinationToId: ${ValueStatics.destinationToId}\n"
                          //     "senderName: ${ValueStatics.senderName}\n"
                          //     "senderTelephone: ${ValueStatics.senderTelephone}\n"
                          //     "receiverName: ${ValueStatics.receiverName}\n"
                          //     "receiverTelephone: ${ValueStatics.receiverTelephone}\n"
                          //     "customerId: ${ValueStatics.customerId}\n"
                          //     "deliveryDestinationId: ${ValueStatics.deliveryDestinationId}\n"
                          //     "transferFee: 0\n"
                          //     "deliveryFee: 0\n"
                          //     "total: ${int.parse(totalFeeController.text)}\n"
                          //     "isCod: ${isCod ? 1 : 0}\n"
                          //     "paymentBy: $paymentBy\n"
                          //     "itemTypeId: ${ValueStatics.itemTypeId}\n"
                          //     "itemName: ${nameController.text}\n"
                          //     "quantity: ${int.parse(qtyController.text)}\n"
                          //     "unitFee: ${int.parse(unitFeeController.text)}\n"
                          //     "uomId: 0\n"
                          //     "totalFee: ${int.parse(totalFeeController.text)}\n"
                          //     "itemValue: ${int.parse(valueController.text)}\n"
                          //     "itemValueCurrency: ${ValueStatics.currencyId}\n"
                          //     "weight: 0");

                          GoodsTransferAddRespone respone =
                              await GoodsTransferRequest().goodsTransferAdd(
                            destinationFromId: 2,
                            destinationToId: 3,
                            senderName: ValueStatics.senderName,
                            senderTelephone: ValueStatics.senderTelephone,
                            receiverName: ValueStatics.receiverName,
                            receiverTelephone: ValueStatics.receiverTelephone,
                            customerId: ValueStatics.customerId,
                            deliveryDestinationId:
                                ValueStatics.deliveryDestinationId,
                            transferFee: 0,
                            deliveryFee: 0,
                            total: int.parse(totalFeeController.text),
                            isCod: isCod ? 1 : 0,
                            paymentBy: paymentBy,
                            itemTypeId: ValueStatics.itemTypeId!,
                            itemName: nameController.text,
                            quantity: int.parse(qtyController.text),
                            unitFee: int.parse(unitFeeController.text),
                            uomId: 0,
                            totalFee: int.parse(totalFeeController.text),
                            itemValue: int.parse(valueController.text),
                            itemValueCurrency: ValueStatics.currencyId,
                            weight: 0,
                          );
                          if (respone.body?.status == true) {
                            // ReceiptPrintScreen()
                            //     .itemAdd
                            //     .add(respone.body!.data!.first);
                            log('Goods Transfer Add Response: ${respone.body?.message}');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReceiptPrintScreen(
                                        data: respone.body!.data!.first,
                                      )),
                            );
                          }
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.baseColors,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'paid'.tr,
                              style: TextStyle(
                                color: AppColor.whiteTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void calulatePrice() {
    if (qtyController.text.isNotEmpty && unitFeeController.text.isNotEmpty) {
      int amount =
          int.parse(qtyController.text) * int.parse(unitFeeController.text);
      totalFeeController.text = amount.toString();
    }
  }
}
