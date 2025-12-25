import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_logistics_internal_demo/api/van_request.dart';
import 'package:kh_logistics_internal_demo/models/van/van_respone.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class VanScreen extends StatefulWidget {
  const VanScreen({super.key});

  @override
  State<VanScreen> createState() => _VanScreenState();
}

class _VanScreenState extends State<VanScreen> {
  TextEditingController searchController = TextEditingController();

  List listBranch = [];

  @override
  void initState() {
    loadVan();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void loadVan() async {
    VanRespone respone = await Van().getVan('');
    setState(() {
      listBranch = respone.body?.data ?? [];
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
        // title: Text(widget.destinationTitle),
        actions: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.background_color),
            child: TextField(
              // keyboardType: TextInputType.phone,

              controller: searchController,
              cursorColor: AppColor.baseColors,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.background_color,
                suffixIcon: Icon(Icons.search),
                hintText: 'van'.tr,
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
                VanRespone respone = await Van().getVan('$value');
                setState(() {
                  listBranch = respone.body?.data ?? [];
                });
                // log("${listBranch}");
              },
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: listBranch.length,
        itemBuilder: (context, index) {
          final item = listBranch[index];
          return InkWell(
            onTap: () {
              ValueStatics.vanId = item.id;
              ValueStatics.vanName = item.name ?? '';

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
