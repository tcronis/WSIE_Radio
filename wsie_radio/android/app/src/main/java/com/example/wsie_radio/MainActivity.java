package com.example.wsie_radio;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import java.io.IOException;

import android.media.MediaPlayer;
import android.media.MediaPlayer.OnBufferingUpdateListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.media.AudioManager;
import android.net.Uri;
 
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ProgressBar;


public class MainActivity extends FlutterActivity {

  private MediaPlayer player;
  private static final String CHANNEL = "wsie.get.radio/stream";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    initializeMediaPlayer();

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall call, Result result) {
            if (call.method.equals("playStream")) {
                startPlaying();
                // System.out.println("START THE STREAM");
                // result.success(startPlaying());
            } else {
                stopPlaying();
                // System.out.println("STOP THE STREAM");
                // result.success(stopPlay());
            }
        }

    });
  }

  private void initializeMediaPlayer() {
      player = new MediaPlayer();

      // player.setAudioStreamType(AudioManager.STREAM_MUSIC);
      //  player.setAudioStreamType(AudioManager.STREAM_MUSIC);
      try {  
          player.setDataSource(this, Uri.parse("http://streaming.siue.edu:8000/wsie"));
          // player.setOnPreparedListener(this);
          player.prepareAsync();
      } catch (IllegalArgumentException e) {
          e.printStackTrace();
      } catch (IllegalStateException e) {
          e.printStackTrace();
      } catch (IOException e) {
          e.printStackTrace();
      } 

      player.setOnBufferingUpdateListener(new OnBufferingUpdateListener() {
          public void onBufferingUpdate(MediaPlayer mp, int percent) {
              // playSeekBar.setSecondaryProgress(percent);
              Log.i("Buffering", "" + percent);
          }
      });
  }

  private void startPlaying() {

    // player.start();

    player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
        @Override
        public void onPrepared(MediaPlayer mp) {
            mp.start();
        }
    });
  }

  private void stopPlaying() {
    if (player.isPlaying()) {
        player.stop();
        player.release();
        initializeMediaPlayer();
    }
}

}



