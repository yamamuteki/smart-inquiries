class RespondentsController < ApplicationController
  def new
    @distribution = Distribution.find(params[:distribution_id])
    @respondent = @distribution.respondents.build
  end

  def create
    distribution = Distribution.find(params[:distribution_id])
    emails = params[:emails].to_s.strip
    emails.each_line do |line|
      respondent = distribution.respondents.build
      respondent.email = line.strip
      respondent.uuid = SecureRandom.uuid
      respondent.save
    end
    redirect_to distribution
  end

  def edit
    @distribution = Distribution.find(params[:distribution_id])
    @respondent = @distribution.respondents.find(params[:id])
  end

  def update
    @distribution = Distribution.find(params[:distribution_id])
    @respondent = @distribution.respondents.find(params[:id])
    if @respondent.update(respondent_params)
      redirect_to @distribution
    else
      render :edit
    end
  end

  def destroy
    @distribution = Distribution.find(params[:distribution_id])
    @respondent = @distribution.respondents.find(params[:id])
    @respondent.destroy!
    redirect_to @distribution
  end

  private

  def respondent_params
    params.require(:respondent).permit(:email)
  end
end
