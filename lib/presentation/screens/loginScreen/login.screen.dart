import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/core/utils/obscure.text.util.dart';
import 'package:campings_app/presentation/widgets/custom.button.dart';
import 'package:campings_app/presentation/widgets/custom.snackbar.dart';
import 'package:campings_app/presentation/widgets/custom.styles.dart';
import 'package:campings_app/presentation/widgets/custom.text.field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = themeNotifier.darkTheme;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        appBar: AppBar(
          backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
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
                        Strings.welcomeBack,
                        style: TextStyle(
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Strings.weMissedYou,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: themeFlag
                              ? AppColors.creamColor
                              : AppColors.mirage,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField.customTextField(
                              hintText: Strings.userEmail,
                              inputType: TextInputType.emailAddress,
                              textEditingController: userEmailController,
                              validator: (val) =>
                                  !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                          .hasMatch(val!)
                                      ? Strings.insertValidEmail
                                      : null,
                              themeFlag: themeFlag,
                            ),
                            CustomTextField.customPasswordField(
                              themeFlag: themeFlag,
                              context: context,
                              validator: (val) =>
                                  val!.isEmpty ? Strings.insertPassword : null,
                              onTap: () {
                                Provider.of<ObscureTextUtil>(context,
                                        listen: false)
                                    .toggleObs();
                              },
                              textEditingController: userPassController,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.dontHaveAccountQuestion,
                      style: kBodyText.copyWith(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.signupRoute);
                      },
                      child: Text(
                        Strings.confirmRegister,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: CustomButton.customBtnLogin(
                    buttonName: Strings.confirmSignIn,
                    onTap: () {
                      login(context: context);
                    },
                    bgColor:
                        themeFlag ? AppColors.creamColor : AppColors.mirage,
                    textColor:
                        themeFlag ? AppColors.mirage : AppColors.creamColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      bool isValid =
          await Provider.of<AuthenticationNotifer>(context, listen: false)
              .login(
        email: userEmailController.text,
        password: userPassController.text,
      );
      if (isValid && context.mounted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.navRoute);

        SnackUtil.showSnackBar(
          context: context,
          text: Strings.loginSuccessfull,
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
