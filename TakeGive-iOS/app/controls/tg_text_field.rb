class TGTextField < UITextField
  attr_accessor :contentInset
  
  def getInset(bounds)
    unless self.contentInset
      self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    end
    
    return UIEdgeInsetsInsetRect(bounds, self.contentInset)
  end
  
  def textRectForBounds(bounds)
    getInset(super)
  end
  
  def placeholderRectForBounds(bounds)
    super
  end
  
  def editingRectForBounds(bounds)
    getInset(super)
  end
  
  def leftViewRectForBounds(bounds)
    CGRectMake(bounds.origin.x + self.contentInset.left, bounds.origin.y, super.size.width, bounds.size.height)
  end
end