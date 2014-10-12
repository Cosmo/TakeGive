class AddItemViewController < UIViewController
  attr_accessor :photoImageView
  attr_accessor :photoButton
  attr_accessor :scrollView
  attr_accessor :itemNameLabel
  attr_accessor :descriptionTextLabel
  
  def viewDidLoad
    super
    cancelButton  = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemCancel, target:self, action:"hideAddItem:")
    doneButton    = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemDone, target:self, action:"addItem:")
    self.navigationItem.leftBarButtonItems  = [cancelButton]
    self.navigationItem.rightBarButtonItems = [doneButton]
    
    self.title = "Give away"
    
    self.view.backgroundColor = UIColor.colorWithWhite(0.95, alpha:1.0)
    
    self.scrollView = UIScrollView.alloc.initWithFrame(CGRectZero).tap do |scroll|
      scroll.contentInset           = UIEdgeInsetsMake(0, 0, 0, 0)
      scroll.scrollIndicatorInsets  = UIEdgeInsetsZero
      scroll.alwaysBounceVertical   = true
      self.view.addSubview(scroll)
    end
    
    self.itemNameLabel = TGTextField.alloc.initWithFrame(CGRectZero).tap do |textField|
      textField.placeholder                   = "Name (required)"
      textField.contentInset                  = UIEdgeInsetsMake(0, 15, 0, 15)
      textField.clearButtonMode               = UITextFieldViewModeWhileEditing
      textField.leftViewMode                  = UITextFieldViewModeAlways
      textField.delegate                      = self
      textField.returnKeyType                 = UIReturnKeySearch
      textField.enablesReturnKeyAutomatically = true
      textField.keyboardAppearance            = UIKeyboardAppearanceDark
      textField.adjustsFontSizeToFitWidth     = true
      textField.backgroundColor               = UIColor.whiteColor
      
      textField.layer.borderColor   = UIColor.colorWithWhite(0.8, alpha:1.0).CGColor
      textField.layer.borderWidth   = 1
      textField.layer.cornerRadius  = 4
      textField.layer.masksToBounds = false
      textField.layer.shadowOffset  = CGSizeMake(0, 1)
      textField.layer.shadowRadius  = 10
      textField.layer.shadowOpacity = 0.1
      
      textField.font = UIFont.boldSystemFontOfSize(28)
      
      self.scrollView.addSubview(textField)
    end
    
    self.descriptionTextLabel = UITextView.alloc.initWithFrame(CGRectZero, textContainer:nil).tap do |label|
      label.backgroundColor = UIColor.whiteColor
      label.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15)
      label.font = UIFont.boldSystemFontOfSize(18)
      
      label.layer.borderColor   = UIColor.colorWithWhite(0.8, alpha:1.0).CGColor
      label.layer.borderWidth   = 1
      label.layer.cornerRadius  = 4
      label.layer.masksToBounds = false
      label.layer.shadowOffset  = CGSizeMake(0, 1)
      label.layer.shadowRadius  = 10
      label.layer.shadowOpacity = 0.1
      
      self.scrollView.addSubview(label)
    end
    
    self.photoImageView = UIImageView.alloc.init.tap do |imageView|
      imageView.contentMode   = UIViewContentModeScaleAspectFill
      imageView.clipsToBounds = true
      imageView.backgroundColor = UIColor.blackColor
      
      self.scrollView.addSubview(imageView)
    end
    
    self.photoButton = UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      button.setTitle("Photo", forState:UIControlStateNormal)
      button.addTarget(self, action:"pick:", forControlEvents:UIControlEventTouchUpInside)
      button.setTitleColor(UIColor.whiteColor, forState:UIControlStateNormal)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateHighlighted)
      button.font = UIFont.boldSystemFontOfSize(12)
      # button.backgroundColor      = UIColor.colorWithRed(0/255.0, green:178/255.0, blue:0/255.0, alpha:1.0)
      self.scrollView.addSubview(button)
    end
    
  end
  
  def pick(sender)
    BW::Device.camera.any.picture(allows_editing: true, media_types: [:image]) do |result|
      # original_image_view = UIImageView.alloc.initWithImage(result[:original_image])
      # edited_image_view = UIImageView.alloc.initWithImage(result[:edited_image])
      
      image = result[:edited_image]
      if image
        self.photoImageView.image = image
        self.photoButton.setTitle("", forState:UIControlStateNormal)
      end
    end
  end
  
  def viewWillLayoutSubviews
    self.photoImageView.frame          = CGRectMake(0, 0, self.view.frame.size.width, 200)
    self.photoButton.frame          = CGRectMake(0, 0, self.view.frame.size.width, 200)
    
    self.itemNameLabel.frame        = CGRectMake(15, 200 + 15, self.view.frame.size.width-15-15, 44)
    self.descriptionTextLabel.frame = CGRectMake(15, 200 + 15+44+15, self.view.frame.size.width-15-15, 44*2)
    
    self.scrollView.frame       = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 500)
  end
  
  def hideAddItem(sender)
    self.dismissViewControllerAnimated(true, completion:nil)
  end
  
  def addItem(sender)
    self.dismissViewControllerAnimated(true, completion:nil)
  end
end
