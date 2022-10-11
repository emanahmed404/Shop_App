import 'package:flutter/material.dart';
import 'package:shopapp/modules/appcubit/appcubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/onBoarddingDataModel.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<BoardingModel> boardingPages = [
    BoardingModel(
      image: 'assets/onboardingimages/trans1.jpg',
      title: 'Title 1',
      body: 'body 1',
    ),
    BoardingModel(
      image: 'assets/onboardingimages/trans2.png',
      title: 'Title 2',
      body: 'body 2',
    ),
    BoardingModel(
      image: 'assets/onboardingimages/trans3.png',
      title: 'Title 3',
      body: 'body 3',
    ),
  ];
  var isLast = false;

  var boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            //skip
            TextButton(
              onPressed:() {
                AppCubit.get(context).doneOnboarding(context);
              },
              child: Text(
                'Skip',
              ),
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                onPageChanged: (int index) {
                  if (index == boardingPages.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  }
                  else
                    setState(() {
                      isLast = false;
                    });
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildOnBoardItem(boardingPages[index]),
                itemCount: boardingPages.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingPages.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.pink,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                     AppCubit.get(context). doneOnboarding(context);
                    }
                    else {
                      boardingController.nextPage(
                        duration: Duration(
                            milliseconds: 700
                        ),
                        curve: Curves.fastOutSlowIn,);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget buildOnBoardItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image(
                image: AssetImage('${model.image}'),
                //fit: BoxFit.fill,
              ),
            ),
          ),

          Text(
            '${model.title}',
            style: TextStyle(
                fontSize: 29
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text('${model.body}',
            style: TextStyle(
                fontSize: 20
            ),
          ),
          SizedBox(
            height: 20,
          ),

        ],
      );

}
