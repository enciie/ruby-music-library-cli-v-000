module Concerns::Persistable

  def save #Instance Method
    self.all << self
  end

  def self.destroy_all #Class Method
    self.all.clear
  end
  
end