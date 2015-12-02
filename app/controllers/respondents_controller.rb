class RespondentsController < ApplicationController
  before_action :set_distribution, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_respondent, only: [:edit, :update, :destroy]

  def new
    @respondent = @distribution.respondents.build
  end

  def create
    emails = params[:emails].to_s.strip
    emails.each_line do |line|
      @distribution.respondents.create(email: line.strip)
    end
    redirect_to @distribution
  end

  def edit
  end

  def update
    if @respondent.update(respondent_params)
      redirect_to @distribution
    else
      render :edit
    end
  end

  def destroy
    @respondent.destroy!
    redirect_to @distribution
  end

  private

  def set_distribution
    @distribution = Distribution.find(params[:distribution_id])
  end

  def set_respondent
    @respondent = @distribution.respondents.find(params[:id])
  end

  def respondent_params
    params.require(:respondent).permit(:email)
  end
end
