import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
   
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     // GeneratedPluginRegistrant.register(withRegistry: self)
      print("application......")
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      let eventChannel = FlutterEventChannel(name: "timeHandlerEvent", binaryMessenger: controller.binaryMessenger)
      eventChannel.setStreamHandler(TimeHandler())
    
      GeneratedPluginRegistrant.register(with: self)
     
      
      
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
 
 class TimeHandler: NSObject, FlutterStreamHandler {
        // Handle events on the main thread.
        private var handler = DispatchQueue.main
        var timer = Timer()
        // Declare our eventSink, it will be initialized later
        private var eventSink: FlutterEventSink?
        
        func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
            print("onListen......")
            self.eventSink = eventSink
    
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "HH:mm:ss"
                    let time = dateFormat.string(from: Date())
                    print(time)
                    eventSink(time)
            })
            
        
            return nil
        }
        
        func onCancel(withArguments arguments: Any?) -> FlutterError? {
            print("onCancel......")
            eventSink = nil
            return nil
        }
    }


}
