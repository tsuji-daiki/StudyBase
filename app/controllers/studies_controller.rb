class StudiesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @user = current_user
    @user_study = @user.studies
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

  def set_study(user)
    @date = Date.today
    @study_date = @date.strftime("%Y/%m/%d")
    if Study.where(user_id: user.id, study_date: @study_date).exists?
      @study = user.studies.find_by(user_id: user.id)
      @study.attributes = {
        study_time: @study.study_time + params[:study_time]
      }
    else
      @study = user.studies.build(
        study_time: params[:study_time],
        study_date: @study_date
        # total_time: params[:study_time]
      )
    end
  end
end
