import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CatalogueList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CatalogueListPage();
  }
}
RefreshController _refreshController = RefreshController(initialRefresh: false);
class CatalogueListPage extends State<CatalogueList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("使用list view创建一个目录结构")),
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.black12),
          child: SmartRefresher(
            enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              // footer: ClassicFooter(),
              footer: CustomFooter(
                builder: (BuildContext context, LoadStatus? mode){
                  Widget body ;
                  if(mode==LoadStatus.idle){
                    body =  Text("上拉加载");
                  }
                  else if(mode==LoadStatus.loading){
                    body =  CupertinoActivityIndicator();
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("加载失败！点击重试！");
                  }
                  else if(mode == LoadStatus.canLoading){
                    body = Text("松手,加载更多!");
                  }
                  else{
                    body = Text("没有更多数据了!");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                },
              ),
              controller: _refreshController,
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
                  itemCount: 5,
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
                    return const Divider(
                      height: 10,
                      color: Color(0x00eeeeee),
                    );
                  }),
              Container(
                alignment: Alignment.center,
                child: Text("当前版本v1.1"),
              )
            ],
          )
          ),
        ),
      ),
    );
  }

  void  _onRefresh() async {
     print("SmartRefresher ------- 下拉刷新");
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    print("SmartRefresher ------- 上拉刷新");
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
