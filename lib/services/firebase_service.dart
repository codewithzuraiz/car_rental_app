import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/car_model.dart';
import '../models/booking_model.dart';
import '../models/offer_model.dart';
import '../models/chat_message_model.dart';
import 'dummy_data_seeder.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;

  // Collection references
  CollectionReference get _carsRef => _firestore.collection('cars');
  CollectionReference get _bookingsRef => _firestore.collection('bookings');
  CollectionReference get _offersRef => _firestore.collection('offers');
  CollectionReference get _chatsRef => _firestore.collection('chats');

  // Seed Firestore if empty
  Future<void> seedDatabaseIfEmpty() async {
    try {
      final snapshot = await _carsRef.limit(1).get().timeout(const Duration(seconds: 4));
      if (snapshot.docs.isEmpty) {
        for (var car in DummyDataSeeder.initialCars) {
          await _carsRef.doc(car.id).set(car.toMap());
        }
      }
    } catch (_) {
      // Offline or permission timeout, graceful fallback
    }
  }

  // Fetch all cars
  Future<List<CarModel>> getCars() async {
    try {
      final snapshot = await _carsRef.get().timeout(const Duration(seconds: 4));
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs
            .map((doc) => CarModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList();
      }
    } catch (_) {
      // Fallback to seeder
    }
    return DummyDataSeeder.initialCars;
  }

  // Add new car listing
  Future<bool> addCar(CarModel car) async {
    try {
      await _carsRef.doc(car.id).set(car.toMap()).timeout(const Duration(seconds: 5));
      return true;
    } catch (_) {
      return false;
    }
  }

  // Book test drive
  Future<bool> createBooking(BookingModel booking) async {
    try {
      await _bookingsRef.doc(booking.id).set(booking.toMap()).timeout(const Duration(seconds: 5));
      return true;
    } catch (_) {
      return false;
    }
  }

  // Make an offer
  Future<bool> createOffer(OfferModel offer) async {
    try {
      await _offersRef.doc(offer.id).set(offer.toMap()).timeout(const Duration(seconds: 5));
      return true;
    } catch (_) {
      return false;
    }
  }

  // Send message
  Future<bool> sendMessage(String chatId, ChatMessageModel message) async {
    try {
      await _chatsRef.doc(chatId).collection('messages').doc(message.id).set(message.toMap());
      return true;
    } catch (_) {
      return false;
    }
  }
}
