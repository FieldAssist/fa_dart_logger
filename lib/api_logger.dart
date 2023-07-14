import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ApiLogger {
  final CollectionReference _logsCollection =
      FirebaseFirestore.instance.collection('api_logs');

  Future<void> logEvent(String endpoint, String method, String response) async {
    await Firebase.initializeApp();

    final logData = {
      'timestamp': DateTime.now(),
      'endpoint': endpoint,
      'method': method,
      'response': response,
    };

    await _logsCollection.add(logData);
  }
}
