# Keep Flutter classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep Gson models (if used)
-keep class com.google.gson.** { *; }
-keepattributes *Annotation*
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Retrofit (if used)
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# Keep your model classes (customize if needed)
-keep class com.chetaru.tribe365_new.models.** { *; }

# Avoid stripping annotations (used in many frameworks)
-keepattributes *Annotation*

# Optional: Keep all native method calls
-keepclasseswithmembers class * {
    native <methods>;
}

# Disable deferred components
-dontwarn com.google.android.play.**