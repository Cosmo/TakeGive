class AddItemViewController < UITableViewController
  def viewDidLoad
    super
    cancelButton  = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemCancel, target:self, action:"hideAddItem:")
    doneButton    = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemDone, target:self, action:"addItem:")
    self.navigationItem.leftBarButtonItems  = [cancelButton]
    self.navigationItem.rightBarButtonItems = [doneButton]
  end
  
  def hideAddItem(sender)
    self.dismissViewControllerAnimated(true, completion:nil)
  end
  
  def addItem(sender)
    self.dismissViewControllerAnimated(true, completion:nil)
  end
end
