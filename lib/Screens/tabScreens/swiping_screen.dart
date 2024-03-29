import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Screens/tabScreens/user_details_screen.dart';
import 'package:dating_app/controllers/profile_controller.dart';
import 'package:dating_app/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SwipingScreen extends StatefulWidget {
  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {

  ProfileController profileController = Get.put(ProfileController());

  String senderName = "";

  startChattingOnWhatsApp(String receiverPhoneNumber) async {

    var androidUrl = "whatsapp://send?phone=$receiverPhoneNumber&text=Hi, I found your profile on Match Hill.";
    var iosUrl = "https://wa.me/$receiverPhoneNumber?text=${Uri.parse('Hi, I found your profile on Match Hill.')}";


    try{

      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }

    }
    on Exception{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: const Text("WhatsApp Not Found"),
              content: const Text("WhatsApp is not installed."),
              actions: [
                TextButton(
                    onPressed: (){},
                    child: const Text("Ok")
                ),
              ],
            );
          }
      );
    }
  }

  applyFilter(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return AlertDialog(
                  title: const Text(
                    "Matching Filter",
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text("I am looking for"),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DropdownButton<String>(
                          hint: const Text("Select Gender"),
                          value: chosenGender,
                          underline: Container(),
                          items: [
                            'Male',
                            'Female'
                          ].map((value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                            );
                          }).toList(),
                          onChanged: (String? value){
                            setState(() {
                              chosenGender = value;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20,),

                      const Text("Who lives in"),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DropdownButton<String>(
                          hint: const Text("Select Country"),
                          value: chosenCountry,
                          underline: Container(),
                          items: [
                            'India',
                            'USA',
                            'France',
                            'Spain',
                            'UK',
                            'China',
                            'Japan',
                            'Others'
                          ].map((value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),
                                )
                            );
                          }).toList(),
                          onChanged: (String? value){
                            setState(() {
                              chosenCountry = value;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20,),

                      const Text("Who's minimum age is"),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DropdownButton<String>(
                          hint: const Text("Select Age"),
                          value: chosenAge,
                          underline: Container(),
                          items: [
                            '18',
                            '25',
                            '30',
                            '35',
                            '40',
                            '45',
                            '50',
                            'above'
                          ].map((value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),
                                )
                            );
                          }).toList(),
                          onChanged: (String? value){
                            setState(() {
                              chosenAge = value;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 20,),

                    ],
                  ),

                  actions: [

                    ElevatedButton(
                        onPressed: (){
                          chosenGender = null;
                          chosenAge = null;
                          chosenCountry = null;
                          Get.back();
                          profileController.getResults();

                          Get.snackbar("Filter cleared","");
                        },
                        child: const Text(
                            "Clear Filter"
                        )
                    ),

                    ElevatedButton(
                        onPressed: (){
                          Get.back();
                          profileController.getResults();

                          Get.snackbar("Filter applied","");
                        },
                        child: const Text(
                          "Apply Filter"
                        )
                    )
                  ],
                );
              }
          );
        }
    );
  }

  readCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .get()
        .then((dataSnapshot){

          setState(() {
            senderName = dataSnapshot.data()!["name"].toString();
          });

        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return PageView.builder(
          itemCount: profileController.allUsersProfileList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){

            final currentProfileInfo = profileController.allUsersProfileList[index];

            return DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        currentProfileInfo.imageProfile.toString(),
                      ),
                      fit: BoxFit.cover
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [

                    const SizedBox(
                      height: 10,
                    ),

                    // Filter Icon Button
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: IconButton(
                            onPressed: (){
                              applyFilter();
                            },
                            icon: const Icon(
                              Icons.filter_list,
                              size: 35,
                            )
                        ),
                      ),
                    ),

                    const Spacer(),

                    // User Data
                    GestureDetector(
                      onTap: (){

                        // update Database
                        profileController.viewSentAndViewReceived(
                          currentProfileInfo.uid.toString(),
                          senderName
                        );

                        // get to the User Details screen
                        Get.to(UserDetailsScreen(userId: currentProfileInfo.uid,));
                      },

                      child: Column(
                        children: [

                          // Name
                          Text(
                            currentProfileInfo.name.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                            ),
                          ),

                          // Age ⦿ City
                          Text(
                            "${currentProfileInfo.age} ⦿ ${currentProfileInfo.city}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          // Profession + Education
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    )
                                  ),
                                  child: Text(
                                    currentProfileInfo.profession.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                              ),

                              const SizedBox(
                                width: 5,
                              ),

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    )
                                ),
                                child: Text(
                                  currentProfileInfo.education.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          const SizedBox(
                            height: 4,
                          ),

                          // Nationality + Religion
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    )
                                ),
                                child: Text(
                                  currentProfileInfo.nationality.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 5,
                              ),

                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white30,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    )
                                ),
                                child: Text(
                                  currentProfileInfo.religion.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                            ],
                          ),

                          const SizedBox(
                            height: 14,
                          ),

                          // Buttons : Favorite - Chat - Like
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              // Favorite Icon Button
                              GestureDetector(
                                onTap: (){
                                  profileController.favoriteSentAndFavoriteReceived(
                                    currentProfileInfo.uid.toString(),
                                    senderName
                                  );
                                },
                                child: Image.asset(
                                  'images/favorite.png',
                                  width: 70,
                                ),
                              ),

                              // Chat Icon Button
                              GestureDetector(
                                onTap: (){
                                  startChattingOnWhatsApp(currentProfileInfo.phoneNo.toString());
                                },
                                child: Image.asset(
                                  'images/chat.png',
                                  width: 120,
                                ),
                              ),

                              // Like Icon Button
                              GestureDetector(
                                onTap: (){
                                  profileController.likeSentAndLikeReceived(
                                    currentProfileInfo.uid.toString(),
                                    senderName
                                  );
                                },
                                child: Image.asset(
                                  'images/like.png',
                                  width: 70,
                                ),
                              ),

                            ],
                          )

                        ],
                      ),
                    )

                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}