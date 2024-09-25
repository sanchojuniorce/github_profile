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
end
