class GoodsTransferHistoryRespone {
  Header? header;
  Body? body;

  GoodsTransferHistoryRespone({this.header, this.body});

  GoodsTransferHistoryRespone.fromJson(Map<String, dynamic> json) {
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
  Pagination? pagination;

  Header({this.serverTimestamp, this.result, this.statusCode, this.pagination});

  Header.fromJson(Map<String, dynamic> json) {
    serverTimestamp = json['serverTimestamp'];
    result = json['result'];
    statusCode = json['statusCode'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serverTimestamp'] = serverTimestamp;
    data['result'] = result;
    data['statusCode'] = statusCode;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? rowsPerPage;
  int? total;

  Pagination({this.page, this.rowsPerPage, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    rowsPerPage = json['rowsPerPage'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['rowsPerPage'] = rowsPerPage;
    data['total'] = total;
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
  int? id;
  String? code;
  String? date;
  String? senderTel;
  String? receiverTel;
  int? destinationFromId;
  String? destinationFrom;
  String? destinationTo;
  int? status;
  int? isReceive;

  Data(
      {this.id,
      this.code,
      this.date,
      this.senderTel,
      this.receiverTel,
      this.destinationFromId,
      this.destinationFrom,
      this.destinationTo,
      this.status,
      this.isReceive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    date = json['date'];
    senderTel = json['senderTel'];
    receiverTel = json['receiverTel'];
    destinationFromId = json['destinationFromId'];
    destinationFrom = json['destinationFrom'];
    destinationTo = json['destinationTo'];
    status = json['status'];
    isReceive = json['isReceive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['date'] = date;
    data['senderTel'] = senderTel;
    data['receiverTel'] = receiverTel;
    data['destinationFromId'] = destinationFromId;
    data['destinationFrom'] = destinationFrom;
    data['destinationTo'] = destinationTo;
    data['status'] = status;
    data['isReceive'] = isReceive;
    return data;
  }
}
