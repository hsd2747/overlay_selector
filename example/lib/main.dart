import 'package:flutter/material.dart';

import 'package:overlay_selector/overlay_selector.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<OverlayItemData> overlayItemData = List();
  OverlayItemData checkedItemData;

  @override
  void initState() {
    super.initState();

    overlayItemData.add(
      OverlayItemData(
        index: 0,
        id: 'title',
        name: 'Name',
        isAsc: false,
      )
    );
    overlayItemData.add(
      OverlayItemData(
        index: 1,
        id: 'create_datetime',
        name: 'Date',
        isAsc: false,
      )
    );
    overlayItemData.add(
      OverlayItemData(
        index: 2,
        id: 'creator',
        name: 'Writer',
        isAsc: false,
      )
    );
    overlayItemData.add(
      OverlayItemData(
        index: 3,
        id: 'id',
        name: 'Writer id',
        isAsc: false,
      )
    );

    checkedItemData = overlayItemData[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overlay Selector', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50),
          Text('Custom'),
          OverlaySelector(
            childIcon: Icon(Icons.tune, color: Colors.grey[400], size: 24),
            childTextStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
            checkedItemData: checkedItemData,
            overlayItemDatas: overlayItemData,
            onSelectChanged: (selectOverlayData){
              setState(() {
                checkedItemData = selectOverlayData;
                overlayItemData[selectOverlayData.index] = selectOverlayData;
              });
            },
            topViewPadding: MediaQuery.of(context).viewPadding.top,
            backgroundColor: Colors.lime.withOpacity(0.8),
            selectedTextStyle: TextStyle(color: Colors.black, fontSize: 14),
            unselectedTextStyle: TextStyle(color: Colors.black45, fontSize: 12),
            selectedIcon: Icon(Icons.check, size: 24, color: Colors.black),
            padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
            separationValue: 20,
          ),
          SizedBox(height: 50),
          Text('Simple'),
          OverlaySelector(
            childIcon: Icon(Icons.tune, color: Colors.grey[400], size: 24),
            childTextStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
            checkedItemData: checkedItemData,
            overlayItemDatas: overlayItemData,
            onSelectChanged: (selectOverlayData){
              setState(() {
                checkedItemData = selectOverlayData;
                overlayItemData[selectOverlayData.index] = selectOverlayData;
              });
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                'name : ${checkedItemData.name},  asc : ${checkedItemData.isAsc.toString()},  index : ${checkedItemData.index.toString()},  id : ${checkedItemData.id}',
                style: TextStyle(color: Colors.black, fontSize: 16),
                overflow: TextOverflow.clip,
              ),
            )
          )
        ],
      ),
    );
  }
}
