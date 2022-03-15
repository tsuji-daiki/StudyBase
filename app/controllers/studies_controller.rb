class StudiesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @user = current_user
    @user_study = @user.studies.where("created_at > ?",Time.now.beginning_of_day).first
  end

  def create
    @user = current_user
    set_study(@user)
    if @study.save
      render json: {
        study_time: @study_time
      }, status: :created
    else
      render json: {}, status: :internal_server_error
    end
  end

  private

  def change_study(study_time)
    if study_time > 3600 #時間への変換
      @Htime = study_time / 3600
      @hour_time = @Htime.floor
      @Mtime = study_time - @hour_time * 3600 / 60
      @minute_time = @Mtime.floor
    else  #分数への変換 60以下は0にする（保存しない）
      @hour_time = 0
      @Mtime = study_time / 60
      @minute_time = @Mtime.floor
    end
  end

  def carry_study()
    @minute_time_add = @study.minute_time + @minute_time
    if @minute_time_add > 60
      @Htime = @minute_time_add / 60
      @carry_hour_time = @Htime.floor 
      @carry_minute_time = @minute_time_add - @carry_hour_time * 60 
    else
      @carry_minute_time = 0
      @carry_hour_time = 0
    end
  end

  def set_study(user)
    @date = Date.today
    @study_date = @date.strftime("%Y/%m/%d")
    @study_time = params[:study_time]
    change_study(@study_time)
    if Study.where(user_id: user.id, study_date: @study_date).exists?
      @study = user.studies.find_by(user_id: user.id, study_date: @study_date)
      carry_study() #勉強時間の繰り上げ
      binding.pry
      @study.attributes = {
        hour_time: @study.hour_time + @hour_time + @carry_hour_time ,
        minute_time: @study.minute_time + @minute_time + @carry_minute_time,
        total_time: @study.total_time + @study_time
      }
    else
      @study = user.studies.build(
        study_date: @study_date, #勉強した日付
        hour_time: @hour_time, #勉強した時数
        minute_time: @minute_time, #勉強した分数
        total_time: @study_time #総勉強時間（秒数）
      )
    end
  end
end
