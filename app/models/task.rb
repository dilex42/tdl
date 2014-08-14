class Task < ActiveRecord::Base
  belongs_to :project
  validates :text, presence: true
  validates :project, presence: true
  
  def local_time
    if self.deadline
      self.deadline.to_s(:long)
    else
      nil
    end 
  end
end
