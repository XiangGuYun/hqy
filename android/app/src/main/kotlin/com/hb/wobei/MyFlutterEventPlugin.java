package com.hb.wobei;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

class MyFlutterEventPlugin implements EventChannel.StreamHandler {
    public EventChannel.EventSink eventSink;

    public static MyFlutterEventPlugin registerWith(PluginRegistry registry) {
        String CHANNEL = "com.example.flutter_app/event_plugin";
        PluginRegistry.Registrar registrar = registry.registrarFor(CHANNEL);
        EventChannel eventChannel = new EventChannel(registrar.messenger(), CHANNEL);
        MyFlutterEventPlugin myFlutterEventPlugin = new MyFlutterEventPlugin();
        eventChannel.setStreamHandler(myFlutterEventPlugin);
        return myFlutterEventPlugin;
    }
    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
    }
    @Override
    public void onCancel(Object o) {
    }
}