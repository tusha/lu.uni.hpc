class Support
  
  include ActiveModel::Validations
  
  validates_presence_of :email, :sender_name, :content
  
  attr_accessor :id, :email, :sender_name, :content
  
  def initialize(attributes={})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @attributes=attributes
  end
  
  def read_attribute_for_validation(key)
    @attributes[key]
  end
  
  def to_key
    
  end
  
  def save
    if self.valid?
      Notifier.payment_notification(self).deliver!
      return true
    end
    return false
  end
  
  
end
