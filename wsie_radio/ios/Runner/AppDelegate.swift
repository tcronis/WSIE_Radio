import UIKit
import Flutter
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "wsie.get.radio/stream",
                                              binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      
        if(call.method == "playStream"){
            self.startPlaying()
        }else{
            self.stopPlaying()
        }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    lazy var playerQueue : AVQueuePlayer = {
        return AVQueuePlayer()
    }()
    
    private func startPlaying(){
    let url = URL(string: "http://streaming.siue.edu:8000/wsie.mp3")!
        
    do{
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCa)
    }catch{
        
    }
        
    let playerItem = AVPlayerItem.init(url: url)
    self.playerQueue.insert(playerItem, after: nil)
    self.playerQueue.play()
    }
    
    private func stopPlaying(){
        self.playerQueue.removeAllItems()
    }
}
