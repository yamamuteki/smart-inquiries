class InquiriesController < ApplicationController
  skip_before_action :basic
  before_action :set_respondent, only: [:create, :edit]

  def show
  end

  def create
    if @respondent.create_inquiry(content: params[:content].to_json)
      @respondent.update_answered_at
      redirect_to inquiry_path(params[:uuid])
    else
      render :edit
    end
  end

  def edit
    @respondent.update_accessed_at
    @inquiry = Inquiry.new
  end

  private

  def set_respondent
    @respondent = Respondent.find_by(uuid: params[:uuid])
    redirect_to inquiry_path(params[:uuid]) if @respondent.inquiry
  end
end
