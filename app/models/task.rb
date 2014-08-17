class Task < ActiveRecord::Base
  belongs_to :project
  validates :text, presence: true
  validates :project, presence: true
  
  def local_time
    if self.deadline
      self.deadline.to_s(:long)
    else
      'No deadline set'
    end 
  end
end
