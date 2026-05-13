class OgpController < ApplicationController
  skip_before_action :require_login

  def diagnosis
    diagnosis = DiagnosisRecord.find(params[:id])
    diagnosis_result = diagnosis.diagnosis_result

    text = "あなたの診断結果：#{diagnosis_result.pattern_code}"

    image = OgpCreator.build(text)

    send_data image.to_blob,
              type: "image/png",
              disposition: "inline"
  end
end
