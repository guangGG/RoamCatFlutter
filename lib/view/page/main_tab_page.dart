import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roamcat_flutter/data/bloc/locale_bloc.dart';
import 'package:roamcat_flutter/data/bloc/theme_bloc.dart';
import 'package:roamcat_flutter/data/helper/app_constants.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/view/page/main_tab_home.dart';
import 'package:roamcat_flutter/view/page/main_tab_hot_action.dart';
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
    Center(child: MainTabHome()),
    Center(child: MainTabHotAction()),
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
                  PopupMenuItem(value: 1, child: Text(S.of(context).exitApp)));
              return list;
            },
            onSelected: (tag) async {
              if (tag == 1) {
                SystemNavigator.pop(animated: true);
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
          body: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return BlocBuilder<LocaleBloc, LocaleState>(
                builder: (context, localeState) {
                  return _buildDrawerContent(context, themeState, localeState);
                },
              );
            },
          ),
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

  Widget _buildDrawerContent(
      BuildContext context, ThemeState themeState, LocaleState localeState) {
    return buildNoRippleScrollWidget(ListView(
      children: <Widget>[
        Container(height: 15),
        Image.asset(
          "assets/images/icon_logo.png",
          width: 150,
          height: 150,
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 20),
          child: Center(
            child: Text(
              S.of(context).drawerMsg,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        ListTile(
          title: Text(S.of(context).blackTheme),
          trailing: Switch(
            activeColor: Theme.of(context).accentColor,
            value: themeState.userDarkMode,
            onChanged: (b) {
              _themeBloc?.add(DarkModeThemeEvent(userDarkMode: b));
            },
          ),
        ),
        ListTile(
          title: Text(S.of(context).switchThemeColor),
          subtitle: Container(
            margin: EdgeInsets.only(top: 10),
            child: GridView.builder(
              //shrinkWrap为true表示适配子Widget的尺寸
              shrinkWrap: true,
              //设置primary=false或设置NeverScrollableScrollPhysics，表示不处理当前View的Scroll事件
              primary: false,
              //physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
              itemCount: AppConstants.colorValueList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(color: AppConstants.colorValueList[index]),
                  onTap: () {
                    _themeBloc?.add(ColorThemeEvent(themeColorIndex: index));
                  },
                );
              },
            ),
          ),
        ),
        ListTile(
          title: Text(S.of(context).switchFont),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppDataHelper.getFontName(context, themeState.fontIndex),
                  style: TextStyle(fontSize: 12)),
              Container(width: 5),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          onTap: () {
            _themeBloc?.add(FontThemeEvent(
                fontIndex: AppDataHelper.nextIndex(
                    AppConstants.fontValueList, AppDataHelper.fontIndex)));
          },
        ),
        ListTile(
          title: Text(S.of(context).switchLanguage),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  AppDataHelper.getLanguageName(
                      context, localeState.localeValue),
                  style: TextStyle(fontSize: 12)),
              Container(width: 5),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          onTap: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return new SimpleDialog(
                  title: new Text(S.of(context).switchLanguage),
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: AppConstants.localeValueList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(AppDataHelper.getLanguageName(
                              context, AppConstants.localeValueList[index])),
                          trailing: (localeState.localeValue ==
                                  AppConstants.localeValueList[index])
                              ? Icon(Icons.radio_button_checked)
                              : Icon(Icons.radio_button_unchecked),
                          onTap: () {
                            Navigator.of(context).pop();
                            _localeBloc?.add(
                                DefaultLocaleEvent(localeValueIndex: index));
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        ListTile(
          title: Text(S.of(context).aboutUs),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.of(context).pushNamed(RouteName.aboutPage);
          },
        ),
        Container(height: 15),
      ],
    ));
  }
}
