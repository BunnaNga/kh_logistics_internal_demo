import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/api/currency_request.dart';
import 'package:kh_logistics_internal_demo/models/currency/currency_respone.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class ChooseCurrency extends StatefulWidget {
  const ChooseCurrency({super.key});

  @override
  State<ChooseCurrency> createState() => _ChooseCurrencyState();
}

class _ChooseCurrencyState extends State<ChooseCurrency> {
  List listCurrency = [];
  @override
  void initState() {
    // TODO: implement initState
    loadItemType();
    super.initState();
  }

  void loadItemType() async {
    // listItemType=await ItemType()
    CurrencyRespone response = await Currency().getCurrency('');
    setState(() {
      listCurrency = response.body?.data ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.background_color),
            child: TextField(
              // keyboardType: TextInputType.phone,

              // controller: receiverController,
              cursorColor: AppColor.baseColors,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.background_color,
                suffixIcon: Icon(Icons.search),
                hintText: 'currency'.tr,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: AppColor.baseColors),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: AppColor.background_color),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onChanged: (value) async {
                CurrencyRespone respone =
                    await Currency().getCurrency('${value}');
                setState(() {
                  listCurrency = respone.body?.data ?? [];
                });
                // if (widget.destinationType == 1) {
                //   DestinationFromRespone response =
                //       await Destination().destinationFrom('${value}');

                //   setState(() {
                //     destinationList = response.body?.data ?? [];
                //   });
                // } else {
                //   DestinationToRespone response = await Destination()
                //       .destinationTo(
                //           '${value}', ValueStatics.destinationFromId!);

                //   setState(() {
                //     destinationList = response.body?.data ?? [];
                //   });
                // }
                // log('${value}');
              },
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: listCurrency.length,
        itemBuilder: (context, index) {
          final item = listCurrency[index];
          return InkWell(
            onTap: () {
              ValueStatics.currencyId = item.id;
              ValueStatics.currencySymbol = item.symbol;
              setState(() {
                log('id: ${ValueStatics.currencyId} symbol: ${ValueStatics.currencySymbol}');
              });
              Navigator.pop(context, 1);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Text(
                    item.name ?? '',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // adjust to your model

                Divider()
              ],
            ),
          );
        },
      ),
    );
  }
}
