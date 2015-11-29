class DistributionsController < ApplicationController
  before_action :set_distribution, only: [:show, :edit, :update, :destroy]

  def index
    @distributions = Distribution.all
  end

  def show
  end

  def new
    @distribution = Distribution.new
  end

  def edit
  end

  def create
    @distribution = Distribution.new(distribution_params)
    if @distribution.save
      redirect_to distributions_path, notice: '作成しました。'
    else
      render :new
    end
  end

  def update
    if @distribution.update(distribution_params)
      redirect_to @distribution, notice: '更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @distribution.destroy
    redirect_to distributions_url, notice: '削除しました。'
  end

  private

  def set_distribution
    @distribution = Distribution.find(params[:id])
  end

  def distribution_params
    params.require(:distribution).permit(:name)
  end
end
