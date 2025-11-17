// ignore: camel_case_types
class LogInResponse {
  Header? header;
  Body? body;

  LogInResponse({this.header, this.body});

  LogInResponse.fromJson(Map<String, dynamic> json) {
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
    data['serverTimestamp'] = this.serverTimestamp;
    data['result'] = this.result;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Body {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  String? scope;

  Body(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.expiresIn,
      this.scope});

  Body.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['tokenType'] = tokenType;
    data['refreshToken'] = refreshToken;
    data['expiresIn'] = expiresIn;
    data['scope'] = scope;
    return data;
  }
}
