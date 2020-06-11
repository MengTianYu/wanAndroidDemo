package com.example.flutterapp;

import android.annotation.TargetApi;
import android.app.Activity;
import android.graphics.Color;
import android.graphics.Point;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Display;
import android.view.KeyCharacterMap;
import android.view.KeyEvent;
import android.view.ViewConfiguration;
import android.view.Window;
import android.view.WindowManager;

import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    setStatus(this);
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Handler h =new Handler(){
      @Override
      public void handleMessage(Message msg) {
        super.handleMessage(msg);
      }
    };

  }

  public void setStatus(Activity activity){
    if(!isNavigationBarShow(activity)) {
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);//窗口透明的状态栏
        activity.requestWindowFeature(Window.FEATURE_NO_TITLE);//隐藏标题栏
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);//窗口透明的导航栏
      }
    }else{
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        activity.getWindow().setStatusBarColor(Color.TRANSPARENT);
      }
    }
  }

  //是否是虚拟按键的设备
  @TargetApi(Build.VERSION_CODES.ICE_CREAM_SANDWICH)
  private boolean isNavigationBarShow(Activity activity){
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
      Display display = activity.getWindowManager().getDefaultDisplay();
      Point size = new Point();
      Point realSize = new Point();
      display.getSize(size);
      display.getRealSize(realSize);
      boolean  result  = realSize.y!=size.y;
      return realSize.y!=size.y;
    }else {
      boolean menu = ViewConfiguration.get(activity).hasPermanentMenuKey();
      boolean back = KeyCharacterMap.deviceHasKey(KeyEvent.KEYCODE_BACK);
      if(menu || back) {
        return false;
      }else {
        return true;
      }
    }
  }

}
