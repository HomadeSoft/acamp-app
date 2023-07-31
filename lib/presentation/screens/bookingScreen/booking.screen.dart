// ignore_for_file: use_build_context_synchronously

import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/models/booking.model.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/booking.notifer.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/widgets/custom.button.dart';
import 'package:campings_app/presentation/widgets/custom.snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  final BookingScreenArgs bookingScreenArgs;

  const BookingScreen({Key? key, required this.bookingScreenArgs})
      : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool check = false;

  @override
  void initState() {
    check = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;
    var userData = Provider.of<AuthenticationNotifer>(context, listen: true);
    var bookNotifier = Provider.of<BookingNotifier>(context, listen: true);
    // TextEditingController couponText = TextEditingController();

    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      appBar: AppBar(
        backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        title: Text(
          Strings.bookingPageTitle,
          style: TextStyle(
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Strings.userDetailsTitle,
                style: TextStyle(
                  color: AppColors.yellowish,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage),
              Text(
                '${Strings.userName} : ${userData.userName!}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '${Strings.userEmail} : ${userData.userEmail}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '${Strings.userPhone} : ${userData.userPhoneNo}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                Strings.campingDetailsTitle,
                style: TextStyle(
                  color: AppColors.yellowish,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage),
              Text(
                '${Strings.campingName} : ${widget.bookingScreenArgs.campingData.campingName}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '${Strings.campingAddress} : ${widget.bookingScreenArgs.campingData.campingAddress}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${Strings.campingType} : ${widget.bookingScreenArgs.campingData.campingType}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '${Strings.campingPrice} : ${widget.bookingScreenArgs.campingData.campingPrice}',
                style: TextStyle(
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Divider(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                Strings.bookingDatesTitle,
                style: TextStyle(
                  color: AppColors.yellowish,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${Strings.startDate} : ${bookNotifier.startDate ?? ''}',
                    style: TextStyle(
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  IconButton(
                    splashColor:
                        themeFlag ? AppColors.creamColor : AppColors.mirage,
                    icon: Icon(
                      Icons.edit_calendar,
                      size: 20,
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                    ),
                    onPressed: () {
                      startDatePicker(
                        themeFlag: themeFlag,
                        context: context,
                        bookingNotifier: bookNotifier,
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${Strings.endDate} : ${bookNotifier.endDate ?? ''} ',
                    style: TextStyle(
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  IconButton(
                    onPressed: () {
                      endDatePicker(
                        themeFlag: themeFlag,
                        context: context,
                        bookingNotifier: bookNotifier,
                      );
                    },
                    splashColor:
                        themeFlag ? AppColors.creamColor : AppColors.mirage,
                    icon: Icon(
                      Icons.edit_calendar,
                      size: 20,
                      color:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     const Icon(Icons.card_giftcard),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 8.0),
                  //       child: Container(
                  //         constraints: const BoxConstraints(maxWidth: 210),
                  //         child: TextFormField(
                  //           controller: couponText,
                  //           style: TextStyle(
                  //             color: themeFlag
                  //                 ? AppColors.creamColor
                  //                 : AppColors.mirage,
                  //             fontSize: 16.0,
                  //           ),
                  //           decoration: InputDecoration(
                  //             hintText: 'Enter Coupon Code',
                  //             hintStyle: TextStyle(
                  //               color: themeFlag
                  //                   ? AppColors.creamColor
                  //                   : AppColors.mirage,
                  //               fontSize: 16.0,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton.customBtnLogin(
                    buttonName: Strings.confirmBooking,
                    onTap: () async {
                      if (bookNotifier.startDate != null &&
                          bookNotifier.endDate != null) {
                        // var PayStatus = await Provider.of<PaymentNotifier>(
                        //   context,
                        //   listen: false,
                        // );
                        // await PayStatus.checkMeOut(
                        //   context: context,
                        //   amt: widget.bookingScreenArgs.campingData.campingPrice
                        //       .toInt(),
                        // ).whenComplete(
                        // () async {
                        // if (PayStatus.paymentStatus!) {
                        BookingModel bookingModel = BookingModel(
                          bookingPrice: check
                              ? widget.bookingScreenArgs.campingData
                                      .campingPrice -
                                  (widget.bookingScreenArgs.campingData
                                          .campingPrice *
                                      5 ~/
                                      100)
                              : widget
                                  .bookingScreenArgs.campingData.campingPrice,
                          bookingStartDate: bookNotifier.startDate!,
                          bookingEndDate: bookNotifier.endDate!,
                        );

                        var isSuccessFul = await Provider.of<BookingNotifier>(
                                context,
                                listen: false)
                            .confirmBooking(
                          bookingModel: bookingModel,
                          userId: userData.userId!,
                          campingId:
                              widget.bookingScreenArgs.campingData.campingId,
                        );

                        if (isSuccessFul) {
                          SnackUtil.showSnackBar(
                            context: context,
                            text: Strings.bookingSuccess,
                            textColor: AppColors.creamColor,
                            backgroundColor: Colors.red.shade200,
                          );
                          Navigator.pop(context);
                        } else {
                          SnackUtil.showSnackBar(
                            context: context,
                            text: Strings.errorUnknown,
                            textColor: AppColors.creamColor,
                            backgroundColor: Colors.red.shade200,
                          );
                          Navigator.pop(context);
                        }
                        // }
                        // };
                        // );
                      } else {
                        SnackUtil.showSnackBar(
                          context: context,
                          text: Strings.selectDates,
                          textColor: AppColors.creamColor,
                          backgroundColor: Colors.red.shade200,
                        );
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
    );
  }
}

class BookingScreenArgs {
  final CampingModel campingData;
  final dynamic userId;

  BookingScreenArgs({
    required this.userId,
    required this.campingData,
  });
}

Future startDatePicker({
  required bool themeFlag,
  required BuildContext context,
  required BookingNotifier bookingNotifier,
}) {
  final date = DateTime.now();
  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: themeFlag ? AppColors.creamColor : AppColors.mirage,
        content: SizedBox(
          height: 200,
          width: 350.0,
          child: CupertinoDatePicker(
            minimumDate: DateTime.now(),
            maximumDate: DateTime(date.year, date.month + 1, date.day),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              String createdAt = DateFormat(Strings.dateFormat).format(value);
              bookingNotifier.startDateSet(createdAt: createdAt);
            },
            initialDateTime: DateTime.now(),
          ),
        ),
      );
    },
  );
}

Future endDatePicker({
  required bool themeFlag,
  required BuildContext context,
  required BookingNotifier bookingNotifier,
}) {
  final date = DateTime.now();

  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: themeFlag ? AppColors.creamColor : AppColors.mirage,
        content: SizedBox(
          height: 200,
          width: 350.0,
          child: CupertinoDatePicker(
            // minimumDate: DateTime(date.year, date.month, date.day + 1),
            maximumDate: DateTime(date.year, date.month + 1, date.day),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              String createdAt = DateFormat(Strings.dateFormat).format(value);
              bookingNotifier.endDateSet(createdAt: createdAt);
            },
            initialDateTime: DateTime(date.year, date.month, date.day + 1),
          ),
        ),
      );
    },
  );
}
