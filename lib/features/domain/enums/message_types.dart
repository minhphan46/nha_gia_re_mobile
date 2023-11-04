enum MessageTypes {
  text,
  media,
  location,
  post;

  static MessageTypes parse(String value) {
    for (MessageTypes type in MessageTypes.values) {
      if (type.toString() == value) return type;
    }
    throw Exception("Can't parse MessageTypes! Your input value is \"$value\"");
  }

  @override
  String toString() {
    switch (this) {
      case MessageTypes.text:
        return "text";
      case MessageTypes.media:
        return "media";
      case MessageTypes.location:
        return "location";
      case MessageTypes.post:
        return "post";
    }
  }
}
