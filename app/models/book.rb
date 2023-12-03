class Book < ApplicationRecord
  has_many :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
   has_one_attached :profile_image
   belongs_to :user
   
end
