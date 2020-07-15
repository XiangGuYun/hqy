package com.hb.wobei

import android.content.Context
import android.widget.Toast
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

object ToastProviderPlugin {

    /** Channel名称  **/
    private const val ChannelName = "com.hb.wobei.plugins/log"

    /**
     * 注册Toast插件
     * @param context 上下文对象
     * @param messenger 数据信息交流对象
     */
    @JvmStatic
    fun register(context: Context, messenger: BinaryMessenger) = MethodChannel(messenger, ChannelName).setMethodCallHandler { methodCall, result ->
        when (methodCall.method) {
            "showShortToast" -> showToast(context, methodCall.argument<String>("message").toString(), Toast.LENGTH_SHORT)
            "showLongToast" -> showToast(context, methodCall.argument<String>("message").toString(), Toast.LENGTH_LONG)
            "showToast" -> showToast(context, methodCall.argument<String>("message").toString(),
                    methodCall.argument<Int>("duration")!!.toInt())
        }
        result.success(null) //没有返回值，所以直接返回为null
    }

    private fun showToast(context: Context, message: String, duration: Int) = Toast.makeText(context, message, duration).show()

}