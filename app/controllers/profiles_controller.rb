class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[index, add]

  def index
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(pro_params)
    redirect_to '/posts'
  end

  def add
    @user_profile = Profile.find(params[:id])
    set_study_time(@user_profile)
    if @study_time.save
      render json: {
        study_time: @study_time
      }
    end
  end

  private

  def set_study_time(user_profile)
    @study_time = user_profile.study_id.study_time
    @study_time.attributes = {
      study_time: user_profile.study_time + params[:study_time]
    }
  end

  def pro_params
    params.require(:profile).permit(:name, :description, :occupation, :image)
  end
  
end
