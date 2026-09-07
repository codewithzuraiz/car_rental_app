class ChatMessageModel {
  final String id;
  final String senderId;
  final String senderName;
  final String text;
  final bool isFromBuyer;
  final DateTime timestamp;
  final bool isSystemOffer;
  final double? offerAmount;

  ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.isFromBuyer,
    required this.timestamp,
    this.isSystemOffer = false,
    this.offerAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'isFromBuyer': isFromBuyer,
      'timestamp': timestamp.toIso8601String(),
      'isSystemOffer': isSystemOffer,
      'offerAmount': offerAmount,
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map, String docId) {
    return ChatMessageModel(
      id: docId,
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      text: map['text'] ?? '',
      isFromBuyer: map['isFromBuyer'] ?? true,
      timestamp: map['timestamp'] != null
          ? DateTime.tryParse(map['timestamp']) ?? DateTime.now()
          : DateTime.now(),
      isSystemOffer: map['isSystemOffer'] ?? false,
      offerAmount: map['offerAmount'] != null ? (map['offerAmount']).toDouble() : null,
    );
  }
}
