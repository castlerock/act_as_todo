class SubTask < Todo
  belongs_to :todo
  validates_presence_of :todo_id
end