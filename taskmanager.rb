require 'csv'
require_relative 'task.rb'

class TaskManager
attr_accessor :task

  def initialize
  @task = []
  end

# 1 add content
  def add_task(content)
    if content.strip.empty?
      puts "ENTER VALID TASK"            
    # end
    else
      exist_task = task.find {|i| i.content == content }
      
      if exist_task
      puts "TASK ALREADY EXIST"
      else
      # for generating task id
        id = generate_task_id
      # object creation
        a = Tasks.new(id,content)
        task << a
        puts "TASK ADDED"
      end
    end
  end

# 2. listing task
  def list
    if task.empty?
      puts "TASK IS EMPTY"
    else
      puts "TASK ARE"
      task.each do |i|
        puts "#{i.id}. #{i.content} [#{i.completed ? 'complete' : 'not completed'}]"
      end
    end
  end

# 3. for editing
def edit_task(task_id, new_task)
  task = find_task(task_id)
 
  if task
    if task_exists?(new_task)
      puts "TASK ALREADY EXIST"
    else
      task.content = new_task
      puts "TASK UPDATED."
    end
  else
    puts "INVALID TASK ID"
  end
end

#4 for marking as complete
  def task_completed(task_id)
    a = find_task(task_id)
    if a
      a.mark_completed
      puts "TASK MARKED AS COMPLETED"
    else
      puts "INVALID INPUT"
    end
  end

#5 for deleting
  def delete_task(task_id)

    a = find_task(task_id)
    if a
      task.delete(a)
      puts "TASK DELETED"
    else
      puts "INVALID TASK ID"
    end
  end

# 6 for exporting
  def export value

    CSV.open("#{value}.csv","w") do |i|
      i << ['ID','Content','Status']
      task.each {|t| i << t.to_csv}    
    end
    return
  end

# 7 for searching
  def search(title)
    find = task.select { |i| i.content.downcase.include?(title.downcase) }
    if find.empty?
      puts "PROCESSING..."
      sleep(1)
      puts "NO SUCH TITLE FOUND! ENTER A VALID TITLE"
    else
      puts "PROCESSING..."
      sleep(1)
      find.each { |i| puts "#{i.content}" }
    end
  end


  def generate_task_id
    task.empty? ? 1 : task.last.id + 1
  end

  def find_task(task_id)
    task.find {|i| i.id == task_id}
  end

  def task_exists?(content)
    task.any? { |t| t.content == content }
  end
end
