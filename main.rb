require_relative 'task.rb'
require_relative 'taskmanager.rb'
class MainMenu
  def initialize(task_manager)
    @task_manager = task_manager
    @b = "----------------"
  end

  def display
    
    input_count = 0
    loop do
      puts " \n"
      puts "\n "
      puts "\t\t    ------MAIN MENU----- \n \n        " 
      puts "        |-------------------------------------------|" 
      puts "\t|\t1.    Add Task                      |"
      puts "\t|\t#{@b}                    |"
      puts "\t|\t2.    List All Task                 |"
      puts "\t|\t#{@b}-----               |"
      puts "\t|\t3.    Edit Task                     |"
      puts "\t|\t#{@b}                    |"
      puts "\t|\t4.    Mark Task Completed           |"
      puts "\t|\t#{@b}-----------         |"
      puts "\t|\t5.    Delete The Task               |"
      puts "\t|\t#{@b}-------             |"
      puts "\t|\t6.    Export All Task to CSV        |"
      puts "\t|\t#{@b}-------------       |"
      puts "\t|\t7.    Search The Task By Title      |"
      puts "\t|\t#{@b}---------------     |"
      puts "\t|\t8.    Exit                          |"
      puts "\t|\t#{@b}                    |"
      puts "        |-------------------------------------------|"
      puts "\t|\tSELECT YOUR CHOICE                  |"
      puts "        |-------------------------------------------|"

      choice = gets.chomp.to_i

    if choice.between?(1,8)
      input_count = 0
    else
      input_count += 1
      if input_count > 3
       puts "OOPS!! TO MANY INCORRECT ATTEMPT."
      break
      end

    end

      case choice
      when 1
        add_task
      when 2
        list_tasks
      when 3
        edit_task
      when 4
        mark_task_completed
      when 5
        delete_task
      when 6
        export_tasks
      when 7
        search_tasks
      when 8
        break
      else
        puts "INVALID CHOICE"
      end
    end
  end

  def add_task
    puts " \t \tEnter the task:"
    content = gets.chomp.to_s
    @task_manager.add_task(content)
  end

  def list_tasks
    @task_manager.list
  end

  def edit_task
    incorrect_input_count = 0

    loop do
      puts "Enter Task Id:"
      id = gets.chomp.to_i

      task = @task_manager.find_task(id)

      if task.nil?
        incorrect_input_count += 1
        if incorrect_input_count >= 3
          puts "OOPS!! TOO MANY INCORRECT INPUTS.MAKE CORRECT CHOICE AGAIN FROM MAINMENU"
          return
        end
        puts "INVALID TASK ID. Please try again."
        next
      end

      puts "Enter The New Task Content:"
      new_content = gets.chomp

      @task_manager.edit_task(id, new_content)
      break
    end
  end

  def mark_task_completed
    puts "Enter Task Id:"
    id = gets.chomp.to_i
    @task_manager.task_completed(id)
  end

  def delete_task
    puts "Enter Task Id:"
    id = gets.chomp.to_i
    @task_manager.delete_task(id)
  end

  def export_tasks
    puts "Enter File Name:"
    value = gets.chomp
    if value.strip.empty?
      puts "INVALID INPUT"
    else
      @task_manager.export(value)
      puts "TASKS EXPORTED TO #{value}.csv"
    end
  end

  def search_tasks
    puts "Enter Title to Search:"
    title = gets.chomp
    @task_manager.search(title)
  end
end

# Usage:
task_manager = TaskManager.new()
main_menu = MainMenu.new(task_manager)
main_menu.display