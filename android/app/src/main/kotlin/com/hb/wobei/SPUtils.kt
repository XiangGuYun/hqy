package com.hb.wobei

import android.content.Context

interface SPUtils {

    companion object {

        const val FILE_NAME = "pref"

        fun getSP(ctx: Context, key: String, defaultObject: Any): Any {
            val sp = ctx.getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE)
            return when (defaultObject) {
                is String -> sp.getString(key, defaultObject.toString())
                is Int -> sp.getInt(key, defaultObject.toInt())
                is Boolean -> sp.getBoolean(key, defaultObject)
                is Float -> sp.getFloat(key, defaultObject.toFloat())
                is Long -> sp.getLong(key, defaultObject.toLong())
                else -> Any()
            }
        }

        fun putSP(ctx: Context, key: String, obj: Any) {
            val sp = ctx.getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE)
            val editor = sp.edit()
            when (obj) {
                is String -> editor.putString(key, obj)
                is Int -> editor.putInt(key, obj)
                is Boolean -> editor.putBoolean(key, obj)
                is Float -> editor.putFloat(key, obj)
                is Long -> editor.putLong(key, obj)
                else -> editor.putString(key, obj.toString())
            }
            editor.apply()
        }

        fun clearSP(ctx: Context) {
            val sp = ctx.getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE)
            val editor = sp.edit()
            editor.clear()
            editor.apply()
        }
    }

    fun Context.getSP(key: String, defaultObject: Any): Any {
        val sp = getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE)
        return when (defaultObject) {
            is String -> sp.getString(key, defaultObject.toString())
            is Int -> sp.getInt(key, defaultObject.toInt())
            is Boolean -> sp.getBoolean(key, defaultObject as Boolean)
            is Float -> sp.getFloat(key, defaultObject.toFloat())
            is Long -> sp.getLong(key, defaultObject.toLong())
            else -> Any()
        }
    }

    fun Context.remove(key: String) {
        val sp = getSharedPreferences(FILE_NAME, Context.MODE_PRIVATE)
        val editor = sp.edit()
        editor.remove(key)
        editor.apply()
    }


}