import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp/bean/BannerBean.dart';
import 'package:flutterapp/bean/WebBean.dart';

class HomeBanner extends StatelessWidget {

  HomeBanner({Key key,List<DataListBean> data,}):banner=data,super(key:key);

   final List<DataListBean> banner;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Swiper(
        onTap: (index){
          Navigator.of(context).pushNamed("/webview",arguments: new WebBean(banner[index].title,banner[index].url));
        },
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            banner[index].imagePath,
            fit: BoxFit.fill,
          );
        },
        pagination: new SwiperPagination(),
        itemCount: banner.length,
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: true,
        controller: new SwiperController(),
      ),
      height: ScreenUtil.getInstance().setHeight(600),
    );
  }
}
