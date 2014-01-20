#
# AppDelegate
#
class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    app_controller = AppViewController.alloc.init
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = app_controller
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    true
  end
end
