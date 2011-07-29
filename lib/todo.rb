class Todo < ActiveRecord::Base
  belongs_to :todo_status
  
  STATUS = ["urgent", "narmal", "low", "waiting"]
  belongs_to :work, :polymorphic => true
  belongs_to :worker, :polymorphic => true
  has_many :sub_tasks
  validates_presence_of :work_id, :work_type, :status, :ended_at, :started_at
  
  before_save :set_status
  
  private
  
  def set_status
    TodoStatus.status(self)
  end
  
  def updated_at_date
    updated_at.strftime('%B %d')
  end
  
  def completed_at_date
    ended_at.strftime('%B %d')
  end
   
end

module TodoStatus
  
  STARTED = "STARTED"
  NEEDS_REVIEW = "NEEDS_REVIEW"
  NOT_STARTED = "NOT_STARTED"
  IN_COMPLETE = "IN_COMPLETE"
  DONE = "DONE"
  def self.status(todo)
    puts todo.inspect
    unless todo.status.blank?
      return STARTED
    end
  end  
end



