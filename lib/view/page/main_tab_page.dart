import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roamcat_flutter/data/bloc/locale_bloc.dart';
import 'package:roamcat_flutter/data/bloc/theme_bloc.dart';
import 'package:roamcat_flutter/data/helper/app_constants.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
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

  ThemeBloc _themeBloc;
  LocaleBloc _localeBloc;

  _MainTabPageState(this._selectedIndex, this._pageController);

  @override
  void initState() {
    super.initState();
    _themeBloc = context.bloc<ThemeBloc>();
    _localeBloc = context.bloc<LocaleBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((_selectedIndex == 1)
            ? S.of(context).hotTabTitle
            : S.of(context).mainPageTitle),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<int>> list = [];
              list.add(
                  PopupMenuItem(value: 1, child: Text("View the source code")));
              list.add(PopupMenuItem(value: 2, child: Text("Switch DarkMode")));
              list.add(
                  PopupMenuItem(value: 3, child: Text("Switch ThemeColor")));
              list.add(PopupMenuItem(value: 4, child: Text("Switch Font")));
              list.add(PopupMenuItem(value: 5, child: Text("Switch Locale")));
              list.add(PopupMenuItem(value: 6, child: Text("Reset Theme")));
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
              } else if (tag == 2) {
                _themeBloc?.add(DarkModeThemeEvent(
                    userDarkMode: !AppDataHelper.userDarkMode));
              } else if (tag == 3) {
                _themeBloc?.add(ColorThemeEvent(
                    themeColorIndex: AppDataHelper.nextIndex(
                        AppConstants.colorValueList,
                        AppDataHelper.themeColorIndex)));
              } else if (tag == 4) {
                _themeBloc?.add(FontThemeEvent(
                    fontIndex: AppDataHelper.nextIndex(
                        AppConstants.fontValueList, AppDataHelper.fontIndex)));
              } else if (tag == 5) {
                _localeBloc?.add(DefaultLocaleEvent(
                    localeValueIndex: AppDataHelper.nextIndex(
                        AppConstants.localeValueList,
                        AppDataHelper.localeValueIndex)));
              } else if (tag == 6) {
                _themeBloc?.add(DefaultThemeEvent(
                    userDarkMode: false, themeColorIndex: 0, fontIndex: 0));
                _localeBloc?.add(DefaultLocaleEvent(localeValueIndex: 0));
              }
            },
          )
        ],
      ),
      //抽屉菜单配置(drawerEdgeDragWidth表示手势拉出的触碰宽度，为0表示无法手势拉出)
      drawer: Drawer(
        semanticLabel: S.of(context).appName,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(S.of(context).appName),
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
              Fluttertoast.showToast(msg: S.of(context).reClickExit);
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
            title: Text(S.of(context).mainPageName),
          ),
          BottomNavigationBarItem(
            icon: _tabImage(1, false),
            activeIcon: _tabImage(1, true),
            title: Text(S.of(context).hotTabName),
          ),
        ],
        elevation: 5,
        unselectedItemColor: Color(0xff999999),
        selectedItemColor: Theme.of(context).accentColor,
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
      asset = "assets/images/icon_face.png";
    }
    var color = active ? Theme.of(context).accentColor : Color(0xff999999);
    return Image.asset(
      asset,
      width: 25,
      height: 25,
      color: color,
    );
  }
}
