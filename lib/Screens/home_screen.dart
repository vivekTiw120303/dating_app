import 'package:dating_app/Screens/tabScreens/favorite_sent_favorite_received_screen.dart';
import 'package:dating_app/Screens/tabScreens/like_sent_like_received_screen.dart';
import 'package:dating_app/Screens/tabScreens/swiping_screen.dart';
import 'package:dating_app/Screens/tabScreens/user_details_screen.dart';
import 'package:dating_app/Screens/tabScreens/view_sent_view_received_screen.dart';
import 'package:dating_app/pushNotificationSystem/push_notification_system.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int screenIndex = 0;

  List tabScreenList = [

    const SwipingScreen(),
    const ViewSentViewReceivedScreen(),
    const FavoriteSentFavoriteReceivedScreen(),
    const LikeSentLikeReceivedScreen(),
    UserDetailsScreen(userId: FirebaseAuth.instance.currentUser!.uid,),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.generateDeviceRegistrationToken();
    pushNotificationSystem.whenNotificationArrived(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber){

          setState(() {
            screenIndex = indexNumber;
          });

        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,

        items: const [

          // Swiping Screen
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "",
          ),

          // View Sent View Received Screen
          BottomNavigationBarItem(
            icon: Icon(
              Icons.remove_red_eye,
              size: 30,
            ),
            label: "",
          ),

          // Favorite Sent Favorite Received Screen
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
            label: "",
          ),

          // Like Sent Like Received Screen
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              size: 30,
            ),
            label: "",
          ),

          // User Details Screen
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: "",
          ),

        ],
      ),

      body: tabScreenList[screenIndex],
    );
  }
}
