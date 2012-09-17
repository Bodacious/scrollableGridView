class AppDelegate

  def window
    @window ||= UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  end

  def viewController
    UINavigationController.alloc.initWithRootViewController(GridViewController.new)
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.rootViewController = viewController
    window.makeKeyAndVisible
    true
  end

end
