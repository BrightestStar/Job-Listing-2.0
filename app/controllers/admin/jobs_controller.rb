class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :admin_required
  layout "admin"

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
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def show
    @job = Job.find(params[:id])
    @resumes = @job.resumes
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
      redirect_to admin_job_path
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
      redirect_to admin_jobs_path
    end
  end

  def hide
    @job = Job.find(params[:id])

    @job.hide!

    redirect_to request.referer
  end

  def public
    @job = Job.find(params[:id])

    @job.public!

    redirect_to request.referer
  end


  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden)
  end
end
