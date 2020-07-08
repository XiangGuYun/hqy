package com.hb.wobei

import android.Manifest
import android.app.Activity
import android.os.Bundle
import com.tbruyelle.rxpermissions2.RxPermissions

class SecondActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)

        val rp = RxPermissions(this)
        rp.requestEachCombined(Manifest.permission.READ_PHONE_STATE, Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE)
                .subscribe { permission ->
                    when {
                        permission.granted -> {

                        }
                        permission.shouldShowRequestPermissionRationale -> {

                        }
                        else -> {

                        }
                    }
                }

    }
}