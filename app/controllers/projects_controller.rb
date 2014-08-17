class ProjectsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :json, :js
  def index
    @projects = current_user.projects.all
  end

  def create
    @project = Project.new
    @project.title = 'New Project'
    @project.user = current_user
    if @project.save
      flash[:notice] = 'Project was successufully created'
      respond_with @project
    else
      redirect_to projects_path
    end
    
  end

  def update
    @project = Project.find(params[:id])
    if @project.user == current_user
      @project.title = params[:project][:title]
      if @project.save
        flash[:notice] = 'Project was successufully updated'
      end
    end
    respond_with @project
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.user == current_user
      if @project.destroy
        flash[:notice] = 'Project was successufully deleted'
      end
      respond_with @project
    else
      redirect_to projects_path
    end
  end
end
