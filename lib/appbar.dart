import 'package:flutter/material.dart';
import 'onlineDB.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // here the desired height
          child: _AppBar() // put the desired widgets here,
      ),
    );
  }

  Widget _AppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Column(children: [
        Container(
          //container for notif bar, make this change colors
          height: 24,
          color: Colors.white,
        ),
        Container(
          height: 80,
          alignment: Alignment.center,
          child: Stack(
            //alignment:new Alignment(x, y)
            children: <Widget>[
              new Align(
                alignment: Alignment(-.60, 0),
                //
                //USER INFORMATION
                //
                child: getUserName(),
              ),
              Align(
                  alignment: Alignment(-.96, .09),
                  //
                  //LEVEL INFO STUFF
                  //
                  child: Container(
                    //  color: Colors.white,
                      color: Color(0xFFCDD1C4),
                      height: 30,
                      width: 26,
                      child: Align(
                        alignment: Alignment.center,
                        child: getUserLevel(),
                      ))),
              new Align(
                  alignment: Alignment(.40, -.49),
                  //
                  //PREMIUM CURRENCY
                  //
                  child: getUserEmeralis()),
              new Align(
                alignment: Alignment(.40, .50),
                //
                //GOLD
                //
                child: getUserGold(),
              ),
            ],
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/gui/appbar.png"),
                fit: BoxFit.fill,
              )),
        ),
      ]),
    );
  }
}