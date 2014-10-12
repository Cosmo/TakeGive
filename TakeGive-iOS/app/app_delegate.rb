class AppDelegate
  attr_accessor :window
  attr_accessor :userId
  
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    self.window.tintColor = UIColor.colorWithRed(0/255.0, green:178/255.0, blue:0/255.0, alpha:1.0)
    self.window.backgroundColor = UIColor.whiteColor
    
    setupDefaultViewController
    
    self.window.makeKeyAndVisible
    
    true
  end
  
  def setupDefaultViewController
    if self.userId
      homeViewController = HomeViewController.alloc.init
      self.window.rootViewController = UINavigationController.alloc.initWithRootViewController(homeViewController)
    else
      self.window.rootViewController = UserSelectViewController.alloc.init
    end
  end
end
