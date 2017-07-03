class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
            Job.where(:is_hidden => false).order('wage_lower_bound DESC')
            when 'by_upper_bound'
            Job.where(:is_hidden => false).order('wage_upper_bound DESC')
            else
            Job.where(:is_hidden => false).order("created_at DESC")
            end
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
