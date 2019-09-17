#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                    methodChannelWithName:@"wsie.get.radio/stream"
                                    binaryMessenger: controller];
    
    __weak typeof(self) weakSelf = self;
    [channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // Note: this method is invoked on the UI thread.
        if([@"playStream" isEqualToString:call.method]) {
            [weakSelf startPlaying];
        }
    }];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)startPlaying{
    NSLog(@"Hello world");
}

@end
