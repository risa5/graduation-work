require "rails_helper"

RSpec.describe "Diagnoses", type: :request do
  describe "POST /diagnoses" do
    # diagnosis_resultデータを生成
    let!(:diagnosis_result) do
      DiagnosisResult.create!(
        pattern_code: "身体の疲労",
        result_summary: "身体の疲労が最も高いです",
        suggestion: "休息"
      )
    end

    # 9問分のquestionデータを生成
    let!(:question1) { Question.create!(fatigue_category: "body", question_content: "(body1)体がだるいですか？") }
    let!(:question2) { Question.create!(fatigue_category: "body", question_content: "(body2)眠れていますか？") }
    let!(:question3) { Question.create!(fatigue_category: "body", question_content: "(body3)食欲はありますか？") }
    let!(:question4) { Question.create!(fatigue_category: "emotion", question_content: "(emotion1)体がだるいですか？") }
    let!(:question5) { Question.create!(fatigue_category: "emotion", question_content: "(emotion2)眠れていますか？") }
    let!(:question6) { Question.create!(fatigue_category: "emotion", question_content: "(emotion3)食欲はありますか？") }
    let!(:question7) { Question.create!(fatigue_category: "mind", question_content: "(mind1)体がだるいですか？") }
    let!(:question8) { Question.create!(fatigue_category: "mind", question_content: "(mind2)眠れていますか？") }
    let!(:question9) { Question.create!(fatigue_category: "mind", question_content: "(mind3)食欲はありますか？") }

    # 9問分のchoiceデータを生成
    let!(:choice1) { Choice.create!(question: question1, choice_content: "とても感じる", score: 4) }
    let!(:choice2) { Choice.create!(question: question2, choice_content: "とても感じる", score: 4) }
    let!(:choice3) { Choice.create!(question: question3, choice_content: "とても感じる", score: 4) }
    let!(:choice4) { Choice.create!(question: question4, choice_content: "全くそう思わない", score: 0) }
    let!(:choice5) { Choice.create!(question: question5, choice_content: "全くそう思わない", score: 0) }
    let!(:choice6) { Choice.create!(question: question6, choice_content: "全くそう思わない", score: 0) }
    let!(:choice7) { Choice.create!(question: question7, choice_content: "全くそう思わない", score: 0) }
    let!(:choice8) { Choice.create!(question: question8, choice_content: "全くそう思わない", score: 0) }
    let!(:choice9) { Choice.create!(question: question9, choice_content: "そう思わない", score: 1) }

    # フォームから送信されるデータ生成
    let(:valid_params) do
      {
        diagnosis_record: {
          diagnosis_answers_attributes: {
            "0" => { question_id: question1.id, choice_id: choice1.id },
            "1" => { question_id: question2.id, choice_id: choice2.id },
            "2" => { question_id: question3.id, choice_id: choice3.id },
            "3" => { question_id: question4.id, choice_id: choice4.id },
            "4" => { question_id: question5.id, choice_id: choice5.id },
            "5" => { question_id: question6.id, choice_id: choice6.id },
            "6" => { question_id: question7.id, choice_id: choice7.id },
            "7" => { question_id: question8.id, choice_id: choice8.id },
            "8" => { question_id: question9.id, choice_id: choice9.id }
          }
        }
      }
    end

    # 【テスト１】全問解答時、診断結果のレコードが1件増える・結果表示画面へリダイレクトされる・結果の計算が正しく、結果が身体の疲労になる
    it "全問回答時、診断レコードが作成される" do
      expect {
        post diagnoses_path, params: valid_params
      }.to change(DiagnosisRecord, :count).by(1)

      expect(response).to redirect_to(diagnosis_path(DiagnosisRecord.last))

      record = DiagnosisRecord.last

      expect(record.body_score).to eq 12
      expect(record.emotion_score).to eq 0
      expect(record.mind_score).to eq 1
      expect(record.diagnosis_result.pattern_code).to eq "身体の疲労"
    end

    # 【テスト２】未回答時、診断結果のレコード数が変わらない・HTTPステータスが422
    it "未回答があると診断レコードが作成されない" do
      invalid_params = {
        diagnosis_record: {
          diagnosis_answers_attributes: {
            "0" => { question_id: question1.id, choice_id: choice1.id },
            "1" => { question_id: question2.id, choice_id: choice2.id },
            "2" => { question_id: question3.id, choice_id: choice3.id },
            "3" => { question_id: question4.id, choice_id: choice4.id },
            "4" => { question_id: question5.id, choice_id: choice5.id },
            "5" => { question_id: question6.id, choice_id: choice6.id },
            "6" => { question_id: question7.id, choice_id: choice7.id },
            "7" => { question_id: question8.id, choice_id: choice8.id },
            "8" => { question_id: question9.id, choice_id: "" }
          }
        }
      }

      expect {
        post diagnoses_path, params: invalid_params
      }.not_to change(DiagnosisRecord, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
