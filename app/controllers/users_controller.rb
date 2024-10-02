class UsersController < ApplicationController
  require_relative '../services/github_scraper'  # Adjust path as necessary

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      scraper = GithubScraper.new(@user.name)
      github_data = scraper.scrape
      @user.update(github_data)
      redirect_to users_path, notice: 'Usuário criado com sucesso.'
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :address_web, 
      :github_username, :followers, :following,
      :stars, :contributions, :profile_image_url,
      :organization, :location
    ) if params[:user].present?
  end
end
