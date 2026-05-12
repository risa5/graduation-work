class OgpController < ApplicationController
  skip_before_action :require_login

  def diagnosis
    diagnosis = DiagnosisRecord.find(params[:id])
    image = OgpCreator.build(diagnosis.diagnosis_result.title)
    send_data image.to_blob,
              type: 'image/png',
              disposition: 'inline'
  end
end