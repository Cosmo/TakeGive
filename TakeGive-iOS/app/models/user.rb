class User
  attr_accessor :id
  attr_accessor :name
  attr_accessor :picture
  
  def self.userFromResponseData(data)
    user          = self.new
    user.id       = data["_id"]
    user.name     = data["name"]
    user.picture  = data["picture"]
    user
  end
end