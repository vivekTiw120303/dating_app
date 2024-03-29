import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Screens/account_settings_screen.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatefulWidget {

  String? userId;

  UserDetailsScreen({super.key, this.userId});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {

  // Personal Info
  String name = '';
  String age = '';
  String gender = '';
  String phoneNo = '';
  String city = '';
  String country = '';
  String profileHeading = '';
  String lookingForInAPartner = '';

  // Appearance
  String height = '';
  String weight = '';
  String bodyType = '';

  // LifeStyle
  String drink = '';
  String smoke = '';
  String martialStatus = '';
  String haveChildren = '';
  String noOfChildren = '';
  String profession = '';
  String employmentStatus = '';
  String income = '';
  String livingSituation = '';
  String willingToRelocate = '';
  String relationshipYouAreLookingFor = '';

  // Cultural
  String nationality = '';
  String education = '';
  String languageSpoken = '';
  String religion = '';

  // Slider Images
  String urlImage1="https://firebasestorage.googleapis.com/v0/b/dating-app-729d4.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=9cd26778-c5ed-4507-8311-c8c9c5c1c707";
  String urlImage2="https://firebasestorage.googleapis.com/v0/b/dating-app-729d4.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=9cd26778-c5ed-4507-8311-c8c9c5c1c707";
  String urlImage3="https://firebasestorage.googleapis.com/v0/b/dating-app-729d4.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=9cd26778-c5ed-4507-8311-c8c9c5c1c707";
  String urlImage4="https://firebasestorage.googleapis.com/v0/b/dating-app-729d4.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=9cd26778-c5ed-4507-8311-c8c9c5c1c707";
  String urlImage5="https://firebasestorage.googleapis.com/v0/b/dating-app-729d4.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=9cd26778-c5ed-4507-8311-c8c9c5c1c707";

  retrieveUserInfo() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .get()
        .then((snapshots){

          if(snapshots.exists){
            if(snapshots.data()!["urlImage1"] != null){
              setState(() {
                urlImage1 = snapshots.data()!["urlImage1"];
                urlImage2 = snapshots.data()!["urlImage2"];
                urlImage3 = snapshots.data()!["urlImage3"];
                urlImage4 = snapshots.data()!["urlImage4"];
                urlImage5 = snapshots.data()!["urlImage5"];
              });
            }
          }

          setState(() {

            // Personal Info
            name = snapshots.data()!["name"];
            age = snapshots.data()!["age"].toString();
            gender = snapshots.data()!["gender"];
            phoneNo = snapshots.data()!["phoneNo"];
            city = snapshots.data()!["city"];
            country = snapshots.data()!["country"];
            profileHeading = snapshots.data()!["profileHeading"];
            lookingForInAPartner = snapshots.data()!["lookingForInAPartner"];

            // Appearance
            height = snapshots.data()!["height"];
            weight = snapshots.data()!["weight"];
            bodyType = snapshots.data()!["bodyType"];

            // LifeStyle
            drink = snapshots.data()!["drink"];
            smoke = snapshots.data()!["smoke"];
            martialStatus = snapshots.data()!["martialStatus"];
            haveChildren = snapshots.data()!["haveChildren"];
            noOfChildren = snapshots.data()!["noOfChildren"];
            profession = snapshots.data()!["profession"];
            employmentStatus = snapshots.data()!["employmentStatus"];
            income = snapshots.data()!["income"];
            livingSituation = snapshots.data()!["livingSituation"];
            willingToRelocate = snapshots.data()!["willingToRelocate"];
            relationshipYouAreLookingFor = snapshots.data()!["relationshipYouAreLookingFor"];

            // Cultural
            nationality = snapshots.data()!["nationality"];
            education = snapshots.data()!["education"];
            languageSpoken = snapshots.data()!["languageSpoken"];
            religion = snapshots.data()!["religion"];


          });

        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: widget.userId == currentUserId ? false : true,

        actions: [

          widget.userId == currentUserId ?
              Row(
                children: [

                  // Edit Button
                  IconButton(
                      onPressed: (){
                        Get.to(const AccountSettingsScreen());
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                      ),
                  ),

                  // Sign Out Button
                  IconButton(
                    onPressed: (){
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 30,
                    ),
                  ),

                ],
              )
              :
              Container()

        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [

              // image slider
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Carousel(
                    indicatorBarColor: Colors.black.withOpacity(0.4),
                    autoScrollDuration: const Duration(seconds: 2),
                    animationPageDuration: const Duration(milliseconds: 500),
                    activateIndicatorColor: Colors.black,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: 30,
                    indicatorHeight: 10,
                    indicatorWidth: 10,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    
                    items: [
                      
                      Image.network(urlImage1, fit: BoxFit.cover,),
                      Image.network(urlImage2, fit: BoxFit.cover,),
                      Image.network(urlImage3, fit: BoxFit.cover,),
                      Image.network(urlImage4, fit: BoxFit.cover,),
                      Image.network(urlImage5, fit: BoxFit.cover,),
                      
                    ],

                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // <-------------- Personal Info ------------------>

              const SizedBox(
                height: 30,
              ),

              // Personal Info Title
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Personal Info",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              // Personal Info Table Data
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [

                    // name
                    TableRow(
                      children: [

                        const Text(
                          "Name : ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ]
                    ),

                    // Spacer
                    const TableRow(
                      children: [
                        Text(""),
                        Text(""),
                      ]
                    ),

                    // age
                    TableRow(
                        children: [

                          const Text(
                            "Age : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            age,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // gender
                    TableRow(
                        children: [

                          const Text(
                            "Gender : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            gender,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // phoneNo
                    TableRow(
                        children: [

                          const Text(
                            "Phone Number : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            phoneNo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // city
                    TableRow(
                        children: [

                          const Text(
                            "City : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            city,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // Country
                    TableRow(
                        children: [

                          const Text(
                            "Country : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            country,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // Profile Heading
                    TableRow(
                        children: [

                          const Text(
                            "Profile Heading : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            profileHeading,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // looking for in a partner
                    TableRow(
                        children: [

                          const Text(
                            "Seeking: ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            lookingForInAPartner,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                  ],
                ),
              ),

              // <-------------- Personal Info ------------------>

              // <--------------- Appearance -------------------->

              const SizedBox(
                height: 30,
              ),

              // Appearance Info Title
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Appearance",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              // Appearance Info Table Data
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [

                    // height
                    TableRow(
                        children: [

                          const Text(
                            "Height : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            height,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // weight
                    TableRow(
                        children: [

                          const Text(
                            "Weight : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            weight,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // Body type
                    TableRow(
                        children: [

                          const Text(
                            "Body Type : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            bodyType,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                  ],
                ),
              ),

              // <--------------- Appearance -------------------->

              // <--------------- LifeStyle --------------------->

              const SizedBox(
                height: 30,
              ),

              // LifeStyle Info Title
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "LifeStyle",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              // LifeStyle Info Table Data
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [

                    // Drink
                    TableRow(
                        children: [

                          const Text(
                            "Drinks : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            drink,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // Smoke
                    TableRow(
                        children: [

                          const Text(
                            "Smokes : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            smoke,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // martialStatus
                    TableRow(
                        children: [

                          const Text(
                            "Martial Status : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            martialStatus,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // has Children
                    TableRow(
                        children: [

                          const Text(
                            "Have Children : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            haveChildren,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // number of Children
                    TableRow(
                        children: [

                          const Text(
                            "Number of Children : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            noOfChildren,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // Profession
                    TableRow(
                        children: [

                          const Text(
                            "Profession : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            profession,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // employment Status
                    TableRow(
                        children: [

                          const Text(
                            "Employment Status : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            employmentStatus,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // income
                    TableRow(
                        children: [

                          const Text(
                            "Income : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            income,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // living Situation
                    TableRow(
                        children: [

                          const Text(
                            "Living Situation : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            livingSituation,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // willing to relocate
                    TableRow(
                        children: [

                          const Text(
                            "Willing to Relocate : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            willingToRelocate,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // relationship you are looking for
                    TableRow(
                        children: [

                          const Text(
                            "Looking for : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            relationshipYouAreLookingFor,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                  ],
                ),
              ),

              // <--------------- LifeStyle --------------------->

              // <--------------- Cultural ---------------------->

              const SizedBox(
                height: 30,
              ),

              // Cultural Info Title
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Background - Cultural Values",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              const Divider(
                color: Colors.white,
                thickness: 2,
              ),

              // Cultural Info Table Data
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(20),
                child: Table(
                  children: [

                    // nationality
                    TableRow(
                        children: [

                          const Text(
                            "Nationality : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            nationality,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // Religion
                    TableRow(
                        children: [

                          const Text(
                            "Religion : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            religion,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    // Spacer
                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // Education
                    TableRow(
                        children: [

                          const Text(
                            "Education : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            education,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                    const TableRow(
                        children: [
                          Text(""),
                          Text(""),
                        ]
                    ),

                    // Languages Known
                    TableRow(
                        children: [

                          const Text(
                            "Languages Known : ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            languageSpoken,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ]
                    ),

                  ],
                ),
              ),

              // <--------------- Cultural ---------------------->

            ],
          ),
        ),
      )
    );
  }
}
