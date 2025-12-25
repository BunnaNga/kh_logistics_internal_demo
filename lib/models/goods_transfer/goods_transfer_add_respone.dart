class GoodsTransferAddRespone {
  Header? header;
  Body? body;

  GoodsTransferAddRespone({this.header, this.body});

  GoodsTransferAddRespone.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header != null) {
      data['header'] = header!.toJson();
    }
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class Header {
  int? serverTimestamp;
  bool? result;
  int? statusCode;

  Header({this.serverTimestamp, this.result, this.statusCode});

  Header.fromJson(Map<String, dynamic> json) {
    serverTimestamp = json['serverTimestamp'];
    result = json['result'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serverTimestamp'] = serverTimestamp;
    data['result'] = result;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Body {
  bool? status;
  String? message;
  List<Data>? data;

  Body({this.status, this.message, this.data});

  Body.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? code;
  String? destFrom;
  String? destTo;
  String? senderTel;
  String? receiverTel;
  String? transferFee;
  String? deliveryFee;
  String? totalFee;
  String? printDate;
  String? printBy;
  String? created;
  String? createdBy;
  String? branchFName;
  String? branchFTel;
  String? branchTName;
  String? branchTTel;
  String? deliveryDestination;
  int? paidBy;
  int? isCod;
  List<PrintItemLayoutList>? printItemLayoutList;

  Data(
      {this.code,
      this.destFrom,
      this.destTo,
      this.senderTel,
      this.receiverTel,
      this.transferFee,
      this.deliveryFee,
      this.totalFee,
      this.printDate,
      this.printBy,
      this.created,
      this.createdBy,
      this.branchFName,
      this.branchFTel,
      this.branchTName,
      this.branchTTel,
      this.deliveryDestination,
      this.paidBy,
      this.isCod,
      this.printItemLayoutList});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    destFrom = json['destFrom'];
    destTo = json['destTo'];
    senderTel = json['senderTel'];
    receiverTel = json['receiverTel'];
    transferFee = json['transferFee'];
    deliveryFee = json['deliveryFee'];
    totalFee = json['totalFee'];
    printDate = json['printDate'];
    printBy = json['printBy'];
    created = json['created'];
    createdBy = json['createdBy'];
    branchFName = json['branchFName'];
    branchFTel = json['branchFTel'];
    branchTName = json['branchTName'];
    branchTTel = json['branchTTel'];
    deliveryDestination = json['deliveryDestination'];
    paidBy = json['paidBy'];
    isCod = json['isCod'];
    if (json['printItemLayoutList'] != null) {
      printItemLayoutList = <PrintItemLayoutList>[];
      json['printItemLayoutList'].forEach((v) {
        printItemLayoutList!.add(PrintItemLayoutList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['destFrom'] = destFrom;
    data['destTo'] = destTo;
    data['senderTel'] = senderTel;
    data['receiverTel'] = receiverTel;
    data['transferFee'] = transferFee;
    data['deliveryFee'] = deliveryFee;
    data['totalFee'] = totalFee;
    data['printDate'] = printDate;
    data['printBy'] = printBy;
    data['created'] = created;
    data['createdBy'] = createdBy;
    data['branchFName'] = branchFName;
    data['branchFTel'] = branchFTel;
    data['branchTName'] = branchTName;
    data['branchTTel'] = branchTTel;
    data['deliveryDestination'] = deliveryDestination;
    data['paidBy'] = paidBy;
    data['isCod'] = isCod;
    if (printItemLayoutList != null) {
      data['printItemLayoutList'] =
          printItemLayoutList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrintItemLayoutList {
  String? itemCode;
  String? itemName;
  String? itemQty;
  String? itemFee;

  PrintItemLayoutList(
      {this.itemCode, this.itemName, this.itemQty, this.itemFee});

  PrintItemLayoutList.fromJson(Map<String, dynamic> json) {
    itemCode = json['itemCode'];
    itemName = json['itemName'];
    itemQty = json['itemQty'];
    itemFee = json['itemFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemCode'] = itemCode;
    data['itemName'] = itemName;
    data['itemQty'] = itemQty;
    data['itemFee'] = itemFee;
    return data;
  }
}
