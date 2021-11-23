import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef CustomCardView3ItemClick = void Function();

class CustomCardView3 extends StatefulWidget {
  final CustomCardView3ItemClick? itemClick;
  final List<List<ItemModel>>? list;

  const CustomCardView3({Key? key, this.itemClick, this.list})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomCardView3State();
}

class _CustomCardView3State extends State<CustomCardView3> {
  @override
  Widget build(BuildContext context) {
    var temp = widget.list ??
        [
          [
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
          ],
          [
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
            ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "WiFi电话卡"),
          ]
        ];
    return Container(
      height: 120,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: temp.first.map((e) => _CardViewItem(e)).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: temp.last.map((e) => _CardViewItem(e)).toList(),
          )
        ],
      ),
    );
  }

  Widget _CardViewItem(ItemModel model) {
    return Container(
      child: GestureDetector(
        onTap: widget.itemClick,
        child: Column(
          children: [
            Container(
              child: Image.asset(
                model.imageName,
                width: 20,
                height: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.red),
            ),
            Text(model.title)
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  final String imageName;
  final String title;

  ItemModel({required this.imageName, required this.title});
}
