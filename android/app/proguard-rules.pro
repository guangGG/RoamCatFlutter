# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

-dontshrink      #不压缩输入的类文件
-dontoptimize    #不优化输入的类文件
-dontpreverify
-dontskipnonpubliclibraryclasses
-ignorewarnings

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.preference.Preference
-keep public class com.android.vending.licensing.ILicensingService

# 保持 native 方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}
# 保持自定义控件类不被混淆
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}
# 保持自定义控件类不被混淆
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
# 保持枚举 enum 类不被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
# 保持 Parcelable 不被混淆
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}
# 不混淆JavascriptInterface方法及WebChromeClient已移除的子方法
-keepattributes *JavascriptInterface*
-keepclassmembers class * extends android.webkit.WebChromeClient{
   		public void openFileChooser(...);
}

# 这条规则配置，可以把你的代码以及所使用到的各种第三方库代码统统移动到同一个包下
-repackageclasses

# 自定义一些类名称和包名的混淆名文件(https://github.com/ysrc/AndroidObfuseDictionary)
-obfuscationdictionary dic.txt
-classobfuscationdictionary dic.txt
-packageobfuscationdictionary dic.txt

# 不混淆support相关工具包
-keep class android.support.**{*;}
-keep class androidx.** {*;}
-keep class **.R$*
-keepclassmembers class **.R$* {
    public static <fields>;
}


# 不混淆一些巨头企业的开源lib
-keep class com.tencent.** {*;}
-dontwarn com.tencent.**
-keep class com.alibaba.** {*;}
-dontwarn com.alibaba.**
-keep class com.facebook.** {*;}
-dontwarn com.facebook.**
-keep class com.google.** {*;}
-dontwarn com.google.**


##---------------Begin: proguard configuration for Gson  ----------
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature
# For using GSON @Expose annotation
-keepattributes *Annotation*
# Gson specific classes
-dontwarn sun.misc.**
#-keep class com.google.gson.stream.** { *; }
# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { *; }
# Prevent proguard from stripping interface information from TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
##---------------End: proguard configuration for Gson  ----------


##---------------Begin: proguard configuration for okhttp  ----------
#okhttp
-dontwarn okhttp3.**
-keep class okhttp3.**{*;}
-dontwarn com.squareup.okhttp.**
# JSR 305 annotations are for embedding nullability information.
-dontwarn javax.annotation.**
# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*
# OkHttp platform used only on JVM and when Conscrypt dependency is available.
-dontwarn okhttp3.internal.platform.ConscryptPlatform
#okio
-dontwarn okio.**
-keep class okio.**{*;}
##---------------End: proguard configuration for okhttp  ----------


##---------------Begin: proguard configuration for Logback  ----------
-keep class ch.qos.** { *; }
-keep class org.slf4j.** { *; }
-keepattributes *Annotation*
-dontwarn ch.qos.logback.core.net.*
##---------------End: proguard configuration for Logback  ----------


##---------------Begin: proguard configuration for EventBus  ----------
-keepattributes *Annotation*
-keepclassmembers class * {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }
# Only required if you use AsyncExecutor
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}
##---------------End: proguard configuration for EventBus  ----------

# Glide混淆规则
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public class * extends com.bumptech.glide.module.AppGlideModule
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
# for DexGuard only
#-keepresourcexmlelements manifest/application/meta-data@value=GlideModule


# 不混淆引用的一些开源lib

-keep class com.gyf.immersionbar.* {*;}
-dontwarn com.gyf.immersionbar.**

-keep class com.chad.library.adapter.** {*;}
-keep public class * extends com.chad.library.adapter.base.BaseQuickAdapter
-keep public class * extends com.chad.library.adapter.base.BaseViewHolder
-keepclassmembers  class **$** extends com.chad.library.adapter.base.BaseViewHolder {
     <init>(...);
}

-keep class wendu.dsbridge.** {*;}
-dontwarn wendu.dsbridge.**

-keep class cn.bingoogolapple.qrcode.** {*;}
-dontwarn cn.bingoogolapple.qrcode.**

-keep class com.lxj.xpopup.** {*;}
-dontwarn com.lxj.xpopup.**



# 以下为aar中的配置consumer-rules.pro，由于aar中配置过了，主Module这里也可以不配置

# 引入的BeanShell中有不少用不到的不兼容问题(如:AWTConsole类继承自TextArea,TextArea在安卓中是没有的),这里设置屏蔽掉打包时的警告
-dontwarn bsh.**
-keep class bsh.** {*;}

# Calender组件混淆规则(内部通过反射映射日历的组件)
-keep class com.haibin.calendarview.** {*;}
-dontwarn com.haibin.calendarview.**
-keep class gapp.season.calender.CalenderMonthView {
    public <init>(android.content.Context);
}
-keep class gapp.season.calender.CalenderWeekBar {
    public <init>(android.content.Context);
}
-keep class gapp.season.calender.CalenderWeekView {
    public <init>(android.content.Context);
}
-keep class gapp.season.calender.CalenderYearView {
    public <init>(android.content.Context);
}

# drawableview组件
-keep class me.panavtec.drawableview.** {*;}
-dontwarn me.panavtec.drawableview.**

# BigImageViewer
-keep class com.github.piasy.biv.** {*;}
-dontwarn com.github.piasy.biv.**

# 不混淆视频播放器Lib
-keep class com.shuyu.gsyvideoplayer.video.** { *; }
-dontwarn com.shuyu.gsyvideoplayer.video.**
-keep class com.shuyu.gsyvideoplayer.video.base.** { *; }
-dontwarn com.shuyu.gsyvideoplayer.video.base.**
-keep class com.shuyu.gsyvideoplayer.utils.** { *; }
-dontwarn com.shuyu.gsyvideoplayer.utils.**
-keep class tv.danmaku.ijk.** { *; }
-dontwarn tv.danmaku.ijk.**
-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}
