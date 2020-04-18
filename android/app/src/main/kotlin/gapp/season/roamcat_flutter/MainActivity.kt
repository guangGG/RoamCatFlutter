package gapp.season.roamcat_flutter

import gapp.season.poem.PoemReader
import gapp.season.reader.BookReader
import gapp.season.star.SkyStar
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
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
