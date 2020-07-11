package com.hb.wobei

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import java.util.*

class WelcomeActivity : Activity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_welcome)

        Timer().schedule(object:TimerTask(){
            override fun run() {
                this@WelcomeActivity.startActivity(Intent(this@WelcomeActivity, MainActivity::class.java))
            }
        }, 3000)


    }

}