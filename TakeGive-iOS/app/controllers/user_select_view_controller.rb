class UserSelectViewController < UIViewController
  attr_accessor :signInAsOlcayHeadButton
  attr_accessor :signInAsOlcayButton
  attr_accessor :signInAsCosmoHeadButton
  attr_accessor :signInAsCosmoButton
  
  def viewDidLoad
    self.view.backgroundColor = UIColor.whiteColor
    
    self.signInAsOlcayHeadButton = UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      image = UIImage.imageNamed("olcay.jpg")
      button.setBackgroundImage(image, forState:UIControlStateNormal)
      button.addTarget(self, action:"signInAsOlcay:", forControlEvents:UIControlEventTouchUpInside)
      button.setTitleColor(UIColor.blackColor, forState:UIControlStateNormal)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateHighlighted)
      
      button.backgroundColor      = UIColor.darkGrayColor
      button.layer.borderColor    = UIColor.darkGrayColor
      button.layer.borderWidth    = 1
      button.layer.shadowOffset   = CGSizeMake(0, 1)
      button.layer.shadowRadius   = 10
      button.layer.shadowOpacity  = 0.1
      
      self.view.addSubview(button)
    end
    
    self.signInAsOlcayButton = UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.setTitle("Olcay", forState:UIControlStateNormal)
      button.addTarget(self, action:"signInAsOlcay:", forControlEvents:UIControlEventTouchUpInside)
      button.setTitleColor(UIColor.blackColor, forState:UIControlStateNormal)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateHighlighted)
      
      button.backgroundColor               = UIColor.whiteColor
      button.layer.borderColor   = UIColor.colorWithWhite(0.8, alpha:1.0).CGColor
      button.layer.borderWidth   = 1
      button.layer.cornerRadius  = 4
      button.layer.masksToBounds = false
      button.layer.shadowOffset  = CGSizeMake(0, 1)
      button.layer.shadowRadius  = 10
      button.layer.shadowOpacity = 0.1
      
      self.view.addSubview(button)
    end
    
    self.signInAsCosmoHeadButton = UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      image = UIImage.imageNamed("cosmo.jpg")
      button.setBackgroundImage(image, forState:UIControlStateNormal)
      button.addTarget(self, action:"signInAsCosmo:", forControlEvents:UIControlEventTouchUpInside)
      button.setTitleColor(UIColor.whiteColor, forState:UIControlStateNormal)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateHighlighted)
      
      button.backgroundColor      = UIColor.darkGrayColor
      button.layer.borderColor    = UIColor.darkGrayColor
      button.layer.borderWidth    = 1
      button.layer.shadowOffset   = CGSizeMake(0, 1)
      button.layer.shadowRadius   = 10
      button.layer.shadowOpacity  = 0.1
      
      self.view.addSubview(button)
    end
    
    self.signInAsCosmoButton = UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.setTitle("Cosmo", forState:UIControlStateNormal)
      button.addTarget(self, action:"signInAsCosmo:", forControlEvents:UIControlEventTouchUpInside)
      button.setTitleColor(UIColor.blackColor, forState:UIControlStateNormal)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateHighlighted)
      
      button.backgroundColor               = UIColor.whiteColor
      button.layer.borderColor   = UIColor.colorWithWhite(0.8, alpha:1.0).CGColor
      button.layer.borderWidth   = 1
      button.layer.cornerRadius  = 4
      button.layer.masksToBounds = false
      button.layer.shadowOffset  = CGSizeMake(0, 1)
      button.layer.shadowRadius  = 10
      button.layer.shadowOpacity = 0.1
      
      self.view.addSubview(button)
    end
  end
  
  def viewWillLayoutSubviews
    offsetX = ((self.view.frame.size.height - 88 - 88 - 15) / 2)
    self.signInAsOlcayHeadButton.frame  = CGRectMake(15, offsetX, 88, 88)
    self.signInAsOlcayHeadButton.layer.cornerRadius = 44
    self.signInAsOlcayHeadButton.layer.masksToBounds = true
    self.signInAsOlcayButton.frame      = CGRectMake(15 + 88 + 15, offsetX, self.view.frame.size.width - 15 - 15 - 15 - 88, 88)
    
    
    self.signInAsCosmoHeadButton.frame  = CGRectMake(15, 15 + 88 + offsetX, 88, 88)
    self.signInAsCosmoHeadButton.layer.cornerRadius = 44
    self.signInAsCosmoHeadButton.layer.masksToBounds = true
    self.signInAsCosmoButton.frame      = CGRectMake(15 + 88 + 15, 15 + 88 + offsetX, self.view.frame.size.width - 15 - 15 - 15 - 88, 88)
  end
  
  def signInAsOlcay(sender)
    UIApplication.sharedApplication.delegate.userId = "54392e14fc53ee17b02a8700"
    UIApplication.sharedApplication.delegate.setupDefaultViewController
  end
  
  def signInAsCosmo(sender)
    UIApplication.sharedApplication.delegate.userId = "543979a3cb9aeb0638a6f9f7"
    UIApplication.sharedApplication.delegate.setupDefaultViewController
  end
end