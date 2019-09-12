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
    private String url = "http://streaming.siue.edu:8000/wsie.mp3";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        //method channel for flutter to talk to android through
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
        new MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, Result result) {
                 if (call.method.equals("playStream")) {
                    initializeMediaPlayer();
                    startPlaying();
                } else {
                    stopPlaying();
                }
            }

        });
    }

    private void startPlaying() {
        System.out.println("Starting the player");
        //prepare the player
        player.prepareAsync();
        player.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
            public void onPrepared(MediaPlayer mp) {
                player.start();
            }
        });
    }
    private void stopPlaying() {
        System.out.println("Stoping the media player");
        //checking to make sure the player is running, to avoid a bad state call
        if (player.isPlaying()) {
            player.stop();
            player.release();
            initializeMediaPlayer();
        }
    }
    private void initializeMediaPlayer() {
        System.out.println("attempting to initialize the media player");
        player = new MediaPlayer();
        System.out.println("Media player created");
        //Checking to see what type of API level the Android device is
        if(Integer.valueOf(android.os.Build.VERSION.SDK) <= 25){
            player.setAudioStreamType(AudioManager.STREAM_MUSIC);
        }else {
            player.setAudioAttributes( new AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .build());
        }

        System.out.println("Attached the audio attributes");
        try {
            System.out.println("Attempting to set the data source for the project");
            player.setDataSource(this, Uri.parse(url));
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}



