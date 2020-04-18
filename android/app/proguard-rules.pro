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
