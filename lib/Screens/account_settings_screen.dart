import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Screens/home_screen.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/custom_text_field_widget.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {

  // personal info
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController profileHeadingController = TextEditingController();
  TextEditingController lookingForInAPartnerController = TextEditingController();

  // appearance
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bodyTypeController = TextEditingController();

  // Life Style
  TextEditingController drinkController = TextEditingController();
  TextEditingController smokeController = TextEditingController();
  TextEditingController isMarriedController = TextEditingController();
  TextEditingController hasChildrenController = TextEditingController();
  TextEditingController numberOfChildrenController = TextEditingController();
  TextEditingController profesionController = TextEditingController();
  TextEditingController employmentStatusController = TextEditingController();
  TextEditingController incomeController = TextEditingController();
  TextEditingController livingSituationController = TextEditingController();
  TextEditingController willingToRelocateController = TextEditingController();
  TextEditingController relationshipYouAreLookingForController = TextEditingController();

  // Cultural
  TextEditingController nationalityController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController languageSpokenController = TextEditingController();

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

  // uploading => check for uploading the data
  // next to check if we are
  bool uploading = false, next = false;
  // All of the images are stored in this
  final List<File> _image = [];
  // the downloadable urls of the uploaded images
  List<String> urlsList = [];
  // keep count of number of uploaded images
  double val = 0;

  chooseImage() async {

    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    
    setState(() {
      _image.add(File(pickedFile!.path));
    });

  }

  uploadImage() async{

    int i = 1;

    for(var img in _image){
      setState(() {
        val = i / _image.length;
      });

      var refImage = FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");

      await refImage.putFile(img).whenComplete(() async {
        await refImage.getDownloadURL().then((urlImage) {
          urlsList.add(urlImage);

          i++;
        });
      });

    }

  }

  retrieveUserInfo() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .get()
        .then((snapshots) {
          if(snapshots.exists){
            setState(() {
              // Personal Info
              name = snapshots.data()!["name"];
              nameController.text = name;
              age = snapshots.data()!["age"].toString();
              ageController.text = age;
              gender = snapshots.data()!["gender"];
              genderController.text = gender;
              phoneNo = snapshots.data()!["phoneNo"];
              phoneNoController.text = phoneNo;
              city = snapshots.data()!["city"];
              cityController.text = city;
              country = snapshots.data()!["country"];
              countryController.text = country;
              profileHeading = snapshots.data()!["profileHeading"];
              profileHeadingController.text = profileHeading;
              lookingForInAPartner = snapshots.data()!["lookingForInAPartner"];
              lookingForInAPartnerController.text = lookingForInAPartner;

              // Appearance
              height = snapshots.data()!["height"];
              heightController.text = height;
              weight = snapshots.data()!["weight"];
              weightController.text = weight;
              bodyType = snapshots.data()!["bodyType"];
              bodyTypeController.text = bodyType;

              // LifeStyle
              drink = snapshots.data()!["drink"];
              drinkController.text = drink;
              smoke = snapshots.data()!["smoke"];
              smokeController.text = smoke;
              martialStatus = snapshots.data()!["martialStatus"];
              isMarriedController.text = martialStatus;
              haveChildren = snapshots.data()!["haveChildren"];
              hasChildrenController.text = haveChildren;
              noOfChildren = snapshots.data()!["noOfChildren"];
              numberOfChildrenController.text = noOfChildren;
              profession = snapshots.data()!["profession"];
              profesionController.text = profession;
              employmentStatus = snapshots.data()!["employmentStatus"];
              employmentStatusController.text = employmentStatus;
              income = snapshots.data()!["income"];
              incomeController.text = income;
              livingSituation = snapshots.data()!["livingSituation"];
              livingSituationController.text = livingSituation;
              willingToRelocate = snapshots.data()!["willingToRelocate"];
              willingToRelocateController.text = willingToRelocate;
              relationshipYouAreLookingFor = snapshots.data()!["relationshipYouAreLookingFor"];
              relationshipYouAreLookingForController.text = relationshipYouAreLookingFor;

              // Cultural
              nationality = snapshots.data()!["nationality"];
              nationalityController.text = nationality;
              education = snapshots.data()!["education"];
              educationController.text = education;
              languageSpoken = snapshots.data()!["languageSpoken"];
              languageSpokenController.text = languageSpoken;
              religion = snapshots.data()!["religion"];
              religionController.text = religion;
            });
          }
    });
  }

  updateUserDataToFirestoreDatabase(
      // Personal Info
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

    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            content: SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Updating Data...."),

                    SizedBox(
                      height: 10,
                    ),

                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          );
        }
    );

    await uploadImage();

    await FirebaseFirestore.instance
    .collection("users")
    .doc(currentUserId)
    .update({
      // Personal Info
      'name': name,
      'age': int.parse(age),
      'gender': gender.toLowerCase(),
      'phoneNo': phoneNo,
      'city': city,
      'country': country,
      'profileHeading': profileHeading,
      'lookingForInAPartner': lookingForInAPartner,

      // Appearance
      'height': height,
      'weight': weight,
      'bodyType': bodyType,

      // LifeStyle
      'drink': drink,
      'smoke': smoke,
      'martialStatus': martialStatus,
      'haveChildren': haveChildren,
      'noOfChildren': noOfChildren,
      'profession': profession,
      'employmentStatus': employmentStatus,
      'income': income,
      'livingSituation': livingSituation,
      'willingToRelocate': willingToRelocate,
      'relationshipYouAreLookingFor': relationshipYouAreLookingFor,

      // Cultural
      'nationality': nationality,
      'education': education,
      'languageSpoken': languageSpoken,
      'religion': religion,

      // images
      'urlImage1': urlsList[0].toString(),
      'urlImage2': urlsList[1].toString(),
      'urlImage3': urlsList[2].toString(),
      'urlImage4': urlsList[3].toString(),
      'urlImage5': urlsList[4].toString(),
    });

    Get.snackbar("Updated", "YOur data has been updated successfully");

    Get.to(const HomeScreen());

    setState(() {
      uploading = false;
      _image.clear();
      urlsList.clear();
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Profile Information" : "Choose 5 images",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),

        actions: [
          next
              ? Container()
              : IconButton(
                  onPressed: (){

                    if(_image.length == 5){
                      setState(() {
                        uploading = true;
                        next = true;
                      });
                    }
                    else{
                      Get.snackbar("More Images", "Pick 5 images to proceed");
                    }

                  },
                  icon: const Icon(
                      Icons.navigate_next_outlined,
                      size: 36,
                  )
                ),

        ],
      ),

      body: next
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // <----------------- Personal Information ---------------------->

                  // Profile Info
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // name
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: nameController,
                      labelText: "Name",
                      textInputType: TextInputType.name,
                      iconData: Icons.person_outline,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // age
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: ageController,
                      labelText: "Age",
                      textInputType: TextInputType.number,
                      iconData: Icons.calendar_month_outlined,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // gender
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: genderController,
                      labelText: "Gender",
                      textInputType: TextInputType.name,
                      iconData: Icons.person_pin,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // phone number
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: phoneNoController,
                      labelText: "Phone Number",
                      textInputType: TextInputType.phone,
                      iconData: Icons.phone,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // city
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: cityController,
                      labelText: "City",
                      textInputType: TextInputType.streetAddress,
                      iconData: Icons.location_city,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // country
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: countryController,
                      labelText: "Country",
                      textInputType: TextInputType.streetAddress,
                      iconData: Icons.location_city_outlined,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // profile Heading
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: profileHeadingController,
                      labelText: "Profile Heading",
                      textInputType: TextInputType.multiline,
                      iconData: Icons.text_fields,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // What you are looking for in a partner
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: lookingForInAPartnerController,
                      labelText: "What you're looking for in a partner",
                      textInputType: TextInputType.text,
                      iconData: Icons.face,
                      isObscure: false,
                    ),
                  ),

                  // <----------------- Personal Information ---------------------->

                  const SizedBox(
                    height: 30,
                  ),

                  // <----------------- Appearance Information -------------------->

                  // Appearence info
                  const Text(
                    "Appearance",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // height
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: heightController,
                      labelText: "Height",
                      textInputType: TextInputType.number,
                      iconData: Icons.height_outlined,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // weight
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: weightController,
                      labelText: "Weight",
                      textInputType: TextInputType.number,
                      iconData: Icons.monitor_weight_outlined,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // body type
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: bodyTypeController,
                      labelText: "Body Type",
                      textInputType: TextInputType.name,
                      iconData: Icons.person_outline,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // <----------------- Appearance Information -------------------->

                  const SizedBox(
                    height: 30,
                  ),

                  // <----------------- Lifestyle Information ---------------------->

                  // LifeStyle info
                  const Text(
                    "LifeStyle",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Drink Yes/No
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: drinkController,
                      labelText: "Drink (Yes/No)",
                      textInputType: TextInputType.name,
                      iconData: Icons.local_drink,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Smoke Yes/No
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: smokeController,
                      labelText: "Smoke (Yes/No)",
                      textInputType: TextInputType.name,
                      iconData: Icons.smoke_free,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Married or Not
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: isMarriedController,
                      labelText: "Martial Status",
                      textInputType: TextInputType.name,
                      iconData: CupertinoIcons.person_2,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Has Children
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: hasChildrenController,
                      labelText: "Do you have children?",
                      textInputType: TextInputType.name,
                      iconData: Icons.child_care_rounded,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Number of Children
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: numberOfChildrenController,
                      labelText: "Number of Children",
                      textInputType: TextInputType.number,
                      iconData: Icons.child_care_sharp,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Employment Status
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: employmentStatusController,
                      labelText: "Employment Status",
                      textInputType: TextInputType.name,
                      iconData: Icons.work_sharp,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Income
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: incomeController,
                      labelText: "Income",
                      textInputType: TextInputType.number,
                      iconData: Icons.currency_rupee,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Profession
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: profesionController,
                      labelText: "Profession",
                      textInputType: TextInputType.name,
                      iconData: Icons.work,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Living Situation
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: livingSituationController,
                      labelText: "Living Situation",
                      textInputType: TextInputType.name,
                      iconData: Icons.home,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Willing to Relocate
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: willingToRelocateController,
                      labelText: "Willing to Relocate",
                      textInputType: TextInputType.name,
                      iconData: Icons.travel_explore,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // relationshipYouAreLookingFor
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: relationshipYouAreLookingForController,
                      labelText: "Relationship you're looking for",
                      textInputType: TextInputType.name,
                      iconData: Icons.person_add_alt_1_outlined,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // <----------------- lifeStyle Information -------------------->

                  const SizedBox(
                    height: 30,
                  ),

                  // <----------------- Cultural Information ---------------------->

                  // Cultural info
                  const Text(
                    "Cultural",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Nationality
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: nationalityController,
                      labelText: "Nationality",
                      textInputType: TextInputType.name,
                      iconData: Icons.flag_circle_outlined,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Religion
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: religionController,
                      labelText: "Religion",
                      textInputType: TextInputType.name,
                      iconData: CupertinoIcons.checkmark_circle_fill,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Education
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: educationController,
                      labelText: "Education",
                      textInputType: TextInputType.name,
                      iconData: Icons.history_edu,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Language Spoken
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 36,
                    height: 65,
                    child: CustomTextFieldWidget(
                      editingController: languageSpokenController,
                      labelText: "Language Spoken",
                      textInputType: TextInputType.text,
                      iconData: Icons.person,
                      isObscure: false,
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),

                  // <-------------------- Cultural Info -------------------------->

                  // Update User Data button
                  Container(
                    width: MediaQuery.of(context).size.width - 130,
                    height: 50,

                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.white
                    ),

                    child: InkWell(
                      onTap: () async {

                        if(
                        // personal info
                        nameController.text.trim().isNotEmpty &&
                            ageController.text.trim().isNotEmpty &&
                            genderController.text.trim().isNotEmpty &&
                            phoneNoController.text.trim().isNotEmpty &&
                            cityController.text.trim().isNotEmpty &&
                            countryController.text.trim().isNotEmpty &&
                            profileHeadingController.text.trim().isNotEmpty &&
                            lookingForInAPartnerController.text.trim().isNotEmpty &&

                            // appearance
                            heightController.text.trim().isNotEmpty &&
                            weightController.text.trim().isNotEmpty &&
                            bodyTypeController.text.trim().isNotEmpty &&

                            // Life Style
                            drinkController.text.trim().isNotEmpty &&
                            smokeController.text.trim().isNotEmpty &&
                            isMarriedController.text.trim().isNotEmpty &&
                            hasChildrenController.text.trim().isNotEmpty &&
                            numberOfChildrenController.text.trim().isNotEmpty &&
                            profesionController.text.trim().isNotEmpty &&
                            employmentStatusController.text.trim().isNotEmpty &&
                            livingSituationController.text.trim().isNotEmpty &&
                            willingToRelocateController.text.trim().isNotEmpty &&
                            relationshipYouAreLookingForController.text.trim().isNotEmpty &&

                            // Cultural
                            nationalityController.text.trim().isNotEmpty &&
                            religionController.text.trim().isNotEmpty &&
                            educationController.text.trim().isNotEmpty &&
                            languageSpokenController.text.trim().isNotEmpty
                        ){

                          _image.isNotEmpty
                          ?
                          await updateUserDataToFirestoreDatabase(
                            // Personal Info
                            nameController.text.trim(),
                            ageController.text.trim(),
                            genderController.text.trim(),
                            phoneNoController.text.trim(),
                            cityController.text.trim(),
                            countryController.text.trim(),
                            profileHeadingController.text.trim(),
                            lookingForInAPartnerController.text.trim(),

                            // Appearance
                            heightController.text.trim(),
                            weightController.text.trim(),
                            bodyTypeController.text.trim(),

                            // LifeStyle
                            drinkController.text.trim(),
                            smokeController.text.trim(),
                            isMarriedController.text.trim(),
                            hasChildrenController.text.trim(),
                            numberOfChildrenController.text.trim(),
                            profesionController.text.trim(),
                            employmentStatusController.text.trim(),
                            incomeController.text.trim(),
                            livingSituationController.text.trim(),
                            willingToRelocateController.text.trim(),
                            relationshipYouAreLookingForController.text.trim(),

                            // Cultural
                            nationalityController.text.trim(),
                            educationController.text.trim(),
                            languageSpokenController.text.trim(),
                            religionController.text.trim(),
                          )
                          : null;


                        }
                        else{
                          Get.snackbar("Data not updated", "Fields empty");
                        }

                      },

                      child: const Center(
                        child: Text(
                          "Update",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          : Stack(
              children: [

                Container(
                  padding: const EdgeInsets.all(4),
                  child: GridView.builder(
                    itemCount: _image.length + 1,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context,index){
                      return index == 0
                          //   If index is 0 means 0 uploaded images, means user will now upload image
                          ? Container(
                              color: Colors.white,
                              child: Center(
                                child: IconButton(
                                  onPressed: (){

                                    if(_image.length < 5){
                                      !uploading ? chooseImage() : null;
                                    }
                                    else{
                                      setState(() {
                                        uploading = true;
                                      });
                                      Get.snackbar("Already chosen 5 images", "");
                                    }

                                  },
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                    _image[index - 1],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                    },
                  ),
                )

              ],
            ),
    );
  }
}
