import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import '../../models/onBoarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/componets/widgets.dart';
import '../../shared/styles/colors.dart';
import '../login/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boarding =
  [
    OnBoardingModel(
        image: 'https://assets6.lottiefiles.com/packages/lf20_bqnjxnmy.json',
        title: 'On Board 1',
        subTitle: 'On Board body 1'
    ),
    OnBoardingModel(
      image: 'https://assets6.lottiefiles.com/packages/lf20_axztuerm.json',
      title: 'On Board 2',
      subTitle: 'On Board body 2'
    ),
    OnBoardingModel(
        image: 'https://assets6.lottiefiles.com/packages/lf20_ttnc5lln.json',
        title: 'On Board 3',
        subTitle: 'On Board body 3'
    ),
  ];

  bool isLast =false;

  PageController onBoardController = PageController();

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      navigatorPushAndRemove(context: context,widget: LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: ()
            {
              submit();
            }, child: const Text('SKIP'))
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(padding: const EdgeInsets.all(30),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                controller: onBoardController,
                itemBuilder: (context, i) => buildOnBoardItem(boarding[i]),
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (i){
                  if(i==boarding.length-1)
                  {
                    setState(() {
                      isLast = true;
                    }
                    );
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                  controller: onBoardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: kPrimaryColor
                  ),
                ),
                const Spacer(),
                isLast ? FloatingActionButton(
                 child: const Icon(Icons.done),
                  onPressed: ()
                  {
                    submit();
                  }) : FloatingActionButton(onPressed: ()
                {
                  onBoardController.nextPage(duration: const Duration(
                      milliseconds: 750
                  ), curve: Curves.fastLinearToSlowEaseIn);
                },
                  child: const Icon(Icons.arrow_forward),),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
        )
    );
  }
}
