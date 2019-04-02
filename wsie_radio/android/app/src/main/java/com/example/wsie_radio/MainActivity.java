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

        
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
        new MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, Result result) {
                if(call.method.equals("createStreamData")){
                    System.out.println("Initialzing the componenets-------------------------------------------------------");
                    initializeMediaPlayer();
                }
                else if (call.method.equals("playStream")) {
                    startPlaying();
                } else {
                    stopPlaying();
                }
            }

        });
    }

    private void initializeMediaPlayer() {
        player = new MediaPlayer();
        player.setAudioStreamType(AudioManager.STREAM_MUSIC);
        System.out.println("trying the try catch------------------------------------------");
        try {  
            // player.setDataSource(MainActivity.this, Uri.parse("http://82.77.137.30:8557"));
            player.setDataSource("http://streaming.siue.edu:8000/wsie");
            // player.prepareAsync();
            // player.start();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } 
    }

    private void startPlaying() {
        System.out.println("Trying the start -------------------------");
        // player.prepareAsync();
        player.setOnPreparedListener(new OnPreparedListener() {
            public void onPrepared(MediaPlayer mp) {
                mp.start();
            }
        });
    }

    private void stopPlaying() {
        System.out.println("Trying the stop -------------------------");
        if (player.isPlaying()) {
            player.stop();
            player.release();
            initializeMediaPlayer();
        }
    }

}



