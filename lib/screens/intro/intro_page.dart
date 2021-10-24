import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:right_to_pride/screens/choose_user_screen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          skipColor: Colors.black,
          doneColor: Colors.black,
          nextColor: Colors.black,
          showDoneButton: true,
          pages: [
            PageViewModel(
              title: 'Right To Pride',
              body: 'Every Gender Matters',
              image: buildImage('assets/intro_images/1.jpg'),
              decoration: getPageDecoration(),
              footer: ButtonWidget(
                text: 'Login',
                onClicked: () => goToHome(context),
              ),
            ),
            PageViewModel(
              title: 'Right To Pride',
              body: 'Every Gender Matters',
              image: Center(child: buildImage('assets/intro_images/2.jpg')),
              decoration: getPageDecoration(),
              footer: ButtonWidget(
                text: 'Login',
                onClicked: () => goToHome(context),
              ),
            ),
            PageViewModel(
              title: 'Right To Pride',
              body: 'Every Gender Matters',
              image: buildImage('assets/intro_images/3.jpg'),
              decoration: getPageDecoration(),
              footer: ButtonWidget(
                text: 'Login',
                onClicked: () => goToHome(context),
              ),
            ),
            PageViewModel(
              title: 'Right To Pride',
              body: 'Every Gender Matters',
              footer: ButtonWidget(
                text: 'Login',
                onClicked: () => goToHome(context),
              ),
              image: buildImage('assets/intro_images/4.jpg'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Done',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              )),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text(
            'Skip',
          ),
          onSkip: () => goToHome(context),
          next: Icon(
            Icons.arrow_forward,
          ),
          dotsDecorator: getDotDecoration(),
          globalBackgroundColor: Colors.white,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ChooseUserScreen()),
      );

  Widget buildImage(String path) => Center(
          child: Image.asset(
        path,
        width: 350,
      ));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD), activeColor: Colors.black,
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        // titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        //  pageColor: Theme.of(context).primaryColor,
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: TextButton(
          onPressed: onClicked,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            primary: Colors.black,
            backgroundColor: Colors.black,
            onSurface: Colors.grey,
          ),
          // shape: StadiumBorder(),
          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
}
