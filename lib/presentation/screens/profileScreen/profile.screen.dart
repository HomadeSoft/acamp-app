import 'dart:io';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/core/service/photo.service.dart';
import 'package:campings_app/presentation/widgets/custom.button.dart';
import 'package:campings_app/presentation/widgets/custom.snackbar.dart';
import 'package:campings_app/presentation/widgets/custom.text.field.dart';
import 'package:campings_app/presentation/widgets/loading.dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileTaskArgs? profileTaskArgs;

  const ProfileScreen({Key? key, required this.profileTaskArgs})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPhoneNController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();

  @override
  void initState() {
    userNameController.text = widget.profileTaskArgs!.userName;
    userPhoneNController.text = widget.profileTaskArgs!.userPhoneNo;
    userEmailController.text = widget.profileTaskArgs!.userEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    PhotoService photoService =
        Provider.of<PhotoService>(context, listen: true);
    AuthenticationNotifer auth =
        Provider.of<AuthenticationNotifer>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;
    double height = MediaQuery.of(context).size.height / 815;

    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.yourProfile,
                  style: TextStyle(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 150.0,
                        child: photoService.image == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.network(
                                  widget.profileTaskArgs!.userImage!,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.file(
                                  File(
                                    photoService.image!.path,
                                  ),
                                ),
                              ),
                      ),
                      Positioned(
                        top: 115,
                        left: 110,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 18,
                            ),
                            onPressed: () {
                              photoService.selectFile();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    CustomTextField.customTextField(
                        themeFlag: themeFlag,
                        hintText: Strings.userName,
                        inputType: TextInputType.text,
                        validator: (val) =>
                            val!.isEmpty ? Strings.loginFormUserNameHint : null,
                        textEditingController: userNameController),
                    CustomTextField.customTextField(
                      themeFlag: themeFlag,
                      hintText: Strings.loginFormEmail,
                      inputType: TextInputType.emailAddress,
                      textEditingController: userEmailController,
                      enabled: false,
                    ),
                    CustomTextField.customTextField(
                      themeFlag: themeFlag,
                      hintText: Strings.loginFormPhone,
                      inputType: TextInputType.number,
                      maxLength: 10,
                      textEditingController: userPhoneNController,
                      validator: (val) => val!.isEmpty || val.length < 10
                          ? Strings.loginFormPhoneHint
                          : null,
                    ),
                    SizedBox(
                      height: height * 165,
                    ),
                    CustomButton.customBtnLogin(
                      buttonName: Strings.confirmUpdateProfile,
                      onTap: () async {
                        LoadingDialog.showLoaderDialog(
                            context: context, themeFlag: themeFlag);
                        if (photoService.image != null) {
                          await photoService.upload(context: context).then(
                            (value) async {
                              if (value) {
                                bool isDone = await auth.updateUserData(
                                  useremail: userEmailController.text,
                                  username: userNameController.text,
                                  userMobileNo: userPhoneNController.text,
                                  userPhoto: photoService.photo_url!,
                                );
                                if (isDone && context.mounted) {
                                  SnackUtil.showSnackBar(
                                    context: context,
                                    text: Strings.updateSuccess,
                                    textColor: AppColors.creamColor,
                                    backgroundColor: Colors.green,
                                  );
                                } else {
                                  SnackUtil.showSnackBar(
                                    context: context,
                                    text: auth.error!,
                                    textColor: AppColors.creamColor,
                                    backgroundColor: Colors.red.shade200,
                                  );
                                }
                              } else {
                                SnackUtil.showSnackBar(
                                  context: context,
                                  text: photoService.errorUpload!,
                                  textColor: AppColors.creamColor,
                                  backgroundColor: Colors.red.shade200,
                                );
                              }
                            },
                          );
                        } else {
                          if (photoService.photo_url == null) {
                            bool isDone = await auth.updateUserData(
                              useremail: userEmailController.text,
                              username: userNameController.text,
                              userMobileNo: userPhoneNController.text,
                              userPhoto: widget.profileTaskArgs!.userImage!,
                            );

                            if (isDone && context.mounted) {
                              SnackUtil.showSnackBar(
                                context: context,
                                text: Strings.uploadPictureSuccess,
                                textColor: AppColors.creamColor,
                                backgroundColor: Colors.green,
                              );
                            } else {
                              SnackUtil.showSnackBar(
                                context: context,
                                text: auth.error!,
                                textColor: AppColors.creamColor,
                                backgroundColor: Colors.red.shade200,
                              );
                            }
                          }
                        }
                        if (context.mounted) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      },
                      bgColor:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      textColor:
                          themeFlag ? AppColors.mirage : AppColors.creamColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTaskArgs {
  final String userName;
  final String userEmail;
  final String userPhoneNo;
  String? userImage;

  ProfileTaskArgs({
    required this.userName,
    required this.userEmail,
    required this.userPhoneNo,
    this.userImage,
  });
}
