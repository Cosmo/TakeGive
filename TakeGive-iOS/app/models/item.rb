class Item
  attr_accessor :id
  attr_accessor :user
  attr_accessor :keywords
  attr_accessor :category
  attr_accessor :image
  
  def self.itemFromResponseData(data)
    item = self.new
    item.title      = data["name"]
    item.subtitle   = data["description"]
    item.id         = data["_id"]
    item.user       = User.userFromResponseData(data["user"])
    item.keywords   = data["keywords"]
    item.category   = data["category"]
    
    if data["location"].class == Hash
      item.coordinate = CLLocationCoordinate2DMake(data["location"]["lat"], data["location"]["lng"])
    else
      item.coordinate = CLLocationCoordinate2DMake(data["location"][0], data["location"][1])
    end
    
    item.image      = data["picture"]
    item
  end
  
  def coordinate
    @coordinate
  end
  
  def coordinate=(loc)
    @coordinate = loc
  end
  
  def title
    @title
  end
  
  def title=(string)
    @title = string
  end
  
  def subtitle
    @subtitle
  end
  
  def subtitle=(string)
    @subtitle = string
  end
end