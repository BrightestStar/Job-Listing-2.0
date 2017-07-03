module JobsHelper
  def render_job_status(job)
    if job.is_hidden
      content_tag(:span, "", :class => "fa fa-low-vision")
    else
      content_tag(:span, "", :class => "fa fa-globe" )
    end
  end
end
