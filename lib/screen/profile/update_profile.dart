import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gypsy/constraints/constraints.dart';
import 'package:gypsy/model/user.dart';
import 'package:gypsy/repository/user_repository.dart';
import 'package:gypsy/response/user_response.dart';
import 'package:gypsy/widget/inputfield.dart';
import 'package:gypsy/widget/show_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({key});
  static String route = "/UpdateScreen";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? uploadImage;
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  void setInitialData() async {
    final response = await UserRepository().getUserProfile();

    _fullNameController.text = response!.data!.name!;
    _phoneController.text = response.data!.phoneNumber!;
    _emailController.text = response.data!.email!;
    _addressController.text = response.data!.address!;
  }

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  Widget showUploadedImage(File? pickedImageFile) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(color: Colors.purple, width: 3.0),
      ),
      color: Colors.red,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              pickedImageFile == null
                  ? Image.network("assets/images/finger.png")
                  : Image.file(
                      pickedImageFile,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.fill,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          uploadImage = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      print("Failed to upload Image");
    }
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              insetPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () => _loadImage(FROM_GALLERY),
                      icon: const Icon(Icons.browse_gallery),
                      label: const Text("Gallery")),
                  ElevatedButton.icon(
                      onPressed: () => _loadImage(FROM_CAMERA),
                      icon: const Icon(Icons.camera),
                      label: const Text("Camera")),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFFFC6011),
        title: const Text("Update Profile",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: setUserProfile(),
    );
  }

  FutureBuilder<UserResponse?> setUserProfile() {
    return FutureBuilder<UserResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userData = snapshot.data!.data!;
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _loadImage(ImageSource.gallery);
                                      });
                                    },
                                    child: SizedBox(
                                      width: 30 * 4,
                                      height: 40 * 3,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50 * 2),
                                        child: uploadImage == null
                                            ? Image.network(
                                                userData.userImage!,
                                                fit: BoxFit.cover,
                                                width: double.maxFinite,
                                              )
                                            : Image.file(
                                                uploadImage!,
                                                fit: BoxFit.cover,
                                                width: double.maxFinite,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      // height: 35,
                                      // width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50 * 2)),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showAlertDialog(context);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    UserInputField(
                                      readOnly: false,
                                      controller: _fullNameController,
                                      hintText: 'Name',
                                      prefixIcon: LineAwesomeIcons.user,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    UserInputField(
                                      readOnly: true,
                                      controller: _emailController,
                                      hintText: 'Email',
                                      prefixIcon: LineAwesomeIcons.envelope,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    UserInputField(
                                      readOnly: false,
                                      hintText: 'Phone',
                                      controller: _phoneController,
                                      prefixIcon: LineAwesomeIcons.phone,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    UserInputField(
                                      readOnly: false,
                                      hintText: 'Address',
                                      controller: _addressController,
                                      prefixIcon:
                                          LineAwesomeIcons.location_arrow,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          User user = User(
                                            _fullNameController.text,
                                            _phoneController.text,
                                            _emailController.text,
                                            _addressController.text,
                                            "",
                                            "",
                                          );
                                          bool result = false;
                                          uploadImage == null
                                              ? result = await UserRepository()
                                                  .updateUserProfile(user)
                                              : result = await UserRepository()
                                                  .updateUserProfileWithImage(
                                                      user, uploadImage!);
                                          if (result == true) {
                                            ShowToast.displaySuccessToast(
                                                context, "Profile Updated");
                                          } else {
                                            ShowToast.displayErrorToast(
                                                context, "Failed to update");
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0XFFFC6011),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        child: const Text('Update'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
