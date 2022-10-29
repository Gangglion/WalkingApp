import UIKit
import Flutter
import Googlemap

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCkOD2DRNUOjVyA0NH-O6xvZ7N2TSJ6lZc")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
