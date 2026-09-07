import 'package:get/get.dart';
import '../models/chat_message_model.dart';
import '../models/offer_model.dart';
import '../models/car_model.dart';
import '../services/dummy_data_seeder.dart';
import '../services/firebase_service.dart';

class ChatController extends GetxController {
  final FirebaseService _service = FirebaseService();

  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final Rx<OfferModel?> activeOffer = Rx<OfferModel?>(null);

  @override
  void onInit() {
    super.onInit();
    messages.assignAll(DummyDataSeeder.initialChatMessages);
    if (DummyDataSeeder.initialOffers.isNotEmpty) {
      activeOffer.value = DummyDataSeeder.initialOffers.first;
    }
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final newMsg = ChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'user_alex_mitchell',
      senderName: 'Alex Mitchell',
      text: text.trim(),
      isFromBuyer: true,
      timestamp: DateTime.now(),
    );

    messages.add(newMsg);
    _service.sendMessage('chat_bmw_m4', newMsg);
  }

  void submitCounterOffer(CarModel car, double offerAmount) {
    final offer = OfferModel(
      id: 'offer_${DateTime.now().millisecondsSinceEpoch}',
      carId: car.id,
      carTitle: car.title,
      listedPrice: car.price,
      offerAmount: offerAmount,
      buyerId: 'user_alex_mitchell',
      buyerName: 'Alex Mitchell',
      sellerId: 'dealer_autoelite',
      status: 'Pending',
      updatedAt: DateTime.now(),
    );

    activeOffer.value = offer;

    final systemMsg = ChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'user_alex_mitchell',
      senderName: 'Alex Mitchell',
      text: 'Submitted an updated binding offer of \$${offerAmount.toStringAsFixed(0)}.',
      isFromBuyer: true,
      timestamp: DateTime.now(),
      isSystemOffer: true,
      offerAmount: offerAmount,
    );

    messages.add(systemMsg);
    _service.createOffer(offer);
  }

  void acceptOffer() {
    if (activeOffer.value != null) {
      final current = activeOffer.value!;
      activeOffer.value = OfferModel(
        id: current.id,
        carId: current.carId,
        carTitle: current.carTitle,
        listedPrice: current.listedPrice,
        offerAmount: current.offerAmount,
        counterAmount: current.counterAmount,
        buyerId: current.buyerId,
        buyerName: current.buyerName,
        sellerId: current.sellerId,
        status: 'Accepted',
        updatedAt: DateTime.now(),
      );

      messages.add(
        ChatMessageModel(
          id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
          senderId: 'user_alex_mitchell',
          senderName: 'System Escrow',
          text: 'Offer Accepted! Proceeding to Escrow Deposit & Title Transfer.',
          isFromBuyer: false,
          timestamp: DateTime.now(),
        ),
      );
    }
  }
}
