// import 'package:flutter/material.dart';
// import 'package:nextbus_driver/pages/homePage.dart';
// import 'package:nextbus_driver/pages/profilePage.dart';
// import 'package:nextbus_driver/pages/routeDetailsAddPage.dart';
// import 'package:nextbus_driver/pages/startJourneyPage.dart';
// import 'package:nextbus_driver/pages/startLocation.dart';
//
// class NavBar extends StatefulWidget {
//
//
//   @override
//   _NavBarState createState() => _NavBarState();
// }
//
// class _NavBarState extends State<NavBar> {
//   int currentTab = 0;
//
//   final List<Widget> screens =[
//     StartJourney(),
//     ProfilePage(),
//     RouteDetailsAdd(),
//     HomePage(),
//     StartLocationPage(),
//
//   ];
//
//   final PageStorageBucket bucket = PageStorageBucket();
//
//   Widget currentScreen = HomePage();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageStorage(
//         child: currentScreen,
//         bucket: bucket,
//           ),
//
//      floatingActionButton: FloatingActionButton(
//       child: Icon(Icons.add),
//       onPressed: () {},
//      ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // bottomNavigationBar: BottomAppBar(
//       //   shape: CircularNotchedRectangle(),
//       //   notchMargin: 10,
//       //   child: Container(
//       //     height: 60,
//       //   ),
//       //
//       // ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../colors.dart';

class NavBarHome extends StatefulWidget {
  const NavBarHome({super.key});

  @override
  State<NavBarHome> createState() => _NavBarHomeState();
}

class _NavBarHomeState extends State<NavBarHome> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                backgroundColor: AppColor.iconColor,
                elevation: 0.1,
                onPressed: () {},
                child: const Icon(Icons.location_on)),
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: currentIndex == 0
                        ? AppColor.iconColor
                        : Colors.grey.shade400,
                  ),
                  onPressed: () {
                    setBottomBarIndex(0);
                  },
                  splashColor: Colors.white,
                ),
                Container(
                  width: size.width * 0.20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.person_2_rounded,
                      color: currentIndex == 1
                          ? AppColor.iconColor
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(1);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
