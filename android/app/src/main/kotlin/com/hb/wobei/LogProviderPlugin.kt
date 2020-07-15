package com.hb.wobei

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

object LogProviderPlugin {

    /** Channel名称  **/
    private const val CHANNEL_NAME = "com.hb.wobei.plugins/log"

    @JvmStatic
    fun register(messenger: BinaryMessenger) = MethodChannel(messenger,CHANNEL_NAME).setMethodCallHandler { methodCall, result ->
        when (methodCall.method) {
            "logD" -> logD(methodCall.argument<String>("tag").toString(), methodCall.argument<String>("text").toString())
        }
        result.success(null) //没有返回值，所以直接返回为null
    }

    private fun logD(tag: String, text: String) = Log.d(tag, text)

}