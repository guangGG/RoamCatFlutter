package gapp.season.roamcat_flutter

import com.didichuxing.doraemonkit.DoraemonKit
import gapp.season.calculator.CalculatorHelper
import gapp.season.calender.CalenderHelper
import gapp.season.drawboard.DrawBoardHelper
import gapp.season.fileclear.FileClearHelper
import gapp.season.filemanager.FileManager
import gapp.season.fileselector.FileSelectorHelper
import gapp.season.imageviewer.ImageViewerHelper
import gapp.season.manageapps.ManageAppsHelper
import gapp.season.mediastore.MediaStoreHelper
import gapp.season.musicplayer.MusicPlayerHelper
import gapp.season.nerverabbit.NerveRabbitHelper
import gapp.season.notepad.NoteHelper
import gapp.season.poem.PoemReader
import gapp.season.qrcode.QrcodeHelper
import gapp.season.reader.BookReader
import gapp.season.star.SkyStar
import gapp.season.sudoku.SudokuHelper
import gapp.season.textviewer.TextViewerHelper
import gapp.season.videoplayer.VideoPlayerHelper
import gapp.season.webbrowser.WebViewHelper
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

//生物识别BiometricPromptHelper必须在FragmentActivity中处理
class MainActivity : FlutterFragmentActivity() {
    companion object {
        const val METHOD_CHANNEL_PLUGIN = "gapp.season.roamcat_flutter:MethodChannel"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        //引用库中的Plugin注册
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        //旧版io.flutter.app.FlutterActivity中BinaryMessenger获取: registrarFor("$METHOD_CHANNEL_PLUGIN").messenger()
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL_PLUGIN)
        //监听flutter调用原生端方法
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "SkyStar" -> {
                    SkyStar.openSkyBall(this)
                }
                "BookReader" -> {
                    BookReader.readBook(this, null)
                }
                "PoemReader" -> {
                    PoemReader.readPoem(this)
                }
                //RoamCatX Modules
                "WebBrowser" -> {
                    WebViewHelper.showWebPage(this, null)
                }
                "Applications" -> {
                    ManageAppsHelper.manageApps(this)
                }
                "Note" -> {
                    NoteHelper.openNote(this)
                }
                "PrivateNote" -> {
                    //BiometricPromptHelper must come from FragmentActivity
                    NoteHelper.openNote(this, true)
                }
                "FileManager" -> {
                    FileManager.enter(this)
                }
                "MusicPlayer" -> {
                    MusicPlayerHelper.play(this)
                }
                "Gallery" -> {
                    MediaStoreHelper.showGallery(this)
                }
                "Video" -> {
                    MediaStoreHelper.showVideos(this)
                }
                "TextViewer" -> {
                    TextViewerHelper.show(this)
                }
                "ImageViewer" -> {
                    ImageViewerHelper.show(this)
                }
                "FileClear" -> {
                    FileClearHelper.openPage(this)
                }
                "Calendar" -> {
                    CalenderHelper.openCalender(this)
                }
                "Calculator" -> {
                    CalculatorHelper.openCalculator(this)
                }
                "NerveRabbit" -> {
                    NerveRabbitHelper.startPlay(this)
                }
                "Sudoku" -> {
                    SudokuHelper.openSudoku(this)
                }
                "DrawingBoard" -> {
                    DrawBoardHelper.openDrawBoard(this)
                }
                "ScanQrCode" -> {
                    QrcodeHelper.scanQrcode(this)
                }
                "VideoPlayer" -> {
                    VideoPlayerHelper.play(this, null)
                }
                "FileSelector" -> {
                    FileSelectorHelper.selectFile(this, 0, true, null)
                }
                "MusicList" -> {
                    MediaStoreHelper.showMusics(this)
                }
                //DoraemonKit show/hide (only debug)
                "DoraemonKit" -> {
                    if (call.arguments == true) {
                        DoraemonKit.show()
                    } else {
                        DoraemonKit.hide()
                    }
                }
            }
            result.success(0)
        }
        //调用flutter中的方法
        /*channel.invokeMethod("$method", arguments, object : MethodChannel.Result {
            override fun success(result: Any?) {
            }

            override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
            }

            override fun notImplemented() {
            }
        })*/
    }
}
