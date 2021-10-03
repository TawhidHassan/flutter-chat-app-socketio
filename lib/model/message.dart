class Message{
  String message;
  String sendByMe;



  Message({
    required this.message,
    required this.sendByMe,
  });



  @override
  String toString() {
    return 'Message{message: $message, sendByMe: $sendByMe}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          sendByMe == other.sendByMe);

  @override
  int get hashCode => message.hashCode ^ sendByMe.hashCode;

  factory Message.fromMap(Map<String, dynamic> map) {
    return new Message(
      message: map['message'] as String,
      sendByMe: map['sendByMe'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'message': this.message,
      'sendByMe': this.sendByMe,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}