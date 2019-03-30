import 'package:flutter/material.dart';
import 'package:jfinalproject/database_helper.dart';
import 'package:jfinalproject/TeamStore.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:jfinalproject/Unit.dart';
final dbHelper = DatabaseHelper.instance;
final teamHelper = TeamStore.instance;
class TeamScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => teamScreenState(this,[]);
}
class teamScreenState extends State<TeamScreenWidget>{
  List<String> unitPool=[];
  List<String> unitList = [];
  TeamScreenWidget teamScreenWidget;
  teamScreenState(this.teamScreenWidget, unitList);
  bool isLoaded = false;
  @override
  void initState(){
    super.initState();
    unitList = [];
    _query();
    _insert();
    loadUnit();
    getTeam();
  }
  final int unitCountInJson = 3;
  List<String> tempPool=[];
  List<Unit> units = new List();
  bool slot1Full = false;
  bool slot2Full = false;
  bool slot3Full = false;
  List<String> inTeam = ["0"," "," "," "];
  List<String> tempInTeam = [];
  Widget build(BuildContext context) {
    Widget team = new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0,8,0,0),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16,4,0,4),
                  child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children:<TextSpan>[
                            TextSpan(
                                text: "Team:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )
                            ),
                          ]
                      )
                  ),
                ),
              ]
          ),
          Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Color(0xFF5C80BC),
                    width: 135.0,
                    height:150.0,
                    child: DragTarget(builder: (context, List<String> candidateData, rejectedData) {
                      return !slot1Full ? Container() :
                        Container(
                          child:GestureDetector(
                          onDoubleTap: (){
                            showDialog(
                              context: context,
                              child: UnitInfoCard(inTeam[1])
                            );
                          },
                          child: Image.asset(inTeam[1]),
                          )
                        );
                      },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        _update(inTeam[1], inTeam[2], inTeam[3]);
                        setState(() {
                          slot1Full = true;
                          inTeam[1] = data;
                          print(inTeam[1] + " " + inTeam[2] + " " + inTeam[3]);

                        });
                      },
                    )
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Color(0xFF5C80BC),
                    width: 135.0,
                    height:150.0,
                    child: DragTarget(builder: (context, List<String> candidateData, rejectedData) {
                      return !slot1Full ? Container() :
                      Container(
                          child:GestureDetector(
                            onDoubleTap: (){
                              showDialog(
                                  context: context,
                                  child: UnitInfoCard(inTeam[2])
                              );
                            },
                            child: Image.asset(inTeam[2]),
                          )
                      );
                    },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        setState(() {
                          slot2Full = true;
                          inTeam[2] = data;
                          print(inTeam[1] + " " + inTeam[2] + " " + inTeam[3]);
                        });
                      },
                    )
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Color(0xFF5C80BC),
                    width: 135.0,
                    height:150.0,
                    child: DragTarget(builder: (context, List<String> candidateData, rejectedData) {
                      return !slot1Full ? Container() :
                      Container(
                          child:GestureDetector(
                            onDoubleTap: (){
                              showDialog(
                                  context: context,
                                  child: UnitInfoCard(inTeam[3])
                              );
                            },
                            child: Image.asset(inTeam[3]),
                          )
                      );
                    },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        setState(() {
                          slot3Full = true;
                          inTeam[3] = data;
                          print(inTeam[1] + " " + inTeam[2] + " " + inTeam[3]);
                        });
                      },
                    )
                ),
              ]
          ),
          Divider(
            height: 12,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8,8,0,0),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children:<TextSpan>[
                          TextSpan(
                              text: 'Your Unit Pool:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )
                          ),
                        ]
                    )
                ),
              ]
          ),
          Divider(
            height: 12,
            color: Colors.white,
          ),
        ]
    );

    Widget gridSection = new Expanded(
      flex: 1,
      child: new GridView.count(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: _generateGridItems().map((String value) {
            return _displayGridItem(value, context);
          }).toList()),
    );

    Widget body = new Container(
        height: 650,
        color: Color(0xFF4B3F72),
        child: new Column(
          // This makes each child fill the full width of the screen
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            team,
            gridSection,
          ],
        )
    );

    return new Scaffold(
      body: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: body,
      ),
    );
  }

  Widget _displayGridItem(String value, BuildContext context) {
    return new GestureDetector(
        onDoubleTap: (){
          showDialog(
              context: context,
              child: UnitInfoCard(value)
          );
        },
        child: LongPressDraggable<String>(
            feedback: Image.asset(value),
            child: unitListCard(value),
            childWhenDragging: unitListCard(value),
            data:value
        )
    );
  }
  Card unitListCard(String value){
    return Card (
      margin: new EdgeInsets.all(5.0),
      color: Color(0xFF5C80BC),
      child: new Image.asset(value),
      elevation: 5,
    );
  }
  Future<String> _loadUnitFile() async {
    return await rootBundle.loadString('assets/info/units.json');
  }
  Future loadUnit() async {
    String jsonString = await _loadUnitFile();
    final jsonResponse = json.decode(jsonString);
    for(int i = 0; i < unitCountInJson; i++){
      Unit unit = new Unit.fromJson(jsonResponse[i]);
      units.add(unit);
      print(unit.name + " added");
    }
    return units;
  }
  Widget UnitInfoCard(String value){
    Unit unitBeingViewed = units[0];
    String unitNameTemp = value.substring(value.indexOf("/",0)+1,value.indexOf(".",0));
    String firstLetter = unitNameTemp.substring(0,1).toUpperCase();
    String unitName = firstLetter + unitNameTemp.substring(1, unitNameTemp.length);
    for(final u in units){
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
                  _deleteTeam();
                },
              ),
              RaisedButton(
                child: Text("Evolve"),
                onPressed: (){
                  //evolve dialog box method call here
                  _delete();
                },
              )
            ],
          )
        ],
      ),
    );
  }
