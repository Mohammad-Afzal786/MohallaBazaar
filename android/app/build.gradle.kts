import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
  namespace = "com.mohalla_bazaar.mohalla_bazaar.mohalla_bazaar"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // ✅ Kotlin DSL syntax
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11

        // ✅ Correct Kotlin DSL syntax for enabling desugaring
        isCoreLibraryDesugaringEnabled = true
    }
     buildFeatures {
        buildConfig = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.mohalla_bazaar.mohalla_bazaar.mohalla_bazaar"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // ✅ Include both ABIs in one single APK
    ndk {
        abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a"))
    }
    }

    signingConfigs {
    create("release") {
        val keystorePropertiesFile = rootProject.file("key.properties")
        val keystoreProperties = Properties()
        keystoreProperties.load(FileInputStream(keystorePropertiesFile))

        storeFile = file(keystoreProperties["storeFile"] as String)
        storePassword = keystoreProperties["storePassword"] as String
        keyAlias = keystoreProperties["keyAlias"] as String
        keyPassword = keystoreProperties["keyPassword"] as String
    }
}

 buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            buildConfigField("boolean", "DEBUG_MODE", "false")
        }

        debug {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    // ✅ ADD THIS SECTION ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
    // Disable split APKs per ABI (we want a single APK)
    splits {
        abi {
            isEnable = false
        }
    }


    // Avoid jniLibs merge issues (optional safety)
    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }
         
}

flutter {
    source = "../.."
}

dependencies {
   // ✅ Upgrade this version to 2.1.4 (or latest stable)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
}
