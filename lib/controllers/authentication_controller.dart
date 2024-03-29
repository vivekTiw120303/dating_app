import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Screens/home_screen.dart';
import 'package:dating_app/authenticationClass/login_screen.dart';
import 'package:dating_app/models/person.dart' as person;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController{

  static AuthenticationController authController = Get.find();
  late Rx<User?> firebaseCurrentUser;

  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  // Pick image from gallery
  pickImageFileFromGallery() async{
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(imageFile!=null){
      Get.snackbar("Profile Image", "Image picked successfully");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  // Pick image from camera
  captureImageFromCamera() async{
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(imageFile!=null){
      Get.snackbar("Profile Image", "Image captured successfully");
    }

    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  Future<String> uploadImageToStorage(File imageFile) async{

    Reference referenceStorage = FirebaseStorage.instance.ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask task = referenceStorage.putFile(imageFile);
    TaskSnapshot snapshot = await task;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Create user using email and password
  createUser(
      // Personal Info
      File imageFile, String email, String password,
      String name, String age, String gender, String phoneNo, String city,
      String country, String profileHeading, String lookingForInAPartner,

      // Appearance
      String height, String weight, String bodyType,

      // LifeStyle
      String drink, String smoke, String martialStatus, String haveChildren,
      String noOfChildren, String profession, String employmentStatus, String income,
      String livingSituation, String willingToRelocate, String relationshipYouAreLookingFor,

      // Cultural
      String nationality, String education,
      String languageSpoken, String religion,
      ) async {
    try{

      // Step 1 : Create User using his email and password
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      // Step 2 : Upload his profile picture onto storage
      String urlOfDownloadedImage = await uploadImageToStorage(imageFile);

      // Step 3 : Save the user tp the firebase database
      person.Person personInstance = person.Person(
        uid: FirebaseAuth.instance.currentUser!.uid,
        imageProfile: urlOfDownloadedImage,
        email: email,
        password: password,
        name: name,
        age: int.parse(age),
        gender: gender.toLowerCase(),
        phoneNo: phoneNo,
        city: city,
        country: country,
        profileHeading: profileHeading,
        lookingForInAPartner: lookingForInAPartner,
        publishedTime: DateTime.now().millisecondsSinceEpoch,

        height: height,
        weight: weight,
        bodyType: bodyType,

        drink: drink,
        smoke: smoke,
        martialStatus: martialStatus,
        haveChildren: haveChildren,
        noOfChildren: noOfChildren,
        profession: profession,
        employmentStatus: employmentStatus,
        income: income,
        livingSituation: livingSituation,
        willingToRelocate: willingToRelocate,
        relationshipYouAreLookingFor: relationshipYouAreLookingFor,

        nationality: nationality,
        education: education,
        languageSpoken: languageSpoken,
        religion: religion,
      );

      await FirebaseFirestore.instance.collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personInstance.toJson());

      Get.snackbar("Account Created", "Account created successfully");
      Get.to(() => const HomeScreen());
    }
    catch(error){
      Get.snackbar("Account Not Created", "Error : $error");
    }
  }

  // Login the user if already exist
  loginUser(String email, String password) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      Get.snackbar("Login Successful", "Logged in successfully");
      Get.to(() => const HomeScreen());
    }
    catch(error){
      Get.snackbar("Login Failed", "Error : $error");
    }
  }

  // check if the user is already login or not
  checkIfUserLoggedIn(User? currentUser){
    if(currentUser == null){
      Get.to(() => const LoginScreen());
    }
    else{
      Get.to(() => const HomeScreen());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseCurrentUser, checkIfUserLoggedIn);
  }
}