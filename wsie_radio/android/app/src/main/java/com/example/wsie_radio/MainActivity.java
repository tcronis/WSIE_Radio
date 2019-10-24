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
import java.nio.channels.Channel;
import java.util.Map;
import java.util.HashMap;

import android.util.Log;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnBufferingUpdateListener;
import android.media.MediaPlayer.OnPreparedListener;
import android.media.MediaPlayer.OnErrorListener;
import android.media.AudioManager;
import android.media.AudioAttributes;
import android.net.Uri;




public class MainActivity extends FlutterActivity {

    private static MediaPlayer player;
    private static final String CHANNEL = "wsie.get.radio/stream";
    private Boolean ready = false;
    private String url = "http://streaming.siue.edu:8000/wsie";
    private Boolean stopPlayingFlag = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        //method channel for flutter to talk to android through
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodCallHandler() {
                @Override
                public void onMethodCall(MethodCall call, Result result) {
                    boolean initializerForMedia = false;
                    if (call.method.equals("playStream") && player == null) {
                        //this will check to make sure that the media player is initialized, else it will fail
                        initializerForMedia = initializeMediaPlayer();
                        if(initializerForMedia == true)                        
                            //Will return true after the steps are complete, so the andriod media player can't be spammed
                            result.success(startPlaying());
                    } else {
                        //Will return true after the steps are complete, so the andriod media player can't be spammed
                        stopPlayingFlag = true;
                        result.success(stopPlaying());
                    }
                }
            });
    }

    private boolean startPlaying() {
        //prepare the player
        player.prepareAsync();
        player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
            public void onPrepared(MediaPlayer mp) {
                //this will check to see if the stop playing was pressed during the async of preparing to start, if so then it won't run the mediaplayer
                if(stopPlayingFlag == true){
                    player.reset(); 
                    player.release();
                    player = null;
                    stopPlayingFlag = false;
                }
                else
                    player.start();
            }
        });
        return true;
    }
    private boolean stopPlaying() {
        //checking to make sure the player is running, to avoid a bad state call
        if (player != null) {
            if(player.isPlaying()){
                player.stop();
                player.reset();
                player.release();
                player = null;
                stopPlayingFlag = false;
            }
        }
        return true;
    }
    private boolean initializeMediaPlayer() {
        boolean success_failure = true;
        player = new MediaPlayer();
        //Checking to see what type of API level the Android device is
        if(Integer.valueOf(android.os.Build.VERSION.SDK) >= 25){
            player.setAudioStreamType(AudioManager.STREAM_MUSIC);
            try {
                Map<String, String> headers = new HashMap<>();
                headers.put("Content-Type", "audio/mp3"); // change content type if necessary
                headers.put("Accept-Ranges", "bytes");
                headers.put("Status", "206");
                headers.put("Cache-control", "no-cache");
                player.setDataSource(url);
            } catch (IllegalArgumentException e) {
                success_failure = false;
                e.printStackTrace();
            } catch (IllegalStateException e) {
                success_failure = false;
                e.printStackTrace();
            } catch (IOException e) {
                success_failure = false;
                e.printStackTrace();
            }
        }else {
            //this is for if the OS doesn't meet the requirements of API 25, it will just fail
            success_failure = false;
        }
        return success_failure;
    }
}



