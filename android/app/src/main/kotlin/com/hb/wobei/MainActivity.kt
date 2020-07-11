package com.hb.wobei

import android.Manifest
import android.Manifest.permission.*
import android.annotation.SuppressLint
import android.app.AlertDialog
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import com.amap.api.location.AMapLocation
import com.tbruyelle.rxpermissions2.RxPermissions
import io.flutter.app.FlutterPluginRegistry
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private val CHANNEL = "samples.flutter.io/battery"

    //创建MethodChannel并设置一个MethodCallHandler。确保使用与在Flutter客户端使用的通道名称相同。
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        ToastProviderPlugin.register(this, flutterEngine.dartExecutor.binaryMessenger)
        AMapProviderPlugin.register(this, flutterEngine.dartExecutor.binaryMessenger)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }
                }
                "goToSecondActivity"->{
                    goToSecondActivity()
                }
                "reqPermission"->{
                    reqPermission(call.arguments as (Double, Double) -> Unit)
                }
                "toast"->{
                    toast(call.argument<String>("text").toString())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

    }

    fun getBatteryLevel(): Int {
        var batteryLevel = 0
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(application).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }

    fun goToSecondActivity(){
        startActivity(Intent(this, SecondActivity::class.java))
    }

    fun toast(text:String){
        Toast.makeText(this, text, Toast.LENGTH_SHORT).show()
    }

    @SuppressLint("CheckResult")
    fun reqPermission(function:(lon:Double, lat:Double)->Unit){
        Toast.makeText(this, "请求权限", Toast.LENGTH_SHORT).show()

//        val rp = RxPermissions(this)
//        rp.requestEachCombined(READ_PHONE_STATE, WRITE_EXTERNAL_STORAGE, READ_EXTERNAL_STORAGE,
//                Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION)
//                .subscribe { permission ->
//                    when {
//                        permission.granted -> {
//
//                        }
//                        permission.shouldShowRequestPermissionRationale -> {
//
//                        }
//                        else -> {
//
//                        }
//                    }
//                }

//        val dialog = AlertDialog.Builder(this).setTitle("标题").setMessage("你好呀").create()
//        dialog.show()

        MapUtils().initLocation(this){
            function.invoke(it.longitude, it.latitude)
        }.startLocation()
    }

}