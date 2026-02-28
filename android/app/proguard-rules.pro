# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-keepattributes *Annotation*
-keepattributes Signature

# AdMob
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.ads.** { *; }
-keepattributes *Annotation*
-keep class * extends java.util.ListResourceBundle {
    protected Object[][] getContents();
}
-keep public class com.google.android.gms.common.internal.safeparcel.SafeParcelable {
    public static final *** NULL;
}
-keepnames @com.google.android.gms.common.annotation.KeepName class *
-keepclassmembernames class * {
    @com.google.android.gms.common.annotation.KeepName *;
}
-keepnames class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

# GSON
-keepattributes Signature
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }
-keep class com.google.gson.examples.android.model.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# HTTP
-keep class com.squareup.okhttp.** { *; }
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# Dagger
-keep class * extends dagger.internal.Binding
-keep class * extends dagger.internal.ModuleAdapter
-keep class * extends dagger.internal.StaticInjection
-keep class dagger.** { *; }
-keep class javax.inject.** { *; }

# ButterKnife
-keep class butterknife.** { *; }
-dontwarn butterknife.internal.**
-keep class **$$ViewBinder { *; }
-keepclasseswithmembernames class * {
    @butterknife.* <fields>;
}
-keepclasseswithmembernames class * {
    @butterknife.* <methods>;
}

# Retrofit
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions
-dontwarn retrofit2.**
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class okio.** { *; }
-dontwarn okio.**

# Jackson
-keep class com.fasterxml.jackson.** { *; }
-keep class org.codehaus.** { *; }

# Crashlytics
-keep class com.crashlytics.** { *; }
-keep class com.google.firebase.crashlytics.** { *; }

# General rules
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference

# Keep - Library
-keep class androidx.** { *; }
-keep interface androidx.** { *; }
-dontwarn androidx.**

# Keep - Kotlin
-keep class kotlin.** { *; }
-keep class kotlinx.** { *; }
-dontwarn kotlin.**
-dontwarn kotlinx.**

# Keep - Native
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep - Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep - Parcelable
-keep class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

# Keep - Enum
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep - R
-keep class **.R$* {
    <fields>;
}

# Remove logging in release
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# YouTube Player
-keep class com.pierfrancescosoffritti.androidyoutubeplayer.** { *; }
-dontwarn com.pierfrancescosoffritti.androidyoutubeplayer.**

# Lottie
-keep class com.airbnb.lottie.** { *; }
-dontwarn com.airbnb.lottie.**

# Shimmer
-keep class com.facebook.shimmer.** { *; }
-dontwarn com.facebook.shimmer.**

# Carousel Slider
-keep class com.synnapps.carouselview.** { *; }
-dontwarn com.synnapps.carouselview.**

# Rating Bar
-keep class com.smoothratingbar.** { *; }
-dontwarn com.smoothratingbar.**

# SVG
-keep class com.caverock.androidsvg.** { *; }
-dontwarn com.caverock.androidsvg.**

# Provider
-keep class provider.** { *; }
-dontwarn provider.**

# GetX
-keep class get.** { *; }
-dontwarn get.**

# Dio
-keep class dio.** { *; }
-dontwarn dio.**

# Cached Network Image
-keep class cached_network_image.** { *; }
-dontwarn cached_network_image.**

# Shared Preferences
-keep class shared_preferences.** { *; }
-dontwarn shared_preferences.**

# URL Launcher
-keep class url_launcher.** { *; }
-dontwarn url_launcher.**

# Package Info Plus
-keep class package_info_plus.** { *; }
-dontwarn package_info_plus.**

# Device Info Plus
-keep class device_info_plus.** { *; }
-dontwarn device_info_plus.**

# Connectivity Plus
-keep class connectivity_plus.** { *; }
-dontwarn connectivity_plus.**

# Flutter DotEnv
-keep class flutter_dotenv.** { *; }
-dontwarn flutter_dotenv.**

# In-App Purchase
-keep class in_app_purchase.** { *; }
-dontwarn in_app_purchase.**

# RevenueCat
-keep class revenuecat.** { *; }
-dontwarn revenuecat.**