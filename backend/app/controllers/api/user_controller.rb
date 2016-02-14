# Modified from https://github.com/kirandc/rails4_crud_with_angularjs/blob/master/app/controllers/users_controller.rb
class Api::UserController < ApplicationController
  before_action :get_user, except: [:index, :create]
  respond_to :html, :json

  def index
    @user = User.all
    respond_with(@users) do |format|
      format.json { render :json => @user.as_json }
      format.html
    end
  end

  def create
    # sometype of problem with user_params
    puts 'this should not be empty:'
    puts user_params
    @user = User.new(user_params, password_digest:'pword')
    #@user = User.new(username: 'testUserss', password: 'testPassword', email: 'testEmail@email.com', password_digest: 'pword' )
    puts 'in user create'
    if @user.save
      render json: @user.as_json, status: :ok
    else
      render json: {user: @user.errors, status: :no_content}
    end
  end

  def show
    respond_with(@user.as_json)
  end

  def update
    if @user.update_attributes(user_params)
      render json: @user.as_json, status: :ok
    else
      render json: {user: @user.errors, status: :unprocessable_entity}
    end
  end

  def destroy
    @user.destroy
    render json: {status: :ok}
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:username, :password, :password_digest)
  end

  def get_user
    @user = User.find(params[:username])
    render json: {status: :not_found} unless @user
  end

end
