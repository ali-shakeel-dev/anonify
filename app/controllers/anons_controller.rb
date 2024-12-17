class AnonsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  before_action :set_anon, only: [:edit, :update, :destroy]
  before_action :authorize_anon, only: [:edit, :update, :destroy]
  
  def index
    @anons = Anon.all
  end

  def show
    @anon = Anon.find(params[:id])
    @anons = Anon.all
    @comments = @anon.comments
  rescue ActiveRecord::RecordNotFound
    redirect_to anons_path, alert: "Anon not found."
  end

  def new
    @anon = Anon.new
  end

  def edit
    @anon = Anon.find(params[:id])
  end

  def create
    @anon = current_user.anons.build(anon_params)

    if @anon.save
      redirect_to @anon, notice: "Anon was successfully created."
    else
      render :new
    end
  end
  
  def update
    @anon = Anon.find(params[:id])
    if @anon.update(anon_params)
      redirect_to @anon, notice: 'Anon was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @anon = Anon.find(params[:id]) 
    
    @anon.destroy!
  
    respond_to do |format|
      format.html { redirect_to anons_url, notice: "Anon was successfully destroyed." }
      format.json { head :no_content }
    end
    rescue ActiveRecord::RecordNotFound
      redirect_to anons_url, alert: "Anon not found."
    rescue ActiveRecord::RecordNotDestroyed
      redirect_to anons_url, alert: "Failed to destroy the anon."
  end  

  private
    def set_anon
      @anon = Anon.find(params[:id])
    end

    def authorize_anon
      redirect_to anons_path, alert: "You are not authorized to perform this action." unless @anon.user == current_user
    end

    def anon_params
      params.require(:anon).permit(:title, :description)
    end

    def require_login
      unless current_user
        redirect_to signup_path, alert: "You must be logged in to create an anon."
      end
    end

    # def authenticate_user
    #   unless current_user
    #     redirect_to signup_path, alert: "Please sign up before creating an anon."
    #   end
    # end
end
