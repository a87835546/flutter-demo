import 'package:flutter/material.dart';

class CatalogueList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CatalogueListPage();
  }
}

class CatalogueListPage extends State<CatalogueList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("使用list view创建一个目录结构")),
      body: Center(
        child: Container(
            decoration: BoxDecoration(color: Colors.black12),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  child: PhysicalModel(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    clipBehavior: Clip.antiAlias,
                    child: PageView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.blue),
                            child: Text("page:$index"),
                          );
                        }),
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return IntrinsicHeight(
                          child: GestureDetector(
                        onTap: () {
                          print("cell index :$index");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              color: Colors.blue,
                              width: 44.0,
                              height: 50,
                              child: Icon(Icons.share),
                            ),
                            Expanded(
                              child: Container(
                                  color: Colors.red,
                                  height: 50.0,
                                  alignment: Alignment.centerLeft,
                                  child: Text("分享app row index:$index")),
                            ),
                            // FractionallySizedBox(
                            //   child:
                            // ),
                            Container(
                              color: Colors.yellow,
                              width: 44.0,
                              height: 50,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 10,
                        color: Color(0xeeeeee),
                      );
                    }),
                Container(
                  alignment: Alignment.center,
                  child: Text("当前版本v1.1"),
                )
              ],
            )),
      ),
    );
  }
}
