class LogoutRespone {
  Header? header;
  String? body;

  LogoutRespone({this.header, this.body});

  LogoutRespone.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header != null) {
      data['header'] = header!.toJson();
    }
    data['body'] = body;
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
