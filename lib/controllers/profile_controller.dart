import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/person.dart';

class ProfileController extends GetxController{

  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  getResults(){
    onInit();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if(chosenAge == null || chosenCountry == null || chosenGender == null){
      usersProfileList.bindStream(
          FirebaseFirestore.instance
              .collection("users")
              .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots()
              .map((QuerySnapshot queryDataSnapshot){
            List<Person> profilesList = [];

            for(var eachProfile in queryDataSnapshot.docs){
              profilesList.add(Person.fromJson(eachProfile));
            }
            return profilesList;
          })
      );
    }
    else{
      usersProfileList.bindStream(
          FirebaseFirestore.instance
              .collection("users")
              .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where("gender", isEqualTo: chosenGender.toString().toLowerCase())
              .where("country", isEqualTo: chosenCountry.toString())
              // .where("age", isGreaterThanOrEqualTo: int.parse(chosenAge.toString()))
              .snapshots()
              .map((QuerySnapshot queryDataSnapshot){
            List<Person> profilesList = [];

            for(var eachProfile in queryDataSnapshot.docs){
              profilesList.add(Person.fromJson(eachProfile));
            }
            return profilesList;
          })
      );
    }
  }

  favoriteSentAndFavoriteReceived(String toUserId, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserId)
        .collection("favoriteReceived")
        .doc(currentUserId)
        .get();

    // if already marked, remove it from favorite
    if(document.exists){

      // remove currentUserId from the favoriteReceived list of toUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId)
          .collection("favoriteReceived")
          .doc(currentUserId)
          .delete();

      // remove toUserId from the favoriteSent list of currentUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("favoriteSent")
          .doc(toUserId)
          .delete();

    }
    // mark it favorite
    else{

      // add currentUserId to the favoriteReceived list of toUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId)
          .collection("favoriteReceived")
          .doc(currentUserId)
          .set({});

      // add toUserId to the favoriteSent list of currentUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("favoriteSent")
          .doc(toUserId)
          .set({});

      // sent notification
      sendNotificationToUser(toUserId, "Favorite", senderName);
    }

    update();

  }

  likeSentAndLikeReceived(String toUserId, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserId)
        .collection("likeReceived")
        .doc(currentUserId)
        .get();

    // if already marked, remove it from like
    if(document.exists){

      // remove currentUserId from the likeReceived list of toUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId)
          .collection("likeReceived")
          .doc(currentUserId)
          .delete();

      // remove toUserId from the likeSent list of currentUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("likeSent")
          .doc(toUserId)
          .delete();

    }
    // mark it liked
    else{

      // add currentUserId to the likeReceived list of toUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId)
          .collection("likeReceived")
          .doc(currentUserId)
          .set({});

      // add toUserId to the likeSent list of currentUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("likeSent")
          .doc(toUserId)
          .set({});

      // sent notifications
      sendNotificationToUser(toUserId, "Like", senderName);
    }

    update();

  }

  viewSentAndViewReceived(String toUserId, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserId)
        .collection("viewReceived")
        .doc(currentUserId)
        .get();

    // if already seen,
    if(document.exists){
    }
    // mark it visited
    else{

      // add currentUserId to the likeReceived list of toUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId)
          .collection("viewReceived")
          .doc(currentUserId)
          .set({});

      // add toUserId to the likeSent list of currentUserId
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection("viewSent")
          .doc(toUserId)
          .set({});

      // sent notifications
      sendNotificationToUser(toUserId, "View", senderName);
    }

    update();

  }

  sendNotificationToUser(receiverID, featureType, senderName) async {

    String userDeviceToken = "";

    await FirebaseFirestore.instance
        .collection("users")
        .doc(receiverID)
        .get()
        .then((snapshot) {
          if(snapshot.data()!["userDeviceToken"] != null){
            userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
          }
    });

    notificationFormat(
      userDeviceToken,
      receiverID,
      featureType,
      senderName
    );

  }

  notificationFormat(userDeviceToken, receiverID, featureType, senderName){

    Map<String,String> headerNotification = {
      "Content-Type": "application/json",
      "Authorization": fcmServerToken,
    };

    Map bodyNotification = {
      "body": "You have received a $featureType from $senderName. Click to see",
      "title": "New $featureType",
    };

    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": 1,
      "status": "done",
      "userID": receiverID,
      "senderID": currentUserId,
    };

    Map notificationOfficialFormat = {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": userDeviceToken,
    };

    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(notificationOfficialFormat),
    );

  }

}
