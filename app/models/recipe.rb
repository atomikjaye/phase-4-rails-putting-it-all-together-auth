class Recipe < ApplicationRecord
  validates :instructions, length: {minimum: 50 }, presence: true
  validates :title, presence: true
  
  belongs_to :user
end
