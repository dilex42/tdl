class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @project = Project.new
    @task = Task.new
  end

  def create
    @project = Project.new
    @project.title = 'Project #' + (Project.count+1).to_s
    @project.save
    redirect_to projects_path
  end

  def update
    @project = Project.find(params[:id])
    @project.title = params[:project][:title]
    if @project.save
      redirect_to projects_path
    else
      render '404'
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_path
  end
end
