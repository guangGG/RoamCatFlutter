import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roamcat_flutter/data/channel/app_method_channel.dart';
import 'package:roamcat_flutter/data/helper/app_data_helper.dart';
import 'package:roamcat_flutter/generated/l10n.dart';
import 'package:roamcat_flutter/util/extra_types.dart';
import 'package:roamcat_flutter/view/router.dart';

class AppPluginHelper {
  static const String tagAndroid = "tagAndroid";
  static const String tagBrowser = "fBrowser";

  static List<AppPlugin> pluginList;

  static List<AppPlugin> getPluginList() {
    bool debug = !kReleaseMode;
    if (pluginList == null) {
      //var context = AppDataHelper.navigatorKey.currentState.context;
      List<AppPlugin> list = List();
      if (Platform.isAndroid) {
        //使用MethodChannel调用Android原生方法
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_apps;
          },
          Icons.android,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openApplications();
            }
          },
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_webbrowser;
          },
          Icons.public,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openWebBrowser();
            }
          },
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_file_manager;
          },
          Icons.folder_open,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openFileManager();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_music;
          },
          Icons.music_note,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openMusicPlayer();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_gallery;
          },
          Icons.photo_library,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openGallery();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_videos;
          },
          Icons.video_library,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openVideo();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_reader;
          },
          Icons.book,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openBookReader();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_music_list;
          },
          Icons.queue_music,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openMusicList();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_poem;
          },
          Icons.filter_drama,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openPoemReader();
            }
          },
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_note;
          },
          Icons.featured_play_list,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openNote();
            }
          },
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_private_note;
          },
          Icons.security,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openPrivateNote();
            }
          },
        ));
        if (debug) {
          list.add(AppPlugin(
            tagAndroid,
            (context) {
              return S.of(context).android_item_file_clear;
            },
            Icons.delete_outline,
            (bool longPress) async {
              if (!longPress) {
                AppMethodChannel.openFileClear();
              }
            },
            permissions: [PermissionGroup.storage],
          ));
        }
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_skystar;
          },
          Icons.brightness_2,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openSkyStar();
            }
          },
          permissions: [PermissionGroup.locationWhenInUse],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_scan;
          },
          Icons.crop_free,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openScanQrCode();
            }
          },
          permissions: [PermissionGroup.storage, PermissionGroup.camera],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_video_player;
          },
          Icons.videocam,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openVideoPlayer();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_calendar;
          },
          Icons.calendar_today,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openCalendar();
            }
          },
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_calculator;
          },
          Icons.tune,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openCalculator();
            }
          },
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_sudoku;
          },
          Icons.apps,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openSudoku();
            }
          },
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_nerve_rabbit;
          },
          Icons.scatter_plot, //videogame_asset
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openNerveRabbit();
            }
          },
        ));
        list.add(AppPlugin(
          tagAndroid,
          (context) {
            return S.of(context).android_item_drawboard;
          },
          Icons.format_color_fill,
          (bool longPress) async {
            if (!longPress) {
              AppMethodChannel.openDrawingBoard();
            }
          },
          permissions: [PermissionGroup.storage],
        ));
        if (debug) {
          list.add(AppPlugin(
            tagAndroid,
            (context) {
              return S.of(context).android_item_text_viewer;
            },
            Icons.description,
            (bool longPress) async {
              if (!longPress) {
                AppMethodChannel.openTextViewer();
              }
            },
            permissions: [PermissionGroup.storage],
          ));
          list.add(AppPlugin(
            tagAndroid,
            (context) {
              return S.of(context).android_item_image_viewer;
            },
            Icons.crop_original,
            (bool longPress) async {
              if (!longPress) {
                AppMethodChannel.openImageViewer();
              }
            },
            permissions: [PermissionGroup.storage],
          ));
          list.add(AppPlugin(
            tagAndroid,
            (context) {
              return S.of(context).android_item_file_selector;
            },
            Icons.check_circle_outline,
            (bool longPress) async {
              if (!longPress) {
                AppMethodChannel.openFileSelector();
              }
            },
            permissions: [PermissionGroup.storage],
          ));
          list.add(AppPlugin(
            tagAndroid,
            (context) {
              return S.of(context).android_item_doraemon_kit;
            },
            Icons.phonelink_setup,
            (bool longPress) async {
              if (!longPress) {
                AppDataHelper.showDebugIcon = !AppDataHelper.showDebugIcon;
                AppMethodChannel.switchDoraemonKit(AppDataHelper.showDebugIcon);
              }
            },
          ));
        }
      }
      list.add(AppPlugin(
        tagBrowser,
        (context) {
          return S.of(context).pluginBrowser;
        },
        Icons.language,
        (bool longPress) async {
          if (!longPress) {
            String content =
                await rootBundle.loadString("assets/files/web_home.html");
            String url = Uri.dataFromString(content,
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'))
                .toString();
            AppDataHelper.navigatorKey.currentState.pushNamed(
              RouteName.webPage,
              arguments: {'url': url},
            );
          }
        },
      ));
      // demos
      bool showDemos = false;
      if (debug && showDemos) {
        list.add(AppPlugin('tag', _demoName, Icons.ac_unit, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.access_alarms, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.accessibility, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.beach_access, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.blur_circular, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.bug_report, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.camera, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.camera_roll, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.delete_outline, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.details, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.directions_car, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.cast_connected, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.gamepad, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.device_hub, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.dashboard, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.directions_run, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.edit, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.explore, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.equalizer, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.event_seat, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.contact_phone, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.child_care, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.face, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.favorite, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.filter_frames, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.gavel, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.group, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.group_work, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.grade, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.headset, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.home, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.star_half, _demoPress));
        list.add(AppPlugin('tag', _demoName, Icons.import_export, _demoPress));
      }
      pluginList = list;
    }
    return pluginList;
  }

  static String _demoName(BuildContext context) {
    return S.of(context).pluginTag;
  }

  static void _demoPress(bool longPress) {
    if (!longPress) Fluttertoast.showToast(msg: "coming soon");
  }
}

//通过方法动态获取插件名称，防止语言切换无效
class AppPlugin {
  String tag;
  ValueSetterGetter<String, BuildContext> name;
  IconData icon;
  ValueSetter<bool> onPress;
  List<PermissionGroup> permissions;

  AppPlugin(this.tag, this.name, this.icon, this.onPress, {this.permissions});
}
