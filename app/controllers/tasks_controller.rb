class TasksController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json, :js
  before_action :find_project, only: [:create, :destroy, :priority, :deadline] 
  before_action :find_task, only: [:update, :destroy, :priority, :deadline, :done]
  before_action :access

  def find_project
    @project = Project.find(params[:project_id])
  end
  
  def find_task
    @task = Task.find(params[:id])
  end

  def access
    unless Project.find(params[:project_id]).user == current_user
      flash[:notice] = 'Unrecognized user'
      redirect_to projects_path
    end
  end


  def create    
    @task = @project.tasks.new
    @task.text = params[:task][:text]
    @task.is_done = false
    @task.priority = @project.tasks.count+1
    if @task.save
      flash[:notice] = 'Task was successufully created'
      respond_with @project
    else 
      redirect_to projects_path
    end
  end

  def update
    @task.text = params[:task][:text]
    if @task.save
      flash[:notice] = 'Task was successufully updated'
      respond_with @task
    else
      redirect_to projects_path
    end
  end

  def destroy
    @priority_destroy = @task.priority
    if @task.destroy
      @tasks = @project.tasks.where("priority > ?", @priority_destroy)
      @tasks.each do |t|
        t.priority -= 1
        t.save
      end
      flash[:notice] = 'Task was successufully deleted'
      respond_with @task
    else
      redirect_to projects_path
    end
  end

  def priority
    if params[:where] == 'up'
      @priority = @task.priority
      unless @priority == 1
        @task_up = @project.tasks.where(priority: @priority-1).take
        @task.priority -= 1
        @task_up.priority += 1
        if @task.save
          flash[:priority_down] = 'Success'
        end
        if @task_up.save
          flash[:priority_up] = 'Success'
        end
      end
    end
    if params[:where] == 'down'
      @priority = @task.priority
      unless @priority == @project.tasks.count
        @task_down = @project.tasks.where(priority: @priority+1).take
        @task.priority += 1
        @task_down.priority -= 1
        if @task.save
          flash[:priority_up] = 'Success'
        end
        if @task_down.save
          flash[:priority_down] = 'Success'
        end
      end
    end
    redirect_to projects_path
  end

  def deadline
    @task.deadline = params[:task][:deadline]
    if @task.save
      flash[:notice] = 'Deadline was successufully updated'
      respond_with(@project,@task)
    else
      redirect_to projects_path
    end
  end

  def done
    @task.is_done = true
    if @task.save
      flash[:notice] = 'Task is done'
      respond_with @task
    else
      redirect_to projects_path
    end
  end

end
