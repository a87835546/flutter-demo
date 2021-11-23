import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardView2 extends StatefulWidget {
  const CustomCardView2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomCardView2State();
}

class _CustomCardView2State extends State<CustomCardView2> {
  double _itemWidth = 0;

  @override
  Widget build(BuildContext context) {
    _itemWidth = (MediaQuery.of(context).size.width - 10) / 3;
    return Container(
      height: 300,
      width: _itemWidth * 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),

      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Column(
          children: [
            _createItemView(),
            _createItemView(),
            _createItemView(),
          ],
        ),
      ),
    );
  }

  Widget _createItemView() {
    return Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent,Colors.greenAccent],
        )
      ),
      child: Row(
        children: [
          _createFirstView(),
          _createView(),
          _createView(),
        ],
      ),
    );
  }

  Widget _createFirstView() {
    return Container(
      height: 98,
      width: _itemWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "imgs/images/banner@3x.png",
              ),
              fit: BoxFit.fill),
          color: Colors.transparent),
      child: Stack(
        children: [
          Positioned(
              left: _itemWidth / 2 - 20,
              top: 10,
              child: Container(
                alignment: AlignmentDirectional.center,
                child: Text("酒店",style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20
                ),),
              )),
        ],
      ),
    );
  }

  Widget _createView() {
    return Container(
      width: _itemWidth,
      height: 96,
      decoration: BoxDecoration(
        border:Border.all(width: 1,color: Colors.white)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createCellBtn(),
          Padding(padding: EdgeInsets.only(top: 1),child: Container(color: Colors.white,height: 1,),),
          _createCellBtn()
        ],
      ),
    );
  }

  Widget _createCellBtn(){
    return Container(
      alignment: AlignmentDirectional.center,
      color: Colors.greenAccent,
      height: 46,
      child: Text("特价酒店",style: TextStyle(
        color: Colors.white,
        fontSize: 17
      ),),
    );
  }
}

class CustomCardView2ItemModel {
  final String imageName;
  final String title;
  final bool isFirst;

  CustomCardView2ItemModel(
      {required this.imageName, required this.title, required this.isFirst});
}
