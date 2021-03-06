import 'package:flutter/material.dart';
import 'package:jfinalproject/Unit.dart';

class UnitInfoCard extends StatelessWidget {
  String value;
  List<Unit> units;

  /// Here is your constructor
  UnitInfoCard(this.value, this.units);

  @override
  Widget build(BuildContext context) {
    return unitInfoCard(this.value, this.units); //Error, How do i pass the arguments?
  }

  Widget unitInfoCard(String value, List<Unit> unitlist){
    Unit unitBeingViewed;
    String unitNameTemp = value.substring(value.indexOf("units/",0)+6,value.indexOf(".",0));
    //print(unitNameTemp);
    String firstLetter = unitNameTemp.substring(0,1).toUpperCase();
    String unitName = firstLetter + unitNameTemp.substring(1, unitNameTemp.length);
    for(final u in unitlist){
      if (u.name == unitNameTemp){
        unitBeingViewed = u;
      }
    }
    int unitLVL = 1;
    int unitHP = (int.parse(unitBeingViewed.HP_b)*(unitLVL * int.parse(unitBeingViewed.HP_g)));
    int unitATK = (int.parse(unitBeingViewed.ATK_b)*(unitLVL * int.parse(unitBeingViewed.ATK_g)));
    int unitDEF = (int.parse(unitBeingViewed.DEF_b)*(unitLVL * int.parse(unitBeingViewed.DEF_g)));
    int unitSPD = (int.parse(unitBeingViewed.SPD_b)*(unitLVL * int.parse(unitBeingViewed.SPD_g)));
    return Card(
      //color: Colors.grey,
      elevation: 20,
      margin: EdgeInsets.fromLTRB(70, 220, 70, 130),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:
      Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    child:RichText(
                      text: TextSpan(
                        text: unitName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black
                        ),
                      ),
                    ) ,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    generateStars(5)
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 125,
                width: 148,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(value),
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter,
                    )
                ),
                margin: EdgeInsets.all(10),
                child: RichText(
                    text: TextSpan(
                      text: "Lv. " + unitLVL.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black
                      ),
                    )
                ),
              ),
              Container(
                height: 147,
                width: 0.5,
                color: Colors.black,
                margin: const EdgeInsets.only(right: 10.0),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(
                                    text: "HP: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                    text: "ATK: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                    text: "DEF: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                    text: "SPD: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(
                                    text: unitHP.toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                    text: unitATK.toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                    text: unitDEF.toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                              RichText(
                                  text: TextSpan(
                                    text: unitSPD.toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black
                                    ),
                                  )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: Column(
                      children: <Widget>[
                        Image.asset("assets/gui/" + unitBeingViewed.elem + ".png"),
                        Image.asset("assets/gui/" + unitBeingViewed.wep + ".png"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child:
                Row(
                  children: <Widget>[
                    Image.asset("assets/skillIcons/" + unitBeingViewed.sOneName +".png"),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5),
                          child:RichText(
                            text: TextSpan(
                              text: unitBeingViewed.sOneName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child:RichText(
                            text: TextSpan(
                              text: unitBeingViewed.sOneDesc,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black
                              ),
                            ),
                          ) ,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 2,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child:
                Row(
                  children: <Widget>[
                    Image.asset("assets/skillIcons/" + unitBeingViewed.sTwoName +".png"),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5),
                          child:RichText(
                            text: TextSpan(
                              text: unitBeingViewed.sTwoName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.black
                              ),
                            ),
                          ) ,
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child:RichText(
                            text: TextSpan(
                              text: unitBeingViewed.sTwoDesc,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black
                              ),
                            ),
                          ) ,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 2,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text("Enhance"),
                onPressed: (){
                  //enhance dialog box method call here
                  //_deleteTeam();
                },
              ),
              RaisedButton(
                child: Text("Evolve"),
                onPressed: (){
                  //evolve dialog box method call here
                  //_delete();
                },
              )
            ],
          )
        ],
      ),
    );
  }
  Widget generateStars(int starCount){
    return Container(
      width: 150,
      height: 10,
      child: Center(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.fromLTRB(2,0,2,0),
            scrollDirection: Axis.horizontal,
            itemExtent: 20.0,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                  child: Image.asset("assets/gui/star.png")
              );
            },
            itemCount: starCount,
          )
      ),
    );
  }
}