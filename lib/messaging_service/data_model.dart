import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// ...

// Initialize Firebase in your app
void initializeFirebase() async {
  await Firebase.initializeApp();
}

// Save payment data to Firebase database
void savePaymentData(bool success, String orderId, double amount) {
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  // Create a new child node under 'payments' and get its reference
  DatabaseReference paymentRef = databaseReference.child('payments').push();

  // Set the payment data
  paymentRef.set({
    'success': success,
    'orderId': orderId,
    'amount': amount,
    'timestamp': ServerValue.timestamp,
  }).then((_) {
    print('Payment data saved successfully');
  }).catchError((error) {
    print('Failed to save payment data: $error');
  });
}

// Usage example
void handlePaymentResponse(bool success, String orderId, double amount) {
  // Handle the payment response from Razorpay

  // Save the payment data to Firebase database
  savePaymentData(success, orderId, amount);
}
