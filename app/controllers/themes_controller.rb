class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :update, :destroy]
  before_action :check_loged_in_user, only: [:create, :update, :destroy]
  

  include LessHelper
  # GET /themes/1
  def show
    render json: @theme, serializer: ActiveModel::Serializer::ThemeSerializer
  end

  # POST /themes
  def create
    theme = Theme.new(theme_params)
    if theme.save && to_less_file(theme)
      theme.url = to_less_file(theme)
      theme.save
      render json: theme, serializer: ActiveModel::Serializer::ThemeSerializer, status: :created
    else
      show_error(theme, :unprocessable_entity)
    end
  end

  # PATCH/PUT /themes/1
  def update
    if @theme.update_attributes(theme_params)&& !to_less_file(theme).nil?
      render json: theme, serializer: ActiveModel::Serializer::ThemeSerializer, status: :ok
    else
      show_error(@theme, :unprocessable_entity)
    end
  end

  # DELETE /themes/1
  def destroy
    destroyed = destroy_files(@theme)
    @theme.destroy if destroyed
    head 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      begin
        @theme = Theme.find params[:id]
      rescue ActiveRecord::RecordNotFound
        theme = Theme.new
        theme.errors.add(:id, "Undifined id")
        show_error(theme, 404) and return
      end
    end

    # Only allow a trusted parameter "white list" through.
    def theme_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end