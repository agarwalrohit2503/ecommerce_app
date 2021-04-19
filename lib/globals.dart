import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

UserModal currentUser;
FirebaseAuth firebaseAuth;
FirebaseFirestore firestore;

CollectionReference userCollection;
CollectionReference productCollection;
