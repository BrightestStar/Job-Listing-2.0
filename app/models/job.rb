class Job < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
  has_many :resumes

  def hide!
    self.is_hidden = true
    self.save
  end

  def public!
    self.is_hidden = false
    self.save
  end

end
