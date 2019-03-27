import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

import 'header_bar.dart';
import 'email_donations_page.dart';

const SIUERed = const Color(0xFFe41c24);
class PageHolder extends StatefulWidget{
  @override
  State createState() => new __PageHolder();
}

class __PageHolder extends State<PageHolder>{
  PageController controller;

  @override
  void initState(){
    super.initState();
    controller = PageController();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: headerBar(),
      body: new Container(
        color: Colors.white,
        child: Container(
          child: PageIndicatorContainer(
            pageView: PageView(
              children: <Widget>[
                EmailAndDonations(),

              ],
              controller: controller,
            ),
            align: IndicatorAlign.bottom,
            length: 4,
            indicatorSpace: 10.0,
            indicatorColor: Colors.grey,
            indicatorSelectorColor: Colors.black,
          ),
        ),
      ),
    );
  }
}