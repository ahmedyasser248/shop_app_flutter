import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_screen.dart';

class BoardingModel
{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body
});

}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding =[
    BoardingModel(image: 'assets/images/onboard_1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Title',),
    BoardingModel(image: 'assets/images/onboard_1.jpg',
        title: "On Board 2 Title",
        body: 'On Board 2 Body'),
    BoardingModel(image: "assets/images/onboard_1.jpg",
        title: 'On Board 3 Title',
        body: 'On Board 3 Body')

  ];
  void submit(){
    CacheHelper.saveData(key: 'onBoarding',value: true).then((value){
        if(value){
          navigateAndFinish(context, ShopLoginScreen());
        }
    }).catchError((onError){
      print(onError);
    });
  }

  var boardController = PageController();
  bool isLast =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: [
          defaultTextButton(function:submit,
              text:'skip'

          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (int index){
                    if(index == boarding.length-1){
                      setState(() {
                        isLast = true;
                      });
                    }else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                  physics:BouncingScrollPhysics() ,
                  controller: boardController,
                  itemBuilder: (context,index)=> buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor:  Colors.grey,
                    dotHeight:  10,
                    expansionFactor: 4,
                    spacing: 5.0,
                    dotWidth: 10,
                  ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                    submit();
                  }else{
                    boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }

                },
                  child: Icon(
                    Icons.arrow_forward_ios
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>Column (
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child:
          Image(
              image: AssetImage('${model.image}')
          )
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold
        ),
      )

    ],
  );
}