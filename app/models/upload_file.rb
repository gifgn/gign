class UploadFile < ActiveRecord::Base
  attr_accessor :creator
  
  belongs_to :imageable, :polymorphic => true
  belongs_to :user
  
  before_create :set_user
  before_save :set_name
  validates_presence_of :url
  
  delegate :name, :email, :fullname,
    to: :user, prefix: true, allow_nil: true


  mount_uploader :url, FileUploader

  private
  
    def set_user
      self.user = self.creator if self.creator
    end
   
    def set_name
      self.name = self.url.identifier if self.name.blank?
    end
end
