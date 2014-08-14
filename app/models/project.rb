class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :user, presence: true
end
