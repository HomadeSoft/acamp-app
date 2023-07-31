import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/models/user.model.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/password.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/core/utils/obscure.text.util.dart';
import 'package:campings_app/presentation/screens/signupScreen/widgets/custom.password.check.dart';
import 'package:campings_app/presentation/widgets/custom.button.dart';
import 'package:campings_app/presentation/widgets/custom.snackbar.dart';
import 'package:campings_app/presentation/widgets/custom.styles.dart';
import 'package:campings_app/presentation/widgets/custom.text.field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPassController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPhoneNController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = themeNotifier.darkTheme;
    PasswordNotifier passNotifier(bool renderUI) =>
        Provider.of<PasswordNotifier>(context, listen: renderUI);

    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      appBar: AppBar(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Strings.register,
                        style: kHeadline.copyWith(
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Strings.createNewAccount,
                        style: kBodyText2.copyWith(
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField.customTextField(
                              themeFlag: themeFlag,
                              hintText: Strings.loginFormUserName,
                              inputType: TextInputType.text,
                              textEditingController: userNameController,
                              validator: (val) => val!.isEmpty
                                  ? Strings.loginFormUserNameHint
                                  : null,
                            ),
                            CustomTextField.customTextField(
                              themeFlag: themeFlag,
                              hintText: Strings.loginFormEmail,
                              textEditingController: userEmailController,
                              validator: (val) => val!.isEmpty
                                  ? Strings.loginFormEmailHint
                                  : null,
                              inputType: TextInputType.text,
                            ),
                            CustomTextField.customTextField(
                              themeFlag: themeFlag,
                              hintText: Strings.loginFormPhone,
                              inputType: TextInputType.number,
                              maxLength: 10,
                              textEditingController: userPhoneNController,
                              validator: (val) =>
                                  val!.isEmpty || val.length < 10
                                      ? Strings.loginFormPhoneHint
                                      : null,
                            ),
                            CustomTextField.customPasswordField(
                              themeFlag: themeFlag,
                              context: context,
                              validator: (val) => val!.isEmpty
                                  ? Strings.loginFormPasswordHint
                                  : null,
                              onChanged: (val) {
                                passNotifier(false)
                                    .checkPasswordStrength(password: val);
                              },
                              onTap: () {
                                Provider.of<ObscureTextUtil>(context,
                                        listen: false)
                                    .toggleObs();
                              },
                              textEditingController: userPassController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(passNotifier(true).passwordEmoji!),
                          const SizedBox(
                            width: 10,
                          ),
                          if (passNotifier(true).passwordLevel! ==
                              Strings.weakPAssword)
                            CustomAnimatedContainer.customAnimatedContainer(
                              height: 10,
                              width: MediaQuery.of(context).size.width * 0.10,
                              context: context,
                              color: Colors.red,
                              curve: Curves.easeIn,
                            ),
                          if (passNotifier(true).passwordLevel! ==
                              Strings.mediumPassword)
                            CustomAnimatedContainer.customAnimatedContainer(
                              height: 10,
                              width: MediaQuery.of(context).size.width * 0.40,
                              context: context,
                              color: Colors.blue,
                              curve: Curves.easeIn,
                            ),
                          if (passNotifier(true).passwordLevel! ==
                              Strings.strongPassword)
                            CustomAnimatedContainer.customAnimatedContainer(
                              height: 10,
                              width: MediaQuery.of(context).size.width * 0.81,
                              context: context,
                              color: Colors.green,
                              curve: Curves.easeIn,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.alreadyAccount,
                      style: kBodyText.copyWith(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.loginRoute);
                      },
                      child: Text(
                        Strings.confirmSignIn,
                        style: kBodyText.copyWith(
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton.customBtnLogin(
                  buttonName: Strings.confirmRegister,
                  onTap: () {
                    signUp(context: context);
                  },
                  bgColor: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  textColor:
                      themeFlag ? AppColors.mirage : AppColors.creamColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      // Old Date format "EEEEE, dd, yyyy"
      String createdAt = DateFormat(Strings.dateFormat).format(
        DateTime.now(),
      );
      UserModel userModel = UserModel(
        createdAt: createdAt,
        userName: userNameController.text,
        userEmail: userEmailController.text,
        userPassword: userPassController.text,
        userPhoneNo: userPhoneNController.text,
      );
      bool isValid =
          await Provider.of<AuthenticationNotifer>(context, listen: false)
              .signUp(userModel: userModel);
      if (isValid && context.mounted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.navRoute);

        SnackUtil.showSnackBar(
          context: context,
          text: Strings.signupSuccess,
          textColor: AppColors.creamColor,
          backgroundColor: Colors.green,
        );
      } else {
        var errorType =
            Provider.of<AuthenticationNotifer>(context, listen: false).error;
        SnackUtil.showSnackBar(
          context: context,
          text: errorType!,
          textColor: AppColors.creamColor,
          backgroundColor: Colors.red.shade200,
        );
      }
    }
  }
}
