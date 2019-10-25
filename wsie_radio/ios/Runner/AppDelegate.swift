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
    let audioSession = AVAudioSession.sharedInstance()
    
    // Start recieving stream into player queue and begin playing
    private func startPlaying(){
        let url = URL(string: "http://streaming.siue.edu:8000/wsie.mp3")!
            
        // Attempt to set playback category and set our audio session to active so we can
        //play in the background
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            do{
                try audioSession.setActive(true)
            } catch let error as NSError {
                print("Unable to activate audio session: \(error.localizedDescription)")
            }
        } catch {
            print("Unable to set playback category for AVAudioSession.sharedInstance()")
        }
            
        let playerItem = AVPlayerItem.init(url: url)
        self.playerQueue.insert(playerItem, after: nil)
        self.playerQueue.play()
    }
    
    // Remove stream items from player queue and stop playback
    private func stopPlaying(){
        self.playerQueue.removeAllItems()
        
        // Attempt to deactivate our audio session so other apps can resume theirs
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: [.mixWithOthers])
            do{
                try audioSession.setActive(false, options: [.notifyOthersOnDeactivation])
            } catch let error as NSError {
                print("Unable to deactivate audio session: \(error.localizedDescription)")
            }
        } catch {
            print("Unable to set playback category using .mixWithOthers for AVAudioSession.sharedInstance()")
        }
    }
}
