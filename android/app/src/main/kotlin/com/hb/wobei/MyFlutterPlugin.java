package com.hb.wobei;

import android.app.Activity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

class MyFlutterPlugin implements MethodChannel.MethodCallHandler {
    private final Activity activity;
    public MyFlutterPlugin(Activity activity) {
        this.activity = activity;
    }
    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("getUser")) {
            Integer userId = methodCall.argument("userId");
            String mockUser = String.format("{\"name\":\"Wiki\",\"id\":%s}", userId);
            result.success(mockUser);
        }
    }
    public static void registerWith(PluginRegistry registry) {
        String CHANNEL = "com.example.flutter_app/plugin";
        PluginRegistry.Registrar registrar = registry.registrarFor(CHANNEL);
        MethodChannel methodChannel = new MethodChannel(registrar.messenger(), CHANNEL);
        MyFlutterPlugin myFlutterPlugin = new MyFlutterPlugin(registrar.activity());
        methodChannel.setMethodCallHandler(myFlutterPlugin);
    }
}