package com.hb.wobei

import android.content.Context
import android.util.Log
import com.amap.api.location.AMapLocation
import com.amap.api.location.AMapLocationClient
import com.amap.api.location.AMapLocationClientOption
import com.amap.api.location.AMapLocationListener


class MapUtils {

    lateinit var mLocationClient: AMapLocationClient
    var time = 0L
    val TAG = "MyLocation"

    fun initLocation(applicationContext: Context, located: (it: AMapLocation) -> Unit): MapUtils {
        mLocationClient = AMapLocationClient(applicationContext)
        val mAMapLocationListener = AMapLocationListener {
            if (it != null) {
                if (it.errorCode == 0) {
                    Log.d(TAG, "定位成功")
                    SPUtils.putSP(applicationContext, "currentCity", it.city)
                    located.invoke(it)
                    Log.d(TAG, it.address)
                } else {
                    located.invoke(it)
                    Log.d(TAG, "location Error, ErrCode:${it.errorCode}, errInfo:${it.errorInfo}")
                }
            } else {
                located.invoke(it)
                Log.d(TAG, "AMapLocation == null")
            }
        }
        mLocationClient.setLocationListener(mAMapLocationListener)
        val option = AMapLocationClientOption()
        option.locationPurpose = AMapLocationClientOption.AMapLocationPurpose.SignIn
        option.locationMode = AMapLocationClientOption.AMapLocationMode.Hight_Accuracy
        option.isOnceLocation = true
        option.isOnceLocationLatest = true
        mLocationClient.setLocationOption(option)
        return this
    }

    fun initLocationSafety(applicationContext: Context, located: (it: AMapLocation?) -> Unit): MapUtils {
        mLocationClient = AMapLocationClient(applicationContext)
        val mAMapLocationListener = AMapLocationListener {
            if (it != null) {
                if (it.errorCode == 0) {
                    located.invoke(it)
                } else {
                    located.invoke(it)
                }
            } else {
                located.invoke(it)
            }
        }
        mLocationClient.setLocationListener(mAMapLocationListener)
        val option = AMapLocationClientOption()
        option.locationPurpose = AMapLocationClientOption.AMapLocationPurpose.SignIn
        option.locationMode = AMapLocationClientOption.AMapLocationMode.Hight_Accuracy
        option.isOnceLocation = true
        option.isOnceLocationLatest = true
        mLocationClient.setLocationOption(option)
        return this
    }

    fun startLocation() {
        mLocationClient.stopLocation()
        mLocationClient.startLocation()//开始定位
    }

    fun stopLocation() {
        mLocationClient.stopLocation()
    }


}