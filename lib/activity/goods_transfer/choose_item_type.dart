import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kh_logistics_internal_demo/api/item_type_request.dart';
import 'package:kh_logistics_internal_demo/models/item-type/item_type_respone.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class ChooseItemTypeScreen extends StatefulWidget {
  const ChooseItemTypeScreen({super.key});

  @override
  State<ChooseItemTypeScreen> createState() => _ChooseItemTypeScreene();
}

class _ChooseItemTypeScreene extends State<ChooseItemTypeScreen> {
  List listItemType = [];

  @override
  void initState() {
    loadItemType();
    super.initState();
  }

  void loadItemType() async {
    // listItemType=await ItemType()
    ItemTypeRespone response = await ItemType().getItemType('');
    setState(() {
      listItemType = response.body?.data ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.whiteTextColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
                hintText: 'Item type',
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
              onChanged: (value) async {},
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: listItemType.length,
        itemBuilder: (context, index) {
          final item = listItemType[index];
          return InkWell(
            onTap: () {
              ValueStatics.itemType = item.name;
              ValueStatics.itemTypeId = item.id;
              // widget.destinationType == 1
              //     ? ValueStatics.destinationFromTitle = item.name ?? ''
              //     : ValueStatics.destinationToTitle = item.name ?? '';
              log('id = ${ValueStatics.itemTypeId}, name = ${ValueStatics.itemType}');

              setState(() {});
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
