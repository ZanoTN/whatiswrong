class AppsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app, only: [ :edit, :update, :destroy, :regenerate_api_key ]

  def index
    @apps = App.order(:name)

    if params[:search].present?
      @apps = @apps.where("LOWER(name) LIKE ?", "%#{params[:search]}%")
    end

    @apps = @apps.page(params[:page]).per(20)
  end

  def edit
    render "_modal"
  end

  def update
    if @app.update(app_params)
      redirect_to apps_path, notice: t("custom.app.message.app_updated")
    else
      render "_modal", status: :unprocessable_entity
    end
  end

  def new
    @app = App.new
    render "_modal"
  end

  def create
    @app = App.new(app_params)
    if @app.save
      redirect_to edit_app_path(@app), notice: t("custom.app.message.app_created")
    else
      render "_modal", status: :unprocessable_entity
    end
  end

  def destroy
    @app.destroy
    redirect_to apps_path, notice: t("custom.app.message.app_deleted")
  end

  def regenerate_api_key
    @app.generate_api_key
    if @app.save
      flash[:notice] = t("custom.app.message.api_key_regenerated")
    else
      flash[:alert] = t("custom.app.message.api_key_not_regenerated")
    end
    redirect_to edit_app_path(@app)
  end

  private

  def app_params
    params.require(:app).permit(:name)
  end

  def set_app
    @app = App.find_by(id: params[:id])
    if @app.nil?
      redirect_to apps_path, alert: t("custom.app.message.app_not_found")
    end
  end
end
