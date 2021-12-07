
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef CustomCardViewItemClick = void Function();

/// 单行卡片展示，上面图片下面文字
class CustomCardView extends StatelessWidget {
  final List<ItemModel>? list;
  final CustomCardViewItemClick? clickItem;

  const CustomCardView({Key? key, this.list, this.clickItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var temp = list ??
        [
          ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "周边游"),
          ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "周边游"),
          ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "周边游"),
          ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "周边游"),
          ItemModel(imageName: "imgs/images/logo-SDY@3x.png", title: "周边游"),
        ];
    return SizedBox(
      height: 70,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: temp.map((e) => _CardViewItem(e)).toList()),
    );
  }

  Widget _CardViewItem(ItemModel model) {
    return Container(
      child: GestureDetector(
        onTap: clickItem,
        child: Column(
          children: [
            Container(
              child: Image.asset(
                model.imageName,
                width: 30,
                height: 30,
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
