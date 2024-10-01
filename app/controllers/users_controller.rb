class UsersController < ApplicationController
  require_relative '../services/github_api'  # Adjust path as necessary

  def index
    github = GitHubAPI.new
    response = github.get_user(params[:username])
    
    if response.success?
      @user = response.parsed_response
    else
      flash[:alert] = 'Usuário não encontrado'
      redirect_to root_path
    end
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
