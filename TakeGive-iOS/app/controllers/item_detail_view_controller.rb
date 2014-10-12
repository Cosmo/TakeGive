class ItemDetailViewController < UIViewController
  attr_accessor :scrollView
  attr_accessor :item
  attr_accessor :pictureView
  attr_accessor :userNameLabel
  attr_accessor :pictureViewSeparator
  attr_accessor :pictureViewSeparator2
  attr_accessor :userAvatarView
  attr_accessor :takeButton
  attr_accessor :descriptionText
  
  def initWithItem(item)
    init
    self.item = item
    self
  end
  
  def viewDidLoad
    super
    self.title = item.title
    # self.view.backgroundColor = UIColor.whiteColor
    self.view.backgroundColor = UIColor.colorWithWhite(0.95, alpha:1.0)
    self.navigationController.setNavigationBarHidden(false, animated:true)
    
    self.scrollView = UIScrollView.alloc.initWithFrame(CGRectZero).tap do |scroll|
      scroll.contentInset           = UIEdgeInsetsMake(0, 0, 0, 0)
      scroll.scrollIndicatorInsets  = UIEdgeInsetsZero
      scroll.alwaysBounceVertical   = true
      self.view.addSubview(scroll)
    end
    
    self.takeButton = UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.setTitle("Take it for free", forState:UIControlStateNormal)
      button.addTarget(self, action:"takeItem:", forControlEvents:UIControlEventTouchUpInside)
      button.setTitleColor(UIColor.whiteColor, forState:UIControlStateNormal)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateHighlighted)
      button.font = UIFont.boldSystemFontOfSize(28)
      
      button.backgroundColor      = UIColor.colorWithRed(0/255.0, green:178/255.0, blue:0/255.0, alpha:1.0)
      button.layer.borderColor    = UIColor.whiteColor.CGColor
      button.layer.borderWidth    = 1
      button.layer.cornerRadius   = 4
      button.layer.masksToBounds  = false
      button.layer.shadowOffset   = CGSizeMake(0, 1)
      button.layer.shadowRadius   = 10
      button.layer.shadowOpacity  = 0.1
      
      self.view.addSubview(button)
    end
    
    self.pictureView = UIImageView.alloc.init.tap do |imageView|
      imageView.url = self.item.image
      self.scrollView.addSubview(imageView)
    end
    
    self.userNameLabel = UILabel.alloc.initWithFrame(CGRectZero).tap do |label|
      label.numberOfLines = 1
      label.textColor     = UIColor.blackColor
      label.font          = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
      label.text          = item.user.name
      self.scrollView.addSubview(label)
    end
    
    self.pictureViewSeparator = CALayer.layer.tap do |line|
      line.backgroundColor  = UIColor.colorWithWhite(0.8, alpha:1.0).CGColor
      line.frame            = CGRectZero
      self.scrollView.layer.addSublayer(line)
    end
    
    self.pictureViewSeparator2 = CALayer.layer.tap do |line|
      line.backgroundColor  = UIColor.colorWithWhite(0.8, alpha:1.0).CGColor
      line.frame            = CGRectZero
      self.scrollView.layer.addSublayer(line)
    end
    
    self.userAvatarView = UIImageView.alloc.init.tap do |imageView|
      imageView.url                 = self.item.user.picture
      imageView.backgroundColor     = UIColor.darkGrayColor
      imageView.layer.borderColor   = UIColor.darkGrayColor
      imageView.layer.borderWidth   = 1
      imageView.layer.shadowOffset  = CGSizeMake(0, 1)
      imageView.layer.shadowRadius  = 10
      imageView.layer.shadowOpacity = 0.1
      imageView.layer.masksToBounds = true
      
      self.scrollView.addSubview(imageView)
    end
    
    self.descriptionText = UITextView.alloc.initWithFrame(CGRectZero, textContainer:nil).tap do |label|
      label.text = item.subtitle
      label.backgroundColor = UIColor.clearColor
      label.font = UIFont.boldSystemFontOfSize(28)
      
      self.scrollView.addSubview(label)
    end
    
    
  end
  
  def viewDidAppear(animated)
    self.navigationController.setNavigationBarHidden(false, animated:true)
  end
  
  def viewWillLayoutSubviews
    self.takeButton.frame = CGRectMake(15, self.view.frame.size.height - 15 - 88, self.view.frame.size.width-15-15, 88)
    
    self.userAvatarView.frame = CGRectMake(15, 15, 44, 44)
    self.userAvatarView.layer.cornerRadius = 22
    self.userNameLabel.frame = CGRectMake(15 + 44 + 15, 15, self.view.frame.size.width-15-15-44-15, 44)
    
    self.pictureView.frame            = CGRectMake(0, 15 + 15 + 44, self.view.frame.size.width, self.view.frame.size.width)
    self.pictureViewSeparator.frame   = CGRectMake(0, 15 + 15 + 44, self.view.frame.size.width, 1)
    self.pictureViewSeparator2.frame  = CGRectMake(0, 15 + 15 + 44 + self.pictureView.frame.size.height, self.view.frame.size.width, 1)
    
    self.scrollView.frame       = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 800)
    
    self.descriptionText.frame = CGRectMake(15, self.pictureViewSeparator2.frame.origin.y, self.view.frame.size.width - 15 - 15, 170)
  end
end