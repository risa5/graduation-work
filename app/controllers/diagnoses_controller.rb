class DiagnosesController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def new
    @diagnosis_record = DiagnosisRecord.new
    @questions = Question.includes(:choices).all
    @questions.each do |_q|
      @diagnosis_record.diagnosis_answers.build
    end
  end

  def create
    submitted_answers = diagnosis_record_params[:diagnosis_answers_attributes]

    body_score = 0
    emotion_score = 0
    mind_score = 0

    diagnosis_answers = submitted_answers.map do |_, answer|
      question = Question.find(answer[:question_id])
      choice = Choice.find(answer[:choice_id])

      case question.fatigue_category
      when "body"
        body_score += choice.score
      when "emotion"
        emotion_score += choice.score
      when "mind"
        mind_score += choice.score
      end

      DiagnosisAnswer.new(
        question_id: question.id,
        choice_id: choice.id
      )
    end

    diagnosis_result = DiagnosisResult.find_by_pattern_code(
      determine_pattern_code(body_score, emotion_score, mind_score)
    )

    DiagnosisRecord.transaction do
      @diagnosis_record = DiagnosisRecord.create!(
        body_score: body_score,
        emotion_score: emotion_score,
        mind_score: mind_score,
        diagnosis_result_id: diagnosis_result.id,
        user_id: current_user&.id
      )

    diagnosis_answers.each do |answer|
      answer.diagnosis_record_id = @diagnosis_record.id
      answer.save!
    end
  end

  redirect_to diagnosis_path(@diagnosis_record)
rescue => e
  flash.now[:alert] = "診断の保存に失敗しました: #{e.message}"
  @questions = Question.includes(:choices).all
  @diagnosis_record ||= DiagnosisRecord.new
  @questions.each { @diagnosis_record.diagnosis_answers.build }
  render :new, status: :unprocessable_entity
end

  def show
    @diagnosis_record = DiagnosisRecord.find(params[:id])
    @diagnosis_result = @diagnosis_record.diagnosis_result
  end

  private

  def determine_pattern_code(body, emotion, mind)
    scores = { body: body, emotion: emotion, mind: mind }

    return "all_equal" if scores.values.uniq == [0]

    max_score = scores.values.max
    max_categories = scores.select { |_, v| v == max_score }.keys

    case max_categories
    when [:body]
      "body_only"
    when [:emotion]
      "emotion_only"
    when [:mind]
      "mind_only"
    when [:body, :emotion]
      "body_emotion"
    when [:mind, :emotion]
      "mind_emotion"
    when [:body, :mind]
      "body_mind"
    when [:body, :emotion, :mind]
      "all_equal"
    else
      "unknown"
    end
  end
 
  private

  def diagnosis_record_params
    params.require(:diagnosis_record).permit(
      diagnosis_answers_attributes: [:question_id, :choice_id]
    )
  end
end
