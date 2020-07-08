package com.hb.wobei

import android.content.Context
import android.widget.Toast
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/**
 * 高德地图插件
 */
object AMapProviderPlugin: EventChannel.StreamHandler {

    private lateinit var mapUtils: MapUtils

    /** Channel名称  **/
    private const val CHANNEL_NAME = "com.hb.wobei.plugins/amap"
    lateinit var context: Context
    lateinit var eventChannel: EventChannel

    /**
     * 注册插件
     * @param context 上下文对象
     * @param messenger 数据信息交流对象
     */
    @JvmStatic
    fun register(context: Context, messenger: BinaryMessenger) {
        this.context = context
        eventChannel = EventChannel(messenger, CHANNEL_NAME)
        eventChannel.setStreamHandler(this)
        mapUtils = MapUtils()
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        mapUtils.initLocation(context) {
            events!!.success("${it.latitude}-${it.longitude}-${it.province}-${it.city}")
        }.startLocation()
    }

    override fun onCancel(arguments: Any?) {
        mapUtils.stopLocation()
    }

}