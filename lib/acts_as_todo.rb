module ActiveRecord
  module Acts
    
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def aatd(options = {})
          has_many :todos, :as => :work, :conditions => ['todo_id IS NULL']
          include ActiveRecord::Acts::Work::InstanceMethods
        end
        
        def work_to_do()
          has_many :todos, :as => :worker, :conditions => ['todo_id IS NULL']
          include ActiveRecord::Acts::Worker::InstanceMethods         
        end
      end
            
      module Work
        module InstanceMethods
          def list_of_work
            todos
          end
          
          def urgent_work
            todos.where("end_at = '#{Date.today}'")
          end
          
          def failed_work
            todos.where("end_at < '#{Date.today}'")
          end
        end
 
      end # InstanceMethods
      
      module Worker
        module InstanceMethods
          def work_to_do
            todos
          end
          
          def urgent_todos
            todos.where("end_at = '#{Date.today}'")
          end
          
          def failed_todo
            todos.where("end_at < '#{Date.today}'")
          end
        end
      end
    
  end
end
