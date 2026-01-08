class AgencySendModel {
  Header? header;
  Body? body;

  AgencySendModel({this.header, this.body});

  AgencySendModel.fromJson(Map<String, dynamic> json) {
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
  String? totalCommission;
  String? totalTransaction;
  List<AgencySendListResponseList>? agencySendListResponseList;

  Data(
      {this.totalCommission,
      this.totalTransaction,
      this.agencySendListResponseList});

  Data.fromJson(Map<String, dynamic> json) {
    totalCommission = json['totalCommission'];
    totalTransaction = json['totalTransaction'];
    if (json['agencySendListResponseList'] != null) {
      agencySendListResponseList = <AgencySendListResponseList>[];
      json['agencySendListResponseList'].forEach((v) {
        agencySendListResponseList!.add(AgencySendListResponseList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCommission'] = totalCommission;
    data['totalTransaction'] = totalTransaction;
    if (agencySendListResponseList != null) {
      data['agencySendListResponseList'] =
          agencySendListResponseList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgencySendListResponseList {
  int? id;
  String? code;
  String? date;
  String? destinationTo;
  String? fee;
  String? commission;

  AgencySendListResponseList(
      {this.id,
      this.code,
      this.date,
      this.destinationTo,
      this.fee,
      this.commission});

  AgencySendListResponseList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    date = json['date'];
    destinationTo = json['destinationTo'];
    fee = json['fee'];
    commission = json['commission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['date'] = date;
    data['destinationTo'] = destinationTo;
    data['fee'] = fee;
    data['commission'] = commission;
    return data;
  }
}
