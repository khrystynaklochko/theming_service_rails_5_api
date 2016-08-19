class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :check_loged_in_user, only: [:create, :update, :destroy]

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      show_error(@user, :unprocessable_entity)
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update_attributes(user_params)
      render json: @user, status: :created
    else
      show_error(@user, :unprocessable_entity)
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    head 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound 
        user = User.new
        user.errors.add(:id, "Undefined id")
        show_error(user, 404) and return
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end
