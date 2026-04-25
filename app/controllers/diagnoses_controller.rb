class DiagnosesController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]
  helper_method :prepare_meta_tags

  def new
    @questions = Question.includes(:choices).all
    @diagnosis_record = DiagnosisRecord.new
    @questions.each { @diagnosis_record.diagnosis_answers.build }
  end

  def create
    answers = diagnosis_record_params[:diagnosis_answers_attributes]

    # 診断に失敗時に使用するインスタンス
    @questions = Question.includes(:choices).all
    @diagnosis_record = DiagnosisRecord.new
    @questions.each { @diagnosis_record.diagnosis_answers.build }

    # エラー表示 
    if answers.blank? || answers.values.any? { |ans| ans["choice_id"].blank? }
      @diagnosis_record.errors.add(:base, "すべての質問に回答してください")
      render :new, status: :unprocessable_entity
      return
    end

    # カテゴリごとの数値計算
    body_score    = total_score(answers.values, "body")
    emotion_score = total_score(answers.values, "emotion")
    mind_score    = total_score(answers.values, "mind")

    # パターン特定
    pattern_code     = determine_pattern_code(body_score, emotion_score, mind_score)

    # 結果特定
    diagnosis_result = DiagnosisResult.find_by!(pattern_code: pattern_code)

    # 結果保存
    @diagnosis_record = DiagnosisRecord.new(
      body_score:       body_score,
      emotion_score:    emotion_score,
      mind_score:       mind_score,
      diagnosis_result: diagnosis_result,
      user:             current_user
    )

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

    # エラー取得
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error "診断作成エラー: #{e.class} - #{e.message}"
      @questions = Question.includes(:choices).all
      render :new, status: :unprocessable_entity
  end


  def show
    @diagnosis_record = DiagnosisRecord.find(params[:id])
    @diagnosis_result = @diagnosis_record.diagnosis_result
    prepare_meta_tags(@diagnosis_result)
  
    text = "あなたの診断結果：#{@diagnosis_result.pattern_code}"
    url  = request.original_url
    @tweet_intent_url =
      "https://twitter.com/intent/tweet?text=#{ERB::Util.url_encode(text)}&url=#{ERB::Util.url_encode(url)}&hashtags=Healscan"
  end

  private

  # 許可するカラムの指定
  def diagnosis_record_params
    params.require(:diagnosis_record).permit(
      diagnosis_answers_attributes: [:question_id, :choice_id]
    )
  end

  # 各カテゴリの合計スコアを計算
  def total_score(answers, category)
    answers.sum do |ans|
      choice = Choice.find(ans["choice_id"])
      choice.question.fatigue_category == category ? choice.score : 0
    end
  end

  # パターン特定
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
