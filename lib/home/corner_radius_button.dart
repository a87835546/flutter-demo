import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/custom_widget/border_radius_button.dart';
import 'package:flutter_demo/custom_widget/info_button.dart';
import 'package:flutter_demo/utils/screen_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CornerRadiusButton extends StatefulWidget {
  const CornerRadiusButton({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CornerRadiusButtonState();
}

class _CornerRadiusButtonState extends State<CornerRadiusButton> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _insertOverlay(context));
  }

  @override
  void dispose() {
    // Overlay.of(context)!.dispose();
    // Overlay.of(context)!.rearrange(newE);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Offset _offset = Offset.zero;

    return Scaffold(
        appBar: AppBar(
          title: const Text("自定义button 带圆角"),
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 10)),
            ClipRRect(
              // borderRadius: const BorderRadius.all(Radius.circular(12)),
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                width: 128,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    border:
                        Border.all(width: 1, color: const Color(0xffD3C294)),
                    //   border: Border.all(width: 1, color: Colors.yellowAccent),
                    color: Colors.transparent),
                child: Row(
                  children: [
                    Container(
                      width: 62,
                      height: 22,
                      child: GestureDetector(
                        onTap: () {
                          // showToast("提款");
                        },
                        child: Container(
                          width: 62,
                          alignment: Alignment.center,
                          child: Text("提款"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 62,
                      height: 22,
                      child: GestureDetector(
                        onTap: () {
                          // showToast("充值");
                        },
                        child: Container(
                          width: 62,
                          alignment: Alignment.center,
                          child: Text("充值"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              width: 128,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(width: 1, color: const Color(0xffD3C294)),
                  //   border: Border.all(width: 1, color: Colors.yellowAccent),
                  color: Colors.transparent),
              child: Row(
                children: [
                  SizedBox(
                    width: 63,
                    height: 22,
                    child: GestureDetector(
                      onTap: () {
                        // showToast("提款");
                      },
                      child: Container(
                        width: 62,
                        alignment: Alignment.center,
                        child: const Text(
                          "提款",
                          style: TextStyle(
                            color: Color(0xffD0C3A6),
                            backgroundColor: Colors.transparent,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 63,
                    height: 22,
                    child: GestureDetector(
                      onTap: () {
                        // showToast("充值");
                      },
                      child: Container(
                        width: 62,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                            color: Color(0xffD0C3A6)),
                        child: const Text(
                          "充值",
                          style: TextStyle(
                            color: Color(0xff3a3a3a),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            _createMyWalletInfo(),
            // Positioned(
            //   left: _offset.dx,
            //   top: _offset.dy,
            //
            //   child: GestureDetector(
            //     onPanUpdate: (d) {
            //       print("${d}");
            //       setState(() => _offset += Offset(d.delta.dx, d.delta.dy));
            //
            //     },
            //     child: FloatingActionButton(
            //       onPressed: () {},
            //       backgroundColor: Colors.orange,
            //       child: Icon(Icons.add),
            //     ),
            //   ),
            // ),
            BorderRadiusButton(
              title: Text("测试"),
              height: 20,
              width: 60,
              click: () {
                print("click test button");
              },
            ),
          ],
        ));
  }

  Widget _createMyWalletInfo() {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        verticalDirection: VerticalDirection.up,
        children: [
          InfoButton(
            title: const Text(
              "我的钱包",
              style: TextStyle(
                  color: Color(0xffC1C2C4),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            iconName: "imgs/images/icon-Refresh@3x.png",
            width: 80,
            clickBtn: () async {
              Fluttertoast.showToast(msg: "1231231");
            },
          ),
          InfoButton(
            title: const Text(
              "￥99999.99",
              style: TextStyle(
                  color: Color(0xffC1C2C4),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            iconName: "imgs/images/icon-Refresh@3x.png",
            clickBtn: () async {
              Fluttertoast.showToast(msg: "1231231");
            },
          ),
          Container(
            width: 128,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(width: 1, color: const Color(0xffD3C294)),
                color: Colors.transparent),
            child: Row(
              children: [
                SizedBox(
                  width: 63,
                  height: 22,
                  child: GestureDetector(
                    onTap: () {
                      // showToast("提款");
                    },
                    child: Container(
                      width: 62,
                      alignment: Alignment.center,
                      child: const Text(
                        "提款",
                        style: TextStyle(
                          color: Color(0xffD0C3A6),
                          backgroundColor: Colors.transparent,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 63,
                  height: 22,
                  child: GestureDetector(
                    onTap: () {
                      // showToast("充值");
                    },
                    child: Container(
                      width: 62,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)),
                          color: Color(0xffD0C3A6)),
                      child: const Text(
                        "充值",
                        style: TextStyle(
                          color: Color(0xff3a3a3a),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _insertOverlay(BuildContext context) {
    return Overlay.of(context)!.insert(
      OverlayEntry(builder: (context) {
        final size = MediaQuery.of(context).size;
        print("_insertOverlay:${size.width}");
        return Positioned(
          width: 56,
          height: 56,
          top: size.height / 2,
          left: size.width / 2,
          child: Material(
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                print("1231231231312");
              },
              child: Container(
                height: 100,
                width: 100,
                decoration:const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.redAccent),
                child: Text("1231231231"),
              ),
            ),
          ),
        );
      }),
    );
  }
}
