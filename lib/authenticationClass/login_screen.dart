import 'package:dating_app/Widgets/custom_text_field_widget.dart';
import 'package:dating_app/authenticationClass/registration_screen.dart';
import 'package:dating_app/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var authController = AuthenticationController.authController;

  bool showProgressBar = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            
            children: [

              const SizedBox(
                height: 80,
              ),
              
              Image.asset(
                'images/logo.png',
                width: 300,
              ),

              const SizedBox(
                height: 2,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to the ',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),

                  Text(
                    'Match Hill',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 5,
              ),

              const Text(
                'Login to find your best match',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // email
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: emailController,
                  labelText: "Email",
                  textInputType: TextInputType.emailAddress,
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // password
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: passwordController,
                  labelText: "Password",
                  textInputType: TextInputType.text,
                  iconData: Icons.lock_open_outlined,
                  isObscure: true,
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              // login button
              Container(
                width: MediaQuery.of(context).size.width - 130,
                height: 50,

                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white
                ),

                child: InkWell(
                  onTap: () async {

                    if(emailController.text.trim().isNotEmpty
                        && passwordController.text.trim().isNotEmpty){

                      setState(() {
                        showProgressBar = true;
                      });

                      await authController.loginUser(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                      );

                      setState(() {
                        showProgressBar = false;
                      });
                    }

                  },

                  child: const Center(
                    child: Text(
                      "Login",
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
                    "Don't have an account?, ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      Get.to(const RegistrationScreen());
                    },

                    child: const Text(
                      "Register Now",
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