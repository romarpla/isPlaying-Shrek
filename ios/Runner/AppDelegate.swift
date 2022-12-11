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
    let deviceChannel = FlutterMethodChannel(name: "test.flutter.methodchannel/iOS",binaryMessenger: controller.binaryMessenger)
    prepareMethodHandler(deviceChannel: deviceChannel)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
        
        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getDeviceModel" {
                self.playMusic()
            }
            else if call.method == "stopMusic" {
              self.stopMusic()
            }
            else {
                result(FlutterMethodNotImplemented)
                return
            }
            
        })
    }
    
    private func receiveDeviceModel(result: FlutterResult) {
        // 7
        let deviceModel = UIDevice.current.model
        playMusic()
        
        // 8
        result(deviceModel)
    }
    
    var player: AVAudioPlayer?

    func playMusic() {
        guard let path = Bundle.main.path(forResource: "allStar", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: path)

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func stopMusic(){
      guard let player = player else { return }
      player.stop()
    }
}
