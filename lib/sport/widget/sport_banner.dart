import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/sport/model/BannerAndMaqueeModel.dart'
    as BannerModel;

/**
 * 体育的banner
 */
class SportBanner extends StatefulWidget {
  final List<BannerModel.Page>? pages;

  const SportBanner({Key? key, this.pages}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SportBannerState();
}

class _SportBannerState extends State<SportBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: _banner(widget.pages),
      height: 198,
    );
  }

  _banner(List<BannerModel.Page>? pages) {
    int len = pages?.length ?? 0;
    return Swiper(
      itemCount: len == 0 ? 1 : len,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        if (len > 0) {
          BannerModel.Page page = pages![index];
          return _image(page.picMbPath!);
        }
        return _image(
            "https://img1.baidu.com/it/u=4035993836,3066502710&fm=253&fmt=auto&app=120&f=JPEG?w=1195&h=500");
      },
      //自定义指示器
      pagination: const SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(right: 0, bottom: 0),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6)),
    );
  }

  _image(String path) {
    return InkWell(
      onTap: () {
//        print(bannerMo.title);
//        handleBannerClick(bannerMo);
      },
      child: Container(
        padding: EdgeInsets.only(right: 0, bottom: 0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(path, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
