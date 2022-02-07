class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update(pro_params)
    redirect_to '/posts'
  end

  # def new
  #   @profile = Profile.new
  # end

  # def create
    
  # end

  private
  def pro_params
    params.require(:profile).permit(:name, :description, :occupation, :image)
  end
  
end
