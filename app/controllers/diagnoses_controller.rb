# app/controllers/diagnoses_controller.rb
class DiagnosesController < ApplicationController
  # これでログインしていなくても new/create/show が使えます
  skip_before_action :require_login, only: %i[new create show]

  def new
    # 質問を全件、選択肢込みで取得
    @questions = Question.includes(:choices).all
    # レコードと answer の数だけダミーを build
    @diagnosis_record = DiagnosisRecord.new
    @questions.each { @diagnosis_record.diagnosis_answers.build }
  end

def create
  # ネストされた answers ハッシュを取り出す
  answers = diagnosis_record_params[:diagnosis_answers_attributes]

  # 各カテゴリのスコアを計算（配列化して渡す）
  body_score    = calculate_score(answers.values, "body")
  emotion_score = calculate_score(answers.values, "emotion")
  mind_score    = calculate_score(answers.values, "mind")

  # パターンコードを決定して master テーブルから結果を取得
  pattern_code     = determine_pattern_code(body_score, emotion_score, mind_score)
  diagnosis_result = DiagnosisResult.find_by!(pattern_code: pattern_code)

  # レコード本体を組み立て
  @diagnosis_record = DiagnosisRecord.new(
    body_score:       body_score,
    emotion_score:    emotion_score,
    mind_score:       mind_score,
    diagnosis_result: diagnosis_result,
    user:             current_user  # nil でも OK（optional: true）
  )

  # nested answers を build
  answers.values.each do |ans|
    @diagnosis_record.diagnosis_answers.build(
      question_id: ans["question_id"],
      choice_id:   ans["choice_id"]
    )
  end

  if @diagnosis_record.save
    redirect_to diagnosis_path(@diagnosis_record)
  else
    @questions = Question.includes(:choices).all
    render :new, status: :unprocessable_entity
  end
rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
  Rails.logger.error "診断作成エラー: #{e.class} - #{e.message}"
  @questions = Question.includes(:choices).all
  render :new, status: :unprocessable_entity
end


  def show
    @diagnosis_record = DiagnosisRecord.find(params[:id])
    @diagnosis_result = @diagnosis_record.diagnosis_result
  end

  private

  # params の許可
  def diagnosis_record_params
    params.require(:diagnosis_record).permit(
      diagnosis_answers_attributes: [:question_id, :choice_id]
    )
  end

  # 各カテゴリの合計スコアを計算
  def calculate_score(answers, category)
    answers.sum do |ans|
      choice   = Choice.find(ans["choice_id"])
      # fatigue_category は "body","emotion","mind" の文字列を返す enum
      choice.question.fatigue_category == category ? choice.score : 0
    end
  end
  
  # それぞれの値からパターンコードを返す
  def determine_pattern_code(body, emotion, mind)
    if body.zero? && emotion.zero? && mind.zero?
      "疲労なし"
    elsif body == emotion && emotion == mind
      "身体と心と脳の疲労"
    elsif body > emotion && body > mind
      "身体の疲労"
    elsif emotion > body && emotion > mind
      "心の疲労"
    elsif mind > body && mind > emotion
      "脳の疲労"
    elsif body == emotion && body > mind
      "身体と心の疲労"
    elsif body == mind && body > emotion
      "身体と脳の疲労"
    elsif emotion == mind && emotion > body
      "心と脳の疲労"
    else
      "疲労なし"
    end
  end
end
