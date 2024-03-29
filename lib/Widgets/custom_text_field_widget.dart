import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {

  final TextEditingController? editingController;
  final IconData? iconData;
  final String? assetRef;
  final String? labelText;
  final bool? isObscure;
  final TextInputType? textInputType;

  const CustomTextFieldWidget({
    super.key,
    this.editingController,
    this.iconData,
    this.assetRef,
    this.labelText,
    this.isObscure,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: labelText,

        icon: iconData != null 
            ? Icon(iconData) 
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(assetRef.toString()),
              ),

        labelStyle: const TextStyle(
          fontSize: 19
        ),

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
            color: Colors.grey,
          )
        ),

        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
            )
        ),
      ),
      obscureText: isObscure!,
    );
  }
}
