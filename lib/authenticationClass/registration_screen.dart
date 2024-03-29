import 'dart:io';

import 'package:dating_app/authenticationClass/login_screen.dart';
import 'package:dating_app/controllers/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/custom_text_field_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  // personal info
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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

  bool showProgressBar = false;

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              const SizedBox(
                height: 100,
              ),
              
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "To get started now",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // Profile Image

              authenticationController.imageFile == null ?
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.black,
                backgroundImage: AssetImage("images/profile_avatar.jpg"),
              ) :
              Container(
                height: 180,
                  width: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: FileImage(
                        File(
                          authenticationController.imageFile!.path,
                        ),
                      ),

                    )
                  ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Choose from Galley Profile Picture
                  IconButton(
                      onPressed: () async {
                        await authenticationController.pickImageFileFromGallery();

                        setState(() {
                          authenticationController.imageFile;
                        });
                      },
                      icon: const Icon(
                          Icons.image_outlined,
                        color: Colors.grey,
                      ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  // // Capture Profile Picture  Using Camera
                  IconButton(
                    onPressed: () async {
                      await authenticationController.captureImageFromCamera();

                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(
                      Icons.camera_enhance,
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),

              const SizedBox(
                height: 28,
              ),

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

              // <----------------- Personal Information ---------------------->

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

              // email
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 65,
                child: CustomTextFieldWidget(
                  editingController: emailController,
                  labelText: "Email",
                  textInputType: TextInputType.emailAddress,
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // password
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 65,
                child: CustomTextFieldWidget(
                  editingController: passwordController,
                  labelText: "Password",
                  textInputType: TextInputType.visiblePassword,
                  iconData: Icons.lock_outline,
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

              // age
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

              // create account button
              Container(
                width: MediaQuery.of(context).size.width - 130,
                height: 50,

                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white
                ),

                child: InkWell(
                  onTap: () async {

                    if(authenticationController.imageFile != null){
                      if(
                          // personal info
                          emailController.text.trim().isNotEmpty &&
                          passwordController.text.trim().isNotEmpty &&
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

                        setState(() {
                          showProgressBar = true;
                        });

                        await authenticationController.createUser(
                            // Personal Info
                            authenticationController.profileImage!,
                            emailController.text.trim(),
                            passwordController.text.trim(),
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
                        );

                        setState(() {
                          showProgressBar = false;
                        });
                      }
                      else{
                        Get.snackbar("Account not created", "Fields empty");
                      }
                    }
                    else{
                      Get.snackbar("Account not created", "Profile Picture is empty");
                    }

                  },

                  child: const Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    "Already have an account?, ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Get.to(const LoginScreen());
                    },

                    child: const Text(
                      "Login Now",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(
                height: 16,
              ),

              showProgressBar == true
                  ? CircularProgressIndicator(
                backgroundColor: Colors.pink.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.pink),
              )
                  : Container(),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
