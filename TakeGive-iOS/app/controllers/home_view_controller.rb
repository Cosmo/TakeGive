class HomeViewController < UIViewController
  attr_accessor :mapView
  attr_accessor :searchField
  attr_accessor :addButton
  attr_accessor :categoriesView
  attr_accessor :locationManager
  
  def viewDidLoad
    super
    
    self.edgesForExtendedLayout = UIRectEdgeNone
    
    self.view.backgroundColor = UIColor.whiteColor
    
    locationManager = CLLocationManager.alloc.init
    locationManager.requestWhenInUseAuthorization
    
    self.locationManager = CLLocationManager.alloc.init
    self.locationManager.delegate = self
    self.locationManager.requestWhenInUseAuthorization
    self.locationManager.startUpdatingLocation
    
    self.mapView = MKMapView.alloc.init.tap do |map|
      map.showsUserLocation = true
      map.delegate = self
      self.view.addSubview(map)
    end
    
    self.navigationController.setNavigationBarHidden(true, animated:false)
    
    self.searchField = TGTextField.alloc.initWithFrame(CGRectZero).tap do |textField|
      textField.placeholder                   = "Search what you need."
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
      
      self.view.addSubview(textField)
    end
    
    self.categoriesView = UIView.alloc.initWithFrame(CGRectZero).tap do |view|
      view.backgroundColor = UIColor.whiteColor
      view.alpha = 0.0
      
      view.layer.borderColor    = UIColor.colorWithWhite(0.8, alpha:1.0).CGColor
      view.layer.borderWidth    = 1
      view.layer.cornerRadius   = 4
      view.layer.masksToBounds  = false
      view.layer.shadowOffset   = CGSizeMake(0, 1)
      view.layer.shadowRadius   = 10
      view.layer.shadowOpacity  = 0.1
      self.view.addSubview(view)
    end
    
    self.addButton = UIButton.buttonWithType(UIButtonTypeCustom).tap do |button|
      addButtonImage = UIImage.imageNamed("Add-Button.png")
      button.setImage(addButtonImage, forState:UIControlStateNormal)
      
      button.setTitle("Add", forState:UIControlStateNormal)
      button.addTarget(self, action:"showAddItemViewController:", forControlEvents:UIControlEventTouchUpInside)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateNormal)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateHighlighted)
      button.setTitleColor(UIColor.grayColor, forState:UIControlStateDisabled)
      button.backgroundColor    = UIColor.colorWithRed(0/255.0, green:178/255.0, blue:0/255.0, alpha:1.0)
      
      button.layer.borderColor             = UIColor.colorWithRed(14/255.0, green:113/255.0, blue:1/255.0, alpha:1.0)
      button.layer.borderWidth             = 1
      button.layer.cornerRadius            = 4
      
      self.view.addSubview(button)
    end
    
  end
  
  def textViewDidChange(textView)
    puts "change!"
  end
  
  def mapView(mapView, didUpdateUserLocation:userLocation)
    region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 3200, 3200)
    self.mapView.setRegion(self.mapView.regionThatFits(region), animated:true)
  end
  
  def viewDidAppear(animated)
    self.navigationController.setNavigationBarHidden(true, animated:true)
  end
  
  def viewWillLayoutSubviews
    self.mapView.frame        = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    self.searchField.frame    = CGRectMake(15, 20+15, self.view.frame.size.width-15-15, 44)
    self.addButton.frame      = CGRectMake(self.view.frame.size.width-15-88, self.view.frame.size.height-15-88, 88, 88)
    
    self.categoriesView.frame = CGRectMake(15, self.searchField.frame.origin.y + 44 + 15, self.view.frame.size.width-15-15, self.view.frame.size.height-15-15-15-15-88-44-20)
  end
  
  def showAddItemViewController(sender)
    completion = lambda { nil }
    
    addItemViewController = AddItemViewController.alloc.init
    addItemNavigationViewController = UINavigationController.alloc.initWithRootViewController(addItemViewController)
    
    self.presentViewController(addItemNavigationViewController, animated:true, completion:completion)
  end
  
  def requestAnnotationsFor(map)
    puts "request"
    
    boundingBox = boundingBoxFrom(map)
    
    f = "#{boundingBox["southWest"].latitude},#{boundingBox["southWest"].longitude}"
    s = "#{boundingBox["northEast"].latitude},#{boundingBox["northEast"].longitude}"
    
    puts "http://takegive.mybluemix.net/api/find/bybox?f=#{f}&s=#{s}"
    
    AFMotion::JSON.get("http://takegive.mybluemix.net/api/find/bybox?f=#{f}&s=#{s}") do |result|
      annotationsDataForRequestedRegion = result.object
      
      if map.annotations.count == 0
        addingAnnotationsData = annotationsDataForRequestedRegion
      else
        addingAnnotationsData = []
        annotationsDataForRequestedRegion.each do |newAnnotationData|
          # if map.annotations.any? { |existingAnnotation| newAnnotationData["id"] == existingAnnotation.id }
          #   # existing, skip
          # else
          #   # that's new, add it!
          #   addingAnnotationsData << newAnnotationData
          # end
        end
      end

      finalAnnotations = addingAnnotationsData.map do |data|
        Item.itemFromResponseData(data)
      end

      self.mapView.addAnnotations(finalAnnotations)
      
    end
  end
  
  def mapView(mapView, regionDidChangeAnimated:animated)
    requestAnnotationsFor(mapView)
    if self.searchField.isFirstResponder
      self.searchField.resignFirstResponder
    end
  end
  
  def boundingBoxFrom(mapView)
    puts "bounding"
    mRect       = mapView.visibleMapRect
    neMapPoint  = MKMapPointMake(MKMapRectGetMaxX(mRect), mRect.origin.y)
    swMapPoint  = MKMapPointMake(mRect.origin.x, MKMapRectGetMaxY(mRect))
    neCoord     = MKCoordinateForMapPoint(neMapPoint)
    swCoord     = MKCoordinateForMapPoint(swMapPoint)
    { "northEast" => neCoord, "southWest" => swCoord }
  end
  
  def updateMapAnnotations(sender)
    puts "update"
    boundingBoxFrom(self.mapView)
    requestAnnotationsFor(self.mapView)
  end
  
  def showCategories(sender)
    self.categoriesView.alpha = 0.0
    options = UIViewAnimationOptionCurveEaseInOut
    animations = lambda do
      self.categoriesView.alpha = 1.0
    end
    completion = lambda do |finished|
    end
    UIView.animateWithDuration(0.25, delay:0.0, options:options, animations:animations, completion:completion)
    
    self.categoriesView.transform = CGAffineTransformIdentity
  end
  
  def hideCategories(sender)
    self.categoriesView.alpha = 1.0
    options = UIViewAnimationOptionCurveEaseInOut
    animations = lambda do
      self.categoriesView.alpha = 0.0
    end
    completion = lambda do |finished|
    end
    UIView.animateWithDuration(0.25, delay:0.0, options:options, animations:animations, completion:completion)
    
    self.categoriesView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height)
  end
  
  # def textFieldDidBeginEditing(textField)
  # end

  def textFieldDidEndEditing(textField)
    puts textField.text.inspect
    if textField.text.length > 0
      showCategories(textField)
    else
      hideCategories(textField)
    end
  end
  
  def mapView(mapView, viewForAnnotation:annotation)
    nil
  end
  
  
  def mapView(sender, viewForAnnotation:annotation)
    if annotation.isKindOfClass(MKUserLocation)
      return nil
    else
      reuseId = "itemPin"
      aView = sender.dequeueReusableAnnotationViewWithIdentifier(reuseId)
      if aView == nil
        aView = MKPinAnnotationView.alloc.initWithAnnotation(annotation, reuseIdentifier:reuseId)
        aView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
        aView.animatesDrop = true
        aView.canShowCallout = true
      end
      aView.annotation = annotation
      return aView
    end
  end
  
  def mapView(mapView, annotationView:view, calloutAccessoryControlTapped:control)
    item = mapView.selectedAnnotations.first
    viewController = ItemDetailViewController.alloc.initWithItem(item)
    self.navigationController.pushViewController(viewController, animated:true)
  end
  
end