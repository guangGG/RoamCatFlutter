import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roamcat_flutter/view/router.dart';
import 'package:roamcat_flutter/view/widget/no_ripple_scroll_behavior.dart';

class MainTabPage extends StatefulWidget {
  final int index;

  @override
  State<StatefulWidget> createState() {
    return _MainTabPageState(index, PageController(initialPage: index));
  }

  MainTabPage({Key key, this.index});
}

class _MainTabPageState extends State<MainTabPage> {
  final PageController _pageController;
  int _selectedIndex = 0;
  List<Widget> pages = <Widget>[
    Center(child: Text("Home Content")),
    Center(child: Text("Mine Content")),
  ];
  DateTime _lastPressed;

  _MainTabPageState(this._selectedIndex, this._pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RoamCatFlutter"),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<int>> list = [];
              list.add(
                  PopupMenuItem(value: 1, child: Text("View the source code")));
              return list;
            },
            onSelected: (tag) async {
              if (tag == 1) {
                //内置WebView打开url
                Navigator.of(context).pushNamed(
                  RouteName.webPage,
                  arguments: {
                    'url': 'https://github.com/guangGG/RoamCatFlutter'
                  },
                );
              }
            },
          )
        ],
      ),
      //抽屉菜单配置(drawerEdgeDragWidth表示手势拉出的触碰宽度，为0表示无法手势拉出)
      drawer: Drawer(
        semanticLabel: "Drawer",
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Drawer"),
          ),
          body: Center(child: Text("Drawer Content")),
        ),
      ),
      drawerEdgeDragWidth: 0,
      body: Builder(builder: (BuildContext innerContext) {
        //WillPopScope中自处理返回键，onWillPop返回false表示拦截页面返回操作
        return WillPopScope(
          //ViewPager，设置NeverScrollableScrollPhysics可禁止手势滑动
          child: buildNoRippleScrollWidget(PageView.builder(
            itemBuilder: (ctx, index) => pages[index],
            itemCount: pages.length,
            controller: _pageController,
            //physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          )),
          onWillPop: () async {
            //抽屉菜单打开时，先关闭抽屉菜单(bug:手势拉开时菜单打开状态判断不出来)
            var isDrawerOpen = Scaffold.of(innerContext).isDrawerOpen;
            if (isDrawerOpen) {
              return true;
            }
            //非首个tab返回时定位到首个tab
            if (_selectedIndex != 0) {
              _pageController.jumpToPage(0);
              return false; //拦截返回键
            }
            //连续两次点击间隔少于2秒关闭页面
            if (_lastPressed == null ||
                DateTime.now().difference(_lastPressed) >
                    Duration(seconds: 2)) {
              _lastPressed = DateTime.now();
              Fluttertoast.showToast(
                  msg: "Click again to exit the application");
              return false; //拦截返回键
            }
            return true;
          },
        );
      }),
      //BottomNavigationBar设置底部tab样式及逻辑
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _tabImage(0, false),
            activeIcon: _tabImage(0, true),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: _tabImage(1, false),
            activeIcon: _tabImage(1, true),
            title: Text("Mine"),
          ),
        ],
        elevation: 5,
        unselectedItemColor: Color(0xff999999),
        selectedItemColor: Color(0XFF0088FF),
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  Widget _tabImage(int index, bool active) {
    var asset;
    if (index == 0) {
      asset = "assets/images/icon_home.png";
    } else {
      asset = "assets/images/icon_mine.png";
    }
    var color = active ? Color(0XFF0088FF) : Color(0xff999999);
    return Image.asset(
      asset,
      width: 25,
      height: 25,
      color: color,
    );
  }
}
