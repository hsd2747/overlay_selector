import 'package:flutter/material.dart';

class OverlaySelector extends StatefulWidget {
  final OverlayItemData checkedItemData;
  final List<OverlayItemData> overlayItemDatas;
  final Function(OverlayItemData) onSelectChanged;
  final Color backgroundColor;
  final double topViewPadding;
  final TextStyle selectedTextStyle;
  final TextStyle unselectedTextStyle;
  final Icon selectedIcon;
  final Icon childIcon;
  final TextStyle childTextStyle;
  final EdgeInsets padding;
  final double separationValue;

  OverlaySelector({this.checkedItemData, this.overlayItemDatas, this.onSelectChanged, this.backgroundColor,
    this.topViewPadding = 0, this.selectedTextStyle, this.unselectedTextStyle, this.selectedIcon,
    this.childIcon, this.childTextStyle, this.padding = const EdgeInsets.fromLTRB(20, 20, 20, 20), this.separationValue = 20});

  @override
  _OverlaySelectorState createState() => _OverlaySelectorState();
}

class _OverlaySelectorState extends State<OverlaySelector> with SingleTickerProviderStateMixin{
  GlobalKey childKey = GlobalKey();

  AnimationController animationController;
  Animation<double> scaleAnimation;

  OverlayEntry overlayEntry;
  
  List<Widget> selectItems = List();
  //Color containerColor = Colors.transparent;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      )
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectItems.clear();
    //selectItems.add(SizedBox(height: 10));
    for (var data in widget.overlayItemDatas){
      selectItems.add(
        OverlaySelectorItem(
          data,
          widget.checkedItemData.index,
          (selectItemData){
            //print('on select overlay item');
            widget.onSelectChanged(selectItemData);
            animationController.reverse().then((_){
              // setState(() {
              //   containerColor = Colors.transparent;
              // });
              overlayEntry.remove();
            });
          },
          selectedTextStyle: widget.selectedTextStyle,
          unselectedTextStyle: widget.unselectedTextStyle,
          selectedIcon: widget.selectedIcon,
          padding: widget.padding,
          separationValue: widget.separationValue,
        )
      );
    }
    selectItems.add(SizedBox(height: widget.separationValue));

    return GestureDetector(
      child: Container(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context2, child){
            return Opacity(
              opacity: 1 - scaleAnimation.value,
              child: Padding(
                padding: widget.padding,
                child: Row(
                  key: childKey,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.childIcon,//Icon(Icons.tune, color: Colors.grey[400], size: 28),
                    SizedBox(width: 5),
                    Text(widget.checkedItemData.name, style: widget.childTextStyle)
                  ],
                )
              )
            );
          } 
        )
      ),
      onTap: (){
        //print('OverlaySelector child widget click');
        Offset childOffset;

        if (childKey != null){
          final RenderBox childRenderBox = childKey.currentContext.findRenderObject();
          
          childOffset = childRenderBox.localToGlobal(Offset.zero);
        }
        animationController.forward();

        overlayEntry = OverlayEntry(
          builder: (context2) => Positioned(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.transparent,
                    ),
                    onTap: (){
                      //print('on select overlay container');
                      animationController.reverse().then((_){
                        // setState(() {
                        //   containerColor = Colors.transparent;
                        // });
                        overlayEntry.remove();
                      });
                    },
                  ),
                  Positioned(
                    // - (widget.checkedItemData.index * 40)
                    top: (childOffset.dy - (widget.checkedItemData.index * (((widget?.selectedIcon?.size ?? 24)) + (widget.separationValue)) + widget.separationValue)) < widget.topViewPadding
                      ? widget.topViewPadding
                      : childOffset.dy - (widget.checkedItemData.index * (((widget?.selectedIcon?.size ?? 24)) + (widget.separationValue)) + widget.separationValue),
                    width: MediaQuery.of(context).size.width,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context3, child){
                        return FadeTransition(
                          opacity: scaleAnimation,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.backgroundColor == null
                                ? Colors.black.withOpacity(0.8)
                                : widget.backgroundColor
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: selectItems
                            )
                          )
                        );
                      },
                    )
                  )
                ],
              )
            )
          )
        );

        // setState(() {
        //   containerColor = Colors.white;
        // });

        Overlay.of(context).insert(overlayEntry);
      },
    );
  }
}

class OverlaySelectorItem extends StatelessWidget {
  final OverlayItemData overlayItemData;
  final int checkedIndex;
  final Function(OverlayItemData) onSelectItem;
  final TextStyle selectedTextStyle;
  final TextStyle unselectedTextStyle;
  final Icon selectedIcon;
  final EdgeInsets padding;
  final double separationValue;

  OverlaySelectorItem(this.overlayItemData, this.checkedIndex, this.onSelectItem, 
    {Key key, this.selectedTextStyle, this.unselectedTextStyle, this.selectedIcon, this.padding, this.separationValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding.left, separationValue, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            overlayItemData.index == checkedIndex
              ? selectedIcon == null
                ? Icon(Icons.check, color: Colors.white, size: 24)
                : selectedIcon
              : selectedIcon == null
                ? Icon(Icons.check, color: Colors.transparent, size: 24)
                : Icon(selectedIcon.icon, color: Colors.transparent, size: selectedIcon.size),
            SizedBox(width: 5),
            Text(
              overlayItemData.index == checkedIndex
              ? overlayItemData.isAsc
                ? overlayItemData.name + ' ↑'
                : overlayItemData.name + ' ↓'
              : overlayItemData.name,
              style: overlayItemData.index == checkedIndex
                ? selectedTextStyle == null
                  ? TextStyle(color: Colors.white, fontSize: 14)
                  : selectedTextStyle
                : unselectedTextStyle == null
                  ? TextStyle(color: Colors.white60, fontSize: 14)
                  : unselectedTextStyle
            )
          ],
        ),
      ),
      onTap: (){
        onSelectItem(
          OverlayItemData(
            id: overlayItemData.id,
            index: overlayItemData.index,
            isAsc: overlayItemData.index == checkedIndex
              ? !overlayItemData.isAsc
              : overlayItemData.isAsc,
            name: overlayItemData.name
          )
        );
      },
    );
  }
}

class OverlayItemData{
  String name;
  String id;
  int index;
  bool isAsc;

  OverlayItemData({this.name, this.id, this.index, this.isAsc});
}