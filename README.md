# overlay_selector

Widget that allows you to select items to sort using overlays.

## Demo

<img src="https://raw.githubusercontent.com/hsd2747/overlay_selector/master/doc/overlay_play.gif" width="50%" height="50%">

## Usage

> Simple
```dart
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
  )
```

> Custom
```dart
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
  )
```
