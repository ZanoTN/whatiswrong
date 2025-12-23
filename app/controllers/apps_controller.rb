class AppsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_app, only: [ :edit, :update, :destroy, :regenerate_api_key ]

  def index
    @apps = App.order(:name)

    if params[:search].present?
      @apps = @apps.where("name ILIKE ?", "%#{params[:search]}%")
    end

    @apps = @apps.page(params[:page]).per(20)
  end

  def edit
  end

  def update
    if @app.update(app_params)
      redirect_to apps_path, notice: "App updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)
    if @app.save
      redirect_to edit_app_path(@app), notice: "App created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @app.destroy
    redirect_to apps_path, notice: "App deleted successfully."
  end

  def regenerate_api_key
    @app.generate_api_key
    if @app.save
      flash[:notice] = "API key regenerated successfully."
    else
      flash[:alert] = "Failed to regenerate API key."
    end
    redirect_to edit_app_path(@app)
  end

  def api_docs
    @key = params[:key]
    @app_url = request.base_url
  end

  private

  def app_params
    params.require(:app).permit(:name)
  end

  def set_app
    @app = App.find(params[:id])
    if @app.nil?
      redirect_to apps_path, alert: "App not found."
    end
  end
end
