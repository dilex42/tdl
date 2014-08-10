class TasksController < ApplicationController

  before_action :find_project, only: [:create, :destroy, :priority] 
  before_action :find_task, only: [:update, :destroy, :priority, :deadline, :done]

  def find_project
    @project = Project.find(params[:project_id])
  end
  
  def find_task
    @task = Task.find(params[:id])
  end

  def create    
    @task = @project.tasks.new
    @task.text = params[:task][:text]
    @task.is_done = false
    @task.priority = @project.tasks.count+1
    @task.save 
    redirect_to projects_path
  end

  def update
    @task.text = params[:task][:text]
    @task.save
    redirect_to projects_path
  end

  def destroy
    @priority_destroy = @task.priority
    @tasks = @project.tasks.where("priority > ?", @priority_destroy)
    @tasks.each do |t|
      t.priority -= 1
      t.save
    end
    @task.destroy
    redirect_to projects_path
  end

  def priority
    if params[:where] == 'up'
      @priority = @task.priority
      unless @priority == 1
        @task_up = @project.tasks.where(priority: @priority-1).take
        @task.priority -= 1
        @task_up.priority += 1
        @task.save
        @task_up.save
      end
    end
    if params[:where] == 'down'
      @priority = @task.priority
      unless @priority == @project.tasks.count
        @task_down = @project.tasks.where(priority: @priority+1).take
        @task.priority += 1
        @task_down.priority -= 1
        @task.save
        @task_down.save
      end
    end
    redirect_to projects_path
  end

  def deadline
    @task.deadline = params[:task][:deadline]
    @task.save
    redirect_to projects_path
  end

  def done
    @task.is_done = true
    @task.save
    redirect_to projects_path
  end

end
