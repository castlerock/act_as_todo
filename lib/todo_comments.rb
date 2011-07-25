class TodoComments < ActiveRecord::Base
  belongs_to :todo
  
  def before_save
    worker_id = current_user.id
  end
end