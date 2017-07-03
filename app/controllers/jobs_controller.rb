class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])

    if current_user != @job.user
      redirect_to root_path
    end
  end

  def update
    @job = Job.find(params[:id])

    if current_user != @job.user
      redirect_to root_path
    end

    if @job.update(job_params)
      redirect_to job_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])

    if current_user != @job.user
      redirect_to root_path
    else
      @job.destroy
      redirect_to jobs_path
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description)
  end
end
