package com.example.wsie_radio;

import android.os.Build.VERSION; 
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.app.Activity;
import android.os.Bundle;
import java.io.IOException;
import android.util.Log;

// import andriod.media.MediaPlayer.*;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnBufferingUpdateListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.media.MediaPlayer.OnErrorListener;
import android.media.AudioManager;
import android.media.AudioAttributes;
import android.net.Uri;
 
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ProgressBar;
import java.net.URL;
import java.net.URI; 
import java.util.HashMap;
import java.util.Map;
import java.util.*;



public class MainActivity extends FlutterActivity {

    private MediaPlayer player;
    private static final String CHANNEL = "wsie.get.radio/stream";
    private Boolean ready = false;
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
    private void startPlaying() {
        System.out.println("Trying the start -------------------------");        
        while(ready != true){
            System.out.println("Waiting");
        }
        player.start();
    }

    private void stopPlaying() {
        System.out.println("Trying the stop -------------------------");
        if (player.isPlaying()) {
            player.stop();
            player.release();
            initializeMediaPlayer();
        }
    }
    String url = "http://streaming.siue.edu:8000/wsie.mp3";
    // String url = "http://204.141.167.19:8980/stream";

    private void initializeMediaPlayer() {
        player = new MediaPlayer();
        

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            player.setAudioAttributes(new AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .setLegacyStreamType(AudioManager.STREAM_MUSIC)
                    .build());
        } else {
            player.setAudioStreamType(AudioManager.STREAM_MUSIC);
        }
        try {
            player.setDataSource(url);

            player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
                @Override
                public void onPrepared(MediaPlayer mp) {
                    mp.start();
                }
            });

            player.setOnErrorListener(new OnErrorListener() {
                public boolean onError(MediaPlayer mediaPlayer, int i, int i1) {
                    System.out.println("I: " + i);
                    System.out.println("il: " + i1);
                    return true;
                }
            });

            player.setOnBufferingUpdateListener(new OnBufferingUpdateListener() {
                public void onBufferingUpdate(MediaPlayer mp, int percent) {
                    // playSeekBar.setSecondaryProgress(percent);
                    Log.i("Buffering", "" + percent);
                    // System.out.println("Buffering: " +  percent);
                }
            });

            player.prepare();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }




    // private void initializeMediaPlayer() {
    //     // player = new MediaPlayer();
    //     player = new MediaPlayer();
    //     player.setAudioAttributes( new AudioAttributes.Builder()
    //         .setUsage(AudioAttributes.USAGE_MEDIA)
    //         .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
    //         .build());

    //     System.out.println("trying the try catch!!------------------------------------------");
    //     try {
    //         player.setDataSource(url);
    //         player.prepareAsync();
    //         player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() 
    //             {
    //                 @Override
    //                 public void onPrepared(MediaPlayer mp) 
    //                 {
    //                     System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!PREPARED!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    //                     // ready = true;
    //                     player.start();
    //                 }
    //             }
    //         );
    //         System.out.println("Called everything");
            
    //     } catch (IllegalArgumentException e) {
    //         e.printStackTrace();
    //     } catch (IllegalStateException e) {
    //         e.printStackTrace();
    //     } catch (IOException e) {
    //         e.printStackTrace();
    //     }

    //     player.setOnBufferingUpdateListener(new OnBufferingUpdateListener() {
    //         public void onBufferingUpdate(MediaPlayer mp, int percent) {
    //             // playSeekBar.setSecondaryProgress(percent);
    //             Log.i("Buffering", "" + percent);
    //         }
    //     });
    // }
}



