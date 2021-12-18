import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DrawerPage();
  }
}

class DrawerPage extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3),
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height,
          color: Color(0xff2c2c2e),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  },icon: Icon(Icons.close),iconSize: 20,color: Colors.white,),
                ),
                const SliverToBoxAdapter(
                  child: Text(
                    "Scaffold 上的endDrawer 右侧抽屉盒子Drawer的使用，和 CustomScrollView 下得SliverToBoxAdapter 使用",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 4,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
                            print("click cell index:$index");
                          },
                          child: Container(
                            padding:const EdgeInsets.only(left: 10,right: 10),
                            alignment: Alignment.centerLeft,
                            color: Colors.red,
                            height: 40,
                            child: Text("row :$index"),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 10,
                          color: Colors.grey,
                        );
                      },
                      itemCount: 10),
                ),
                const SliverToBoxAdapter(
                  child: Text("1232312"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}