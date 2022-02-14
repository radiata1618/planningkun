import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../chat.dart';
import '../commonEntity.dart';
import '../commonUI.dart';

class Talk extends ConsumerWidget {
  Talk({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      appBar: whiteAppbar(text: 'Talk'),
      body: buildTalkList(context,ref,ref.watch(userDataProvider).userData["userDocId"]!),
    );
  }

  Future<void> moveToChat(
      String userDocId, String friendUserDocId, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(argumentFriendUserDocId:friendUserDocId),
      ),
    );
  }

  Widget buildTalkList(BuildContext context,WidgetRef ref,String userDocId) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenAdjustSizeH = MediaQuery.of(context).size.height * 0.0011;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('friends')
          .where('userDocId', isEqualTo: userDocId)
          .orderBy('lastTime', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data()! as Map<String, dynamic>;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0*screenAdjustSizeH),
              child: Container(
                height: 70,
                child: GestureDetector(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15*screenAdjustSizeH),
                          child: CircleAvatar(radius: 35*screenAdjustSizeH),
                        ),
                        Column(children: [
                          Container(
                            height: 20,
                            width:screenWidth-15.0*screenAdjustSizeH*2-35*screenAdjustSizeH*2-60*screenAdjustSizeH,
                            child: Text(
                              data['friendUserName'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            width:screenWidth-15.0*screenAdjustSizeH*2-35*screenAdjustSizeH*2-60*screenAdjustSizeH,
                            child: Text(
                              data['lastMessageContent'],
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ]),
                        Container(
                            width: 60*screenAdjustSizeH,
                            child: Column(children: [
                              Container(
                                height: 16,
                                child: Text(
                                  "10/1",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ]))
                      ]),
                  onTap: () {
                    moveToChat(userDocId, data['friendUserDocId'], context);
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
