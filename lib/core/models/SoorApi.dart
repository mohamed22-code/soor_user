class SoorApi {
  SoorApi({this.info, this.variable, this.auth, this.item});

  SoorApi.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['variable'] != null) {
      variable = [];
      json['variable'].forEach((v) {
        variable?.add(Variable.fromJson(v));
      });
    }
    auth = json['auth'] != null ? Auth.fromJson(json['auth']) : null;
    if (json['item'] != null) {
      item = [];
      json['item'].forEach((v) {
        item?.add(Item.fromJson(v));
      });
    }
  }

  Info? info;
  List<Variable>? variable;
  Auth? auth;
  List<Item>? item;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (variable != null) {
      map['variable'] = variable?.map((v) => v.toJson()).toList();
    }
    if (auth != null) {
      map['auth'] = auth?.toJson();
    }
    if (item != null) {
      map['item'] = item?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Item {
  Item({this.name, this.item});

  Item.fromJson(dynamic json) {
    name = json['name'];
    if (json['item'] != null) {
      item = [];
      json['item'].forEach((v) {
        item?.add(Item.fromJson(v));
      });
    }
  }

  String? name;
  List<Item>? item;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (item != null) {
      map['item'] = item?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class LeafItem {
  LeafItem({this.name, this.request});

  LeafItem.fromJson(dynamic json) {
    name = json['name'];
    request = json['request'] != null
        ? Request.fromJson(json['request'])
        : null;
  }

  String? name;
  Request? request;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (request != null) {
      map['request'] = request?.toJson();
    }
    return map;
  }
}

class Request {
  Request({this.method, this.header, this.body, this.url});

  Request.fromJson(dynamic json) {
    method = json['method'];
    if (json['header'] != null) {
      header = [];
      json['header'].forEach((v) {
        header?.add(Header.fromJson(v));
      });
    }
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
    url = json['url'] != null ? Url.fromJson(json['url']) : null;
  }

  String? method;
  List<Header>? header;
  Body? body;
  Url? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['method'] = method;
    if (header != null) {
      map['header'] = header?.map((v) => v.toJson()).toList();
    }
    if (body != null) {
      map['body'] = body?.toJson();
    }
    if (url != null) {
      map['url'] = url?.toJson();
    }
    return map;
  }
}

class Url {
  Url({this.raw, this.host, this.path});

  Url.fromJson(dynamic json) {
    raw = json['raw'];
    host = json['host'] != null ? json['host'].cast<String>() : [];
    path = json['path'] != null ? json['path'].cast<String>() : [];
  }

  String? raw;
  List<String>? host;
  List<String>? path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = raw;
    map['host'] = host;
    map['path'] = path;
    return map;
  }
}

class Body {
  Body({this.mode, this.raw});

  Body.fromJson(dynamic json) {
    mode = json['mode'];
    raw = json['raw'];
  }

  String? mode;
  String? raw;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mode'] = mode;
    map['raw'] = raw;
    return map;
  }
}

class Header {
  Header({this.key, this.value});

  Header.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'];
  }

  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['value'] = value;
    return map;
  }
}

class Auth {
  Auth({this.type, this.bearer});

  Auth.fromJson(dynamic json) {
    type = json['type'];
    if (json['bearer'] != null) {
      bearer = [];
      json['bearer'].forEach((v) {
        bearer?.add(Bearer.fromJson(v));
      });
    }
  }

  String? type;
  List<Bearer>? bearer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    if (bearer != null) {
      map['bearer'] = bearer?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Bearer {
  Bearer({this.key, this.value, this.type});

  Bearer.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'];
    type = json['type'];
  }

  String? key;
  String? value;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['value'] = value;
    map['type'] = type;
    return map;
  }
}

class Variable {
  Variable({this.key, this.value});

  Variable.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'];
  }

  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['value'] = value;
    return map;
  }
}

class Info {
  Info({this.name, this.description, this.schema});

  Info.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    schema = json['schema'];
  }

  String? name;
  String? description;
  String? schema;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['schema'] = schema;
    return map;
  }
}
