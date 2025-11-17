import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kh_logistics_internal_demo/api/destination.dart';
import 'package:kh_logistics_internal_demo/models/destination/destination_from.dart';
import 'package:kh_logistics_internal_demo/models/destination/destination_to.dart';
import 'package:kh_logistics_internal_demo/util/app_color.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';

class DestinationScreen extends StatefulWidget {
  final int destinationType; // 1:is destination from  2:is destination to
  final String destinationTitle;

  const DestinationScreen({
    super.key,
    required this.destinationTitle,
    required this.destinationType,
  });

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  List destinationList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDestinations();
  }

  void loadDestinations() async {
    if (widget.destinationType == 1) {
      DestinationFromRespone response = await Destination().destinationFrom('');

      setState(() {
        destinationList = response.body?.data ?? [];
      });
    } else {
      DestinationToRespone response = await Destination()
          .destinationTo('', ValueStatics.destinationFromId!);

      setState(() {
        destinationList = response.body?.data ?? [];
      });
    }
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

              // controller: receiverController,
              cursorColor: AppColor.baseColors,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.background_color,
                suffixIcon: Icon(Icons.search),
                hintText: widget.destinationTitle,
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
                if (widget.destinationType == 1) {
                  DestinationFromRespone response =
                      await Destination().destinationFrom('${value}');

                  setState(() {
                    destinationList = response.body?.data ?? [];
                  });
                } else {
                  DestinationToRespone response = await Destination()
                      .destinationTo(
                          '${value}', ValueStatics.destinationFromId!);

                  setState(() {
                    destinationList = response.body?.data ?? [];
                  });
                }
                log('${value}');
              },
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: destinationList.length,
        itemBuilder: (context, index) {
          final item = destinationList[index];
          return InkWell(
            onTap: () {
              ValueStatics.destinationFromId = item.id;
              widget.destinationType == 1
                  ? ValueStatics.destinationFromTitle = item.name ?? ''
                  : ValueStatics.destinationToTitle = item.name ?? '';
              log('id = ${ValueStatics.destinationFromId}');
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
