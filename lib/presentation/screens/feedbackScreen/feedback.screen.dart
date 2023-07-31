import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/models/feedback.model.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/feedback.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/screens/feedbackScreen/widgets/feedback.appbar.dart';
import 'package:campings_app/presentation/widgets/custom.button.dart';
import 'package:campings_app/presentation/widgets/custom.snackbar.dart';
import 'package:campings_app/presentation/widgets/custom.text.field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FeedbackScreen extends StatelessWidget {
  final TextEditingController ftitleController = TextEditingController();
  final TextEditingController fdescController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double userRating = 1;
  FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = themeNotifier.darkTheme;
    double totalHeight = MediaQuery.of(context).size.height / 815;

    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      appBar: feedbackAppBar(themeFlag: themeFlag),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Strings.giveUsFeedback,
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
                              hintText: Strings.feedbackFieldTitle,
                              inputType: TextInputType.text,
                              textEditingController: ftitleController,
                              validator: (val) =>
                                  val!.isEmpty ? Strings.feedbackFieldHintTitle : null,
                              themeFlag: themeFlag,
                            ),
                            CustomTextField.customTextField(
                              hintText: Strings.feedbackFieldDescription,
                              inputType: TextInputType.multiline,
                              textEditingController: fdescController,
                              validator: (val) =>
                                  val!.isEmpty ? Strings.feedbackFieldHintDescription : null,
                              themeFlag: themeFlag,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Strings.rating,
                            style: TextStyle(
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 1,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              userRating = rating;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: totalHeight * 80,
                ),
                CustomButton.customBtnLogin(
                  buttonName: Strings.confirmFeedback,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _submitFeedback(context: context);
                      // couponCode(context: context, themeFlag: themeFlag);
                    }
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

  _submitFeedback({required BuildContext context}) async {
    String createdAt = DateFormat(Strings.dateFormat).format(
      DateTime.now(),
    );
    AuthenticationNotifer authenticationNotifer =
        Provider.of<AuthenticationNotifer>(context, listen: false);
    FeedbackModel feedbackModel = FeedbackModel(
      createdAt: createdAt.toString(),
      feedbackTitle: ftitleController.text,
      feedbackDescription: fdescController.text,
      feedbackStars: userRating,
      userId: authenticationNotifer.userId!,
    );
    FeedbackNotifier feedBackNotifier =
        Provider.of<FeedbackNotifier>(context, listen: false);
    var valid =
        await feedBackNotifier.saveFeedback(feedbackModel: feedbackModel);

    if (valid && context.mounted) {
      SnackUtil.showSnackBar(
        context: context,
        text: Strings.thanksForSubmittingFeedback,
        textColor: AppColors.creamColor,
        backgroundColor: Colors.green,
      );
    } else {
      var errorType = feedBackNotifier.error;
      SnackUtil.showSnackBar(
        context: context,
        text: errorType!,
        textColor: AppColors.creamColor,
        backgroundColor: Colors.red.shade200,
      );
    }
  }
}
