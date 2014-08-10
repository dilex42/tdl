class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    @project = Project.new
    @task = Task.new
  end

  def create
    @project = Project.new
    @project.title = 'New Project'
    @project.save
    redirect_to projects_path
  end

  def update
    @project = Project.find(params[:id])
    @project.title = params[:project][:title]
    @project.save
    redirect_to projects_path
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_path
  end
end
