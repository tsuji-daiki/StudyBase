class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @profile = Profile.find(params[:id])
    @study = @profile.user.studies
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(pro_params)
    redirect_to '/posts'
  end

  private

  def pro_params
    params.require(:profile).permit(:name, :description, :occupation, :image)
  end
  
end