// Note: Placeholder method to generate grid data
  List<String> _generateGridItems() {
    List<String> gridItems = new List<String>();
    if(unitList.length == 0) {
      _query();
      //refreshList();
    }
    for (int i = 0; i < unitList.length/2; i++) {
      String toAdd = unitList[i].substring(unitList[i].indexOf("assets/",0),unitList[i].length-1);
      gridItems.add(toAdd);
    }
    return gridItems;
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
  void refreshList() async{
    setState(() {
      unitList = unitList;
    });
  }
  void _query() async {
    unitList = [];
    final allRows = await dbHelper.queryAllRows();
    print('querying all rows');
    allRows.forEach((row) => {
        unitList.add(row.toString())
    });
    setState(() {
      unitList = unitList;
    });
  }
  void getTeam() async {
    final allRows = await teamHelper.queryAllRows();
    print('querying Team');
    allRows.forEach((row) => {
        tempInTeam.add(row.toString()),
        print(tempInTeam),
        //print(row)
    });
    tempToReal();
    setState(() {
      inTeam = inTeam;
      if(inTeam[1] != " "){
       slot1Full = true;
      }
      if(inTeam[2] != " "){
        slot2Full = true;
      }
      if(inTeam[3] != " "){
        slot3Full = true;
      }
      print(inTeam);
    });
  }
  void tempToReal(){
    inTeam[0] = tempInTeam[tempInTeam.length].substring(tempInTeam[tempInTeam.length].indexOf("teamID: ",7),tempInTeam[tempInTeam.length].indexOf(", slot1:",0));
    inTeam[1] = tempInTeam[tempInTeam.length].substring(tempInTeam[tempInTeam.length].indexOf("slot1: ",6),tempInTeam[tempInTeam.length].indexOf(", slot2:",0));
    inTeam[2] = tempInTeam[tempInTeam.length].substring(tempInTeam[tempInTeam.length].indexOf("slot2: ",6),tempInTeam[tempInTeam.length].indexOf(", slot3:",0));
    inTeam[3] = tempInTeam[tempInTeam.length].substring(tempInTeam[tempInTeam.length].indexOf("slot3: ",6),tempInTeam[tempInTeam.length].indexOf("}",0));
  }
  void _delete() async {
    final id = await dbHelper.queryRowCount();

    for(int i = 0; i < unitList.length; i ++){
      final rowsDeleted = await dbHelper.delete(id);
      print('deleted $rowsDeleted row(s): row $id');
    }
  }
  void _deleteTeam() async {
    final id = await teamHelper.queryRowCount();

    for(int i = 0; i < unitList.length; i ++){
      final rowsDeleted = await teamHelper.delete(id);
      print('deleted $rowsDeleted row(s): row $id');
    }
  }
  void _update(String slot1, String slot2, String slot3) async {
    // row to update
    Map<String, dynamic> row = {
      TeamStore.Id : 0,
      TeamStore.columnSlot1 : slot1,
      TeamStore.columnSlot2 : slot2,
      TeamStore.columnSlot3 : slot3,
    };
    final rowsAffected = await teamHelper.update(row);
    print('updated $rowsAffected row(s)');
  }
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      TeamStore.columnSlot1 : "1",
      TeamStore.columnSlot2 : "2",
      TeamStore.columnSlot3 : "3",
    };
    final id = await teamHelper.insert(row);
    print('inserted row id: $id');
  }
  /*void _comparitiveQuery() async {
    final id =  await dbHelper.queryRowCount();
    if(unitPool != [] || unitPool != null) {
      if (unitPool != tempPool)
        unitPool = tempPool;
    }
  }*/

}
