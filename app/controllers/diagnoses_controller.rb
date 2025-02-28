class DiagnosesController < ApplicationController

  skip_before_action :require_login, only: %i[new create show]

  def new
    @diagnosis = Diagnosis.new
  end

  def create
    puts "DEBUG: Received Parameters -> #{params[:diagnosis].inspect}"

    # 診断結果を生成
    result = Diagnosis.determine_result(
      params[:diagnosis][:question1],
      params[:diagnosis][:question2],
      params[:diagnosis][:question3]
    )
    puts "DEBUG: Computed Result -> #{result.inspect}"

    # 診断データを保存
    @diagnosis = Diagnosis.new(diagnosis_params.merge(result: result))
    puts "DEBUG: Diagnosis Before Save -> #{@diagnosis.inspect}"

    if @diagnosis.save
      puts "DEBUG: Diagnosis Saved Successfully -> #{@diagnosis.inspect}"
      redirect_to diagnosis_path(@diagnosis)
    else
      puts "DEBUG: Errors -> #{@diagnosis.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end

  # 診断結果の表示
  def show
    @diagnosis = Diagnosis.find(params[:id])
  end

  private

  # ストロングパラメータの定義
  def diagnosis_params
    params.require(:diagnosis).permit(:question1, :question2, :question3)
  end
end
