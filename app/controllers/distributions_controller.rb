class DistributionsController < ApplicationController
  before_action :set_distribution, only: [:show, :edit, :update, :destroy]

  # GET /distributions
  def index
    @distributions = Distribution.all
  end

  # GET /distributions/1
  def show
  end

  # GET /distributions/new
  def new
    @distribution = Distribution.new
  end

  # GET /distributions/1/edit
  def edit
  end

  # POST /distributions
  def create
    @distribution = Distribution.new(distribution_params)

    if @distribution.save
      redirect_to distributions_path, notice: '作成しました。'
    else
      render :new
    end
  end

  # PATCH/PUT /distributions/1
  def update
    if @distribution.update(distribution_params)
      redirect_to @distribution, notice: '更新しました。'
    else
      render :edit
    end
  end

  # DELETE /distributions/1
  def destroy
    @distribution.destroy
    redirect_to distributions_url, notice: '削除しました。'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_distribution
    @distribution = Distribution.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def distribution_params
    params.require(:distribution).permit(:name)
  end
end
