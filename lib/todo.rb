class Todo < ActiveRecord::Base
  belongs_to :work, :polymorphic => true
  belongs_to :worker, :polymorphic => true
  
  # named_scope :with_statuses, lambda {|status| {conditions => "statuses_masks && #{2**STATUSES.index(status.to_s)}" > 0 }}
  
  
  # def statuses
  #   STATUSES.reject {|status| ((role_masks || 0) & STATUSES.index(status).zero?)}
  # end
  # 
  # def statuses=(statuses)    
  #   self.status_mask = (statuses & STATUSES).map {|status| 2**STATUSES.index(status)}.sum    
  # end
  
  def status
    TodoStatuses.new(statuses)
  end
  
  def status=(name)
    TodoStatuses.new(name)
  end
  
  
  
  def reestimate(options = {:started_at => Date.today, :end_at => Date.today})
    update_attributes(options)
  end
  
  def create_sub_task(params)
    sub_tasks.create(params)
  end
  
  def start
    started_at = Date.today
    status = "started"
  end
  
  def completed
    end_at = Date.today
     status = "completed"
  end
  
  def accepted
    accepted_at = Date.today
     status = "accepted"
  end
  
  def new?
    status.status_name == "new"
  end
  
  def started?
    status.status_name == "started"
  end
  
  def completed?
    status.status_name == "completed"
  end
  
  def accepted?
    status.status_name == "accepted"
  end
  
  def has_subtasks?
    !subtasks.blank?
  end 
end

class TodoStatuses
  attr_accessor :status_name
  STATUSES = %w{new started completed accepted}
  def initialize(name)
    puts "============#{name}"
    if TodoStatuses::STATUSES.include?(status_name)
      puts "========4444444444====#{name}"
      @status_name = status_name
    else
      @status_name = "new"
    end
  end
  
  def status_name=(status_name)
    puts "=========++++++===#{status_name}"
    if TodoStatuses::STATUSES.include?(status_name)
      @status_name = status_name
    else
      @status_name = "new"
    end
  end
  
  def todos
    if TodoStatuses::STATUSES.include?(@status_name)
      Todo.find_all_by_statuses(@status_name)
    else
      super
    end
  end
  
  
end


class SubTask < Todo
  belongs_to :todo
end


