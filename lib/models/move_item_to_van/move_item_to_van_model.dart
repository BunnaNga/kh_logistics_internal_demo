class MoveItemToVanModel {
  Header? header;
  Body? body;

  MoveItemToVanModel({this.header, this.body});

  MoveItemToVanModel.fromJson(Map<String, dynamic> json) {
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.body != null) {
      data['body'] = this.body!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serverTimestamp'] = this.serverTimestamp;
    data['result'] = this.result;
    data['statusCode'] = this.statusCode;
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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destinationToName'] = this.destinationToName;
    data['sysCode'] = this.sysCode;
    data['itemAvailable'] = this.itemAvailable;
    data['receiverTel'] = this.receiverTel;
    data['itemId'] = this.itemId;
    data['itemCode'] = this.itemCode;
    return data;
  }
}
