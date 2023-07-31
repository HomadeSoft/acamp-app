import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/notifiers/camping.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/screens/campingScreen/camping.screen.dart';
import 'package:campings_app/presentation/screens/searchScreen/widgets/search.items.dart';
import 'package:campings_app/presentation/widgets/custom.styles.dart';
import 'package:campings_app/presentation/widgets/custom.text.field.dart';
import 'package:campings_app/presentation/widgets/no.data.dart';
import 'package:campings_app/presentation/widgets/shimmer.effects.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchProductController = TextEditingController();
  bool isExecuted = false;

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = themeNotifier.darkTheme;
    double totalHeight = MediaQuery.of(context).size.height / 815;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: AppColors.rawSienna,
                      width: 1,
                    ),
                  ),
                  elevation: 6,
                  color: themeFlag ? AppColors.mirage : AppColors.creamColor,
                  child: CustomTextField.customTextField2(
                    hintText: Strings.search,
                    inputType: TextInputType.text,
                    textEditingController: searchProductController,
                    validator: (val) =>
                        val!.isEmpty ? Strings.searchHint : null,
                    themeFlag: themeFlag,
                    onChanged: (val) {
                      setState(() {
                        isExecuted = true;
                      });
                    },
                  ),
                ),
              ),
              isExecuted
                  ? searchData(
                      searchContent: searchProductController.text,
                      themeFlag: themeFlag)
                  : Column(
                      children: [
                        SizedBox(
                          height: totalHeight * 290,
                        ),
                        Center(
                          child: Text(
                            Strings.searchHintMainView,
                            style: kBodyText.copyWith(
                              fontSize: totalHeight * 20,
                              fontWeight: FontWeight.bold,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchData({required String searchContent, required bool themeFlag}) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: Consumer<CampingNotifier>(
            builder: (context, notifier, _) {
              return FutureBuilder(
                future: notifier.getSearchCampings(
                  campingName: searchProductController.text.replaceAll(' ', ''),
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ShimmerEffects.loadShimmerFavouriteandSearch(
                        context: context, displayTrash: false);
                  } else {
                    List campings = snapshot.data as List;
                    if (kDebugMode) {
                      print(searchProductController.text.replaceAll(' ', ''));
                    }
                    if (campings.isEmpty) {
                      return noDataFound(
                        themeFlag: themeFlag,
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          CampingModel campingModel = campings[index];
                          return SearchItem(
                            campingModel: campingModel,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRouter.campingDetailRoute,
                                arguments: CampingScreenArgs(
                                  campingId: campingModel.campingId,
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
