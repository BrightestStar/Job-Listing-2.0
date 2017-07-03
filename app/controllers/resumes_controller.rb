class ResumesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def create
    @job = Job.find(params[:job_id])
    @resume = @job.resumes.new(resume_params)
    @resume.user = current_user

    if @resume.save
      redirect_to job_path(@job)
    else
      render :new
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:body, :attachment)
  end

end
