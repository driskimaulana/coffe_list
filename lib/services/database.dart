import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja_brew/models/brew.dart';
import 'package:ninja_brew/models/user.dart';

class DatabaseService {
  // declaring uid variable to link the firebase document with particular user
  final String uid;

  DatabaseService({required this.uid});

  // collection refference
  final CollectionReference brewCollections =
      FirebaseFirestore.instance.collection('brews');

  // method for storing data to firebase
  Future UpdateUserData(String sugars, String name, int strength) async {
    return await brewCollections.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strenght': strength,
    });
  }

  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc['name'] ?? '',
          sugars: doc['sugars'] ?? '0',
          strength: doc['strenght'] ?? 0);
    }).toList();
  }

  // method convert doc snapshot into docData object
  DocData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return DocData(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strenght']);
  }

  Stream<List<Brew>> get brews {
    return brewCollections.snapshots().map(_brewListFromSnapShot);
  }

  // get user stream doc
  Stream<DocData> get userData {
    return brewCollections.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
