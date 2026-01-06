class MoveItemFromVanModel {
  Header? header;
  Body? body;

  MoveItemFromVanModel({this.header, this.body});

  MoveItemFromVanModel.fromJson(Map<String, dynamic> json) {
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
  String? destinationToName;
  String? sysCode;
  int? itemAvailable;
  String? receiverTel;
  int? itemId;
  String? itemCode;

  Data(
      {this.destinationToName,
      this.sysCode,
      this.itemAvailable,
      this.receiverTel,
      this.itemId,
      this.itemCode});

  Data.fromJson(Map<String, dynamic> json) {
    destinationToName = json['destinationToName'];
    sysCode = json['sysCode'];
    itemAvailable = json['itemAvailable'];
    receiverTel = json['receiverTel'];
    itemId = json['itemId'];
    itemCode = json['itemCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['destinationToName'] = destinationToName;
    data['sysCode'] = sysCode;
    data['itemAvailable'] = itemAvailable;
    data['receiverTel'] = receiverTel;
    data['itemId'] = itemId;
    data['itemCode'] = itemCode;
    return data;
  }
}
