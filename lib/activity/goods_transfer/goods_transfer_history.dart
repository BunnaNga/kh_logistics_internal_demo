import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';

class GoodsTransferHistory extends StatefulWidget {
  const GoodsTransferHistory({super.key});

  @override
  State<GoodsTransferHistory> createState() => _GoodsTransferHistoryState();
}

class _GoodsTransferHistoryState extends State<GoodsTransferHistory> {
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
    );
  }
}
