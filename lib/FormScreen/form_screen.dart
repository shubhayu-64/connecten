import 'package:flutter/material.dart';
import 'package:ConnecTen/FormScreen/widgets/continue_button_widget.dart';
import 'package:ConnecTen/FormScreen/widgets/profile_image_widget.dart';
import 'package:ConnecTen/utils/size_config.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  // Editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Name field
    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight! * 0.02, horizontal: screenWidth! * 0.05),
        hintText: "Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Designation Field
    final designationField = TextFormField(
      autofocus: false,
      controller: designationController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        designationController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.work),
        contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight! * 0.02, horizontal: screenWidth! * 0.05),
        hintText: "Designation",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Bio Field
    final bioField = TextField(
      autofocus: false,
      controller: bioController,
      minLines: 1,
      maxLines: 4,
      keyboardType: TextInputType.text,
      onSubmitted: (value) {
        bioController.text = value;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.school),
        contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight! * 0.02, horizontal: screenWidth! * 0.05),
        hintText: "Bio",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    // Continue Button
    final continueButton = ContinueButtonWidget(
        nameController: nameController,
        designationController: designationController,
        bioController: bioController);

    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(screenHeight! * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ProfileImageWidget(),
                      SizedBox(
                        height: 45,
                      ),
                      nameField,
                      SizedBox(
                        height: 20,
                      ),
                      designationField,
                      SizedBox(
                        height: 20,
                      ),
                      bioField,
                      SizedBox(
                        height: 20,
                      ),
                      continueButton,
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
}

