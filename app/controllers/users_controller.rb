class UsersController < ApplicationController
  require_relative '../services/github_scraper'
  before_action :set_user_params, only: %i[destroy profile edit update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end  

  def new
    @user = User.new
  end

  def profile end

  def edit end

  def create
    @user = User.new(user_params)
    if @user.save
      github_scraper
      redirect_to users_path, notice: 'Usuário criado com sucesso.'
    else
      render :new
    end
  end

  def update
    binding.pry
    if @user.update(user_params)
      github_scraper
      redirect_to users_path, notice: 'Usuário atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    redirect_to users_path, notice: 'Usuário deletado com sucesso.' if @user.destroy
  end

  private

  def set_user_params
    @user = User.find(params[:id]) if params[:id]
  end

  def user_params
    params.require(:user).permit(:name, :address_web, 
      :github_username, :followers, :following,
      :stars, :contributions, :profile_image_url,
      :organization, :location
    ) if params[:user].present?
  end

  def github_scraper
    scraper = GithubScraper.new(@user.name)
    github_data = scraper.scrape
    @user.update(github_data)
  end
end
