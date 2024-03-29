import 'package:firebase_auth/firebase_auth.dart';

String currentUserId = FirebaseAuth.instance.currentUser!.uid;
String? chosenGender;
String? chosenAge;
String? chosenCountry;
String fcmServerToken = "key=AAAAOLUKccY:APA91bHNoyDGh6v6aO6nG5LBN-YKN6zHKiqLdJ3blLcbMkJEX5x-UKlFdi_whWJtxKynatbYEzu_pjuiZc_vOMZOqO0zFgR1Tp56VnWuiLuCjuEf6hsKVduozbUkEySVD7c6scXrW6yx";