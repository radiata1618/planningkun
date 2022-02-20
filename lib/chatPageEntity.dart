import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'commonEntity/userEntity.dart';

final callDataProvider = ChangeNotifierProvider(
      (ref) => CallDataNotifier(),
);


class CallDataNotifier extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _callData = {};

  get callData => _callData;

  Stream<QuerySnapshot>? _callStream;
  final controller = StreamController<bool>();
  StreamSubscription<QuerySnapshot>? streamSub;
  //
  // Future<void> readCallFromFirebase(WidgetRef ref,String friendUserDocId) async {
  //   final Stream<QuerySnapshot> _callStream = FirebaseFirestore.instance
  //       .collection('calls')
  //       .where('sender', isEqualTo: friendUserDocId)
  //       .where('receiver', isEqualTo: ref
  //       .watch(userDataProvider)
  //       .userData["userDocId"]!)
  //       .where('status', isEqualTo: "yet")
  //       .snapshots();
  //
  //   _callStream.listen
  //
  //     (
  //
  //           (QuerySnapshot snapshot) async {
  //         if (snapshot.size != 0) {
  //           await Navigator.of(context).push(
  //             MaterialPageRoute(builder: (context) {
  //               return confirmCall(
  //                 argumentFriendUserDocId: friendUserDocId,
  //                 argumentChannelId: snapshot.docs[0].id,
  //               );
  //             }),
  //           );
  //         }
  //       });
  }