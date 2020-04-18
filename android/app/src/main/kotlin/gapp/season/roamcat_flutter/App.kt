package gapp.season.roamcat_flutter

import gapp.season.poem.PoemReader
import gapp.season.reader.BookReader
import gapp.season.star.SkyStar
import io.flutter.app.FlutterApplication

class App : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()
        //SkyStar
        SkyStar.config(BuildConfig.DEBUG, 0.0, 0)
        //BookReader
        BookReader.config(BuildConfig.DEBUG, 0, filesDir.absolutePath)
        //PoemReader
        PoemReader.config(BuildConfig.DEBUG, 0)
    }
}
