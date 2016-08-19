class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :update, :destroy]
  before_action :check_loged_in_user, only: [:create, :update, :destroy]

  # GET /themes/1
  def show
    render json: @theme, serializer: ActiveModel::Serializer::themeSerializer and return
  end

  # POST /themes
  def create
    theme = theme.new(theme_params)
    if theme.save
      
      render json: theme, status: :created
    else
      show_error(theme, :unprocessable_entity)
    end
  end

  # PATCH/PUT /themes/1
  def update
    if @theme.update_attributes(theme_params)
      render json: @theme, status: :ok
    else
      show_error(@theme, :unprocessable_entity)
    end
  end

  # DELETE /themes/1
  def destroy
    @theme.destroy
    head 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      begin
        @theme = theme.find params[:id]
      rescue ActiveRecord::RecordNotFound
        theme = theme.new
        theme.errors.add(:id, "Undifined id")
        show_error(theme, 404) and return
      end
    end

    # Only allow a trusted parameter "white list" through.
    def theme_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    end
end