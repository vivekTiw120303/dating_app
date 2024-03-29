import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Screens/tabScreens/user_details_screen.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotificationSystem{

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // notification arrived / received
  Future whenNotificationArrived(BuildContext context) async {

    // 1. Terminated
    // When app is closed and opened directly using notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage) {

      if(remoteMessage != null){
        openAppAndShowNotificationData(
          remoteMessage.data["userID"],
          remoteMessage.data["senderID"],
          context
        );
      }

    });

    // 1. Foreground
    // When app is open and notification arrives
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage != null){
        openAppAndShowNotificationData(
            remoteMessage.data["userID"],
            remoteMessage.data["senderID"],
            context
        );
      }
    });

    // 3. Background
    // When app is background and opened directly using notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage != null){
        openAppAndShowNotificationData(
            remoteMessage.data["userID"],
            remoteMessage.data["senderID"],
            context
        );
      }
    });
  }

  openAppAndShowNotificationData(receiverID, senderID, context) async{

    await FirebaseFirestore.instance
        .collection("users")
        .doc(senderID)
        .get()
        .then((snapshot) {

          String profileImage = snapshot.data()!["imageProfile"].toString();
          String name = snapshot.data()!["name"].toString();
          String age = snapshot.data()!["age"].toString();
          String city = snapshot.data()!["city"].toString();
          String country = snapshot.data()!["country"].toString();
          String profession = snapshot.data()!["profession"].toString();

          showDialog(
            context: context,
            builder: (context){
              return notificationDialogBox(
                senderID,
                profileImage,
                name,
                age,
                city,
                country,
                profession,
                context
              );
            }
          );

    });

  }

  notificationDialogBox(senderID, profileImage, name, age, city, country, profession, context){
    return Dialog(
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: SizedBox(
            height: 300,
            child: Card(
              color: Colors.blue.shade200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(profileImage),
                    fit: BoxFit.cover,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        name + " ⦿ " + age.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Row(
                        children: [

                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.white,
                          ),

                          const SizedBox(
                            width: 2,
                          ),

                          Expanded(
                            child: Text(
                              age + ", " + country,
                              maxLines: 4,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          )

                        ],
                      ),

                      const Spacer(),

                      // Buttons : View Profile , Close
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          // View Profile Button
                          Center(
                            child: ElevatedButton(
                              onPressed: (){
                                Get.back();
                                Get.to(UserDetailsScreen(userId: senderID,));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green
                              ),
                              child: const Text(
                                "View Profile",
                              ),
                            ),
                          ),

                          // Close Notification
                          Center(
                            child: ElevatedButton(
                              onPressed: (){
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green
                              ),
                              child: const Text(
                                "Close",
                              ),
                            ),
                          )

                        ],
                      )

                    ],
                  ),

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future generateDeviceRegistrationToken() async {

    String? deviceToken = await messaging.getToken();
    
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .update({
          "userDeviceToken": deviceToken,
        });

  }

}