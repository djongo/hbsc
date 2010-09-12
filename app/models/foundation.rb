class Foundation < ActiveRecord::Base
  belongs_to :publication
  belongs_to :survey

  def survey_name
    survey.name if survey
  end
end
