module Concerns::Persistable

  def save #Instance Method
    self.class.all << self
  end

  def destroy_all #Class Method
    self.all.clear
  end

end
