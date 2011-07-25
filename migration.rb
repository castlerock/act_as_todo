class ActsAsTodoMigration < ActiveRecord::Migration
  def self.up
    unless table_exists?("todos")    
      create_table :todos do |t|
      	t.integer :worker_id
      	t.string :worker_type
        t.integer :work_id
        t.string :work_type
        t.integer :todo_id
        t.date :started_at
        t.date :end_at
        t.date :accepted_at
        t.string :statuses
        t.integer :statuses_mask
        t.timestamps
      end
    else
      puts "Migration Already run please check Table has been created"
    end
    
    unless table_exists?("todo_comments")    
      create_table :todo_comments do |t|
      	t.integer :todo_id
      	t.string :body
      	t.integer :worker_id
        t.timestamps
      end
    else
      puts "Migration Already run please check Table has been created"
    end
  end
  
  def self.down
    unless table_exists?("todos")    
      puts "Migration not run to create todos table in schema please check Table has not been created"
    else
      drop_table :todos
    end
    
    unless table_exists?("todo_comments")    
      puts "Migration not run to create todos table in schema please check Table has not been created"
    else
      drop_table :todo_comments
    end
  end
end