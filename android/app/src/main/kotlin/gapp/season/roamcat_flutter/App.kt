package gapp.season.roamcat_flutter

import android.app.Activity
import android.app.Application
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.multidex.MultiDex
import com.didichuxing.doraemonkit.DoraemonKit
import gapp.season.fileclear.FileClearHelper
import gapp.season.filemanager.FileManager
import gapp.season.fileselector.FileSelectorHelper
import gapp.season.imageviewer.ImageViewerHelper
import gapp.season.manageapps.ManageAppsHelper
import gapp.season.musicplayer.MusicPlayerHelper
import gapp.season.notepad.NoteHelper
import gapp.season.poem.PoemReader
import gapp.season.qrcode.QrcodeHelper
import gapp.season.reader.BookReader
import gapp.season.star.SkyStar
import gapp.season.util.SeasonUtil
import gapp.season.util.file.FileShareUtil
import gapp.season.util.task.OnTaskDone
import gapp.season.videoplayer.VideoPlayerHelper
import gapp.season.webbrowser.WebViewHelper
import io.flutter.app.FlutterApplication
import java.io.File

class App : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        SeasonUtil.init(this, BuildConfig.DEBUG)
        initDoraemonKit(this)
        initPlugins(this)
    }

    private fun initDoraemonKit(app: Application) {
        DoraemonKit.disableUpload()
        DoraemonKit.install(app)
        DoraemonKit.setWebDoorCallback { context, url ->
            WebViewHelper.showWebPage(context, url)
        }
        DoraemonKit.hide()
    }

    private fun initPlugins(app: App) {
        val baseDir = filesDir.absolutePath
        //WebBrowser
        WebViewHelper.init(object : WebViewHelper.Config {
            override fun getBaseDir(): String {
                return baseDir!!
            }

            override fun isDev(): Boolean {
                return BuildConfig.DEBUG
            }

            override fun getCallBack(): OnTaskDone<Any>? {
                return OnTaskDone { _, _, _ ->
                }
            }

            override fun attachBaseContext(context: Context?): Context? {
                return context
            }

            override fun getRemoveAdUrl(): String? {
                return null //这里可以配置去广告js脚本
            }
        })
        //SkyStar
        SkyStar.config(BuildConfig.DEBUG, 0.0, 0)
        //BookReader
        BookReader.config(BuildConfig.DEBUG, 0, baseDir)
        BookReader.setBrListener(object : BookReader.BrListener { //设置文件导入方式，不设置则使用系统默认方式
            override fun importBook(activity: Activity?, requestCode: Int) {
                FileSelectorHelper.selectFile(activity!!, requestCode)
            }

            override fun onImportBook(activity: Activity?, intent: Intent?): String {
                return FileShareUtil.getPath(activity, intent?.data)
            }
        })
        //PoemReader
        PoemReader.config(BuildConfig.DEBUG, 0)
        //VideoPlayer
        VideoPlayerHelper.init(this, BuildConfig.DEBUG)
        VideoPlayerHelper.listener = object : VideoPlayerHelper.VideoPlayerListener {
            override fun import(activity: Activity, requestCode: Int): Boolean {
                return FileSelectorHelper.selectFile(activity, requestCode)
            }

            override fun onImport(activity: Activity, data: Intent): String? {
                return FileShareUtil.getPath(activity, data.data)
            }
        }
        //Qrcode
        QrcodeHelper.init(object : QrcodeHelper.QrcodeListener {
            override fun onScanQRCodeSuccess(context: Context, result: String?): Boolean {
                return false //使用默认处理方式
            }

            override fun onBrowseResult(context: Context, result: String?): Boolean {
                WebViewHelper.showWebPage(context, result)
                return true //拦截并自定义浏览扫描结果
            }

            override fun getFilePath(context: Context, uri: Uri?): String? {
                return FileShareUtil.getPath(context, uri)
            }
        })
        //ManageApps
        ManageAppsHelper.init(this)
        //ImageViewer
        ImageViewerHelper.init(this, BuildConfig.DEBUG, OnTaskDone { code, _, data ->
            if (code == ImageViewerHelper.TASK_CODE_IMG_POSITION) {
                //定位到文件，data为文件路径
                FileManager.enter(app, data as String?)
            }
        })
        //FileSelector
        FileSelectorHelper.listener = object : FileSelectorHelper.FileSelectorListener {
            override fun onClickFile(activity: Activity, file: File) {
                FileManager.openFileWithDefault(activity, file)
            }
        }
        //MusicPlayer
        MusicPlayerHelper.init(this, "$baseDir/music")
        MusicPlayerHelper.listener = object : MusicPlayerHelper.MusicPlayerListener {
            override fun import(activity: Activity, requestCode: Int): Boolean {
                return FileSelectorHelper.selectFile(activity, requestCode)
            }

            override fun onImport(activity: Activity, data: Intent): String? {
                return FileShareUtil.getPath(activity, data.data)
            }
        }
        //NotePad
        NoteHelper.init(this, "$baseDir/note")
        //FileClear
        FileClearHelper.init("$baseDir/fileclear", object : FileClearHelper.ClearListener {
            override fun onClickFile(activity: Activity, file: File) {
                FileManager.openFileWithDefault(activity, file)
            }
        })
        //FileManager
        FileManager.init(this, "$baseDir/filemanager", BuildConfig.DEBUG)
    }

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(base)
    }
}
