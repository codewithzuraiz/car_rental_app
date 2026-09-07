import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/chat_controller.dart';
import '../../models/car_model.dart';

class ChatOfferScreen extends StatelessWidget {
  final CarModel car;

  const ChatOfferScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(car.sellerName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const Row(
              children: [
                Icon(Icons.verified, size: 12, color: AppColors.secondary),
                SizedBox(width: 4),
                Text(
                  'Verified Premier Seller • Instant Response',
                  style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_outlined),
            onPressed: () {
              Get.snackbar('Contacting Seller', 'Calling ${car.sellerPhone}...');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Embedded Car Snippet Card
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppColors.surface,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: car.images.isNotEmpty ? car.images.first : '',
                    width: 50,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car.title,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Listed at ${currencyFormatter.format(car.price)}',
                        style: const TextStyle(fontSize: 12, color: AppColors.secondary, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showMakeOfferDialog(context, chatController),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size.zero,
                  ),
                  child: const Text('Counter Offer', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),

          // Active Offer Status Banner
          Obx(() {
            final offer = chatController.activeOffer.value;
            if (offer == null) return const SizedBox.shrink();

            final isAccepted = offer.status == 'Accepted';
            return Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isAccepted ? AppColors.successContainer : AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isAccepted ? AppColors.success : AppColors.outlineVariant),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isAccepted ? Icons.check_circle : Icons.gavel,
                        color: isAccepted ? AppColors.success : AppColors.primaryContainer,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Binding Negotiation: ${offer.status}',
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Offer: ${currencyFormatter.format(offer.offerAmount)} ${offer.counterAmount != null ? "• Counter: ${currencyFormatter.format(offer.counterAmount!)}" : ""}',
                            style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (!isAccepted)
                    ElevatedButton(
                      onPressed: () => chatController.acceptOffer(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        minimumSize: Size.zero,
                      ),
                      child: const Text('Accept', style: TextStyle(fontSize: 12)),
                    ),
                ],
              ),
            );
          }),

          // Chat Messages List
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final msg = chatController.messages[index];
                  final isMe = msg.isFromBuyer;

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isMe ? AppColors.primaryContainer : AppColors.surface,
                        borderRadius: BorderRadius.circular(16).copyWith(
                          bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
                          bottomLeft: !isMe ? const Radius.circular(0) : const Radius.circular(16),
                        ),
                        border: isMe ? null : Border.all(color: AppColors.outlineVariant),
                        boxShadow: const [AppColors.cardShadow],
                      ),
                      child: Column(
                        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          if (msg.isSystemOffer)
                            Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? Colors.white.withValues(alpha: 0.2)
                                    : AppColors.secondaryContainer.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.handshake, size: 14, color: Colors.white),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Binding Offer: ${currencyFormatter.format(msg.offerAmount ?? 0)}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: isMe ? Colors.white : AppColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Text(
                            msg.text,
                            style: TextStyle(
                              fontSize: 14,
                              color: isMe ? Colors.white : AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('h:mm a').format(msg.timestamp),
                            style: TextStyle(
                              fontSize: 10,
                              color: isMe ? Colors.white70 : AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Message Input Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.outlineVariant)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: AppColors.onSurfaceVariant),
                  onPressed: () {
                    Get.snackbar('Attachment', 'Attach inspection records or photos.');
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message or inquiry...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    onSubmitted: (text) {
                      chatController.sendMessage(text);
                      textController.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.secondary),
                  onPressed: () {
                    chatController.sendMessage(textController.text);
                    textController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMakeOfferDialog(BuildContext context, ChatController controller) {
    final offerInput = TextEditingController(text: (car.price * 0.95).toStringAsFixed(0));

    Get.defaultDialog(
      title: 'Make a Binding Offer',
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Plus Jakarta Sans'),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              'Original list price: \$${car.price.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: offerInput,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Your Offer Amount (\$)',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Once accepted by the seller, funds are held securely in AutoElite Escrow.',
              style: TextStyle(fontSize: 11, color: AppColors.outline),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      textConfirm: 'Submit Offer',
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primaryContainer,
      onConfirm: () {
        final amount = double.tryParse(offerInput.text) ?? car.price;
        controller.submitCounterOffer(car, amount);
        Get.back();
      },
    );
  }
}
