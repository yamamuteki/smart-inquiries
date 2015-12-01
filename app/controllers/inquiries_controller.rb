class InquiriesController < ApplicationController
  skip_before_action :basic

  def show
  end

  def create
    @respondent = Respondent.find_by(uuid: params[:uuid])
    if @respondent.create_inquiry(content: params[:content].to_json)
      redirect_to inquiry_path(params[:uuid])
    else
      render :edit
    end
  end

  def edit
    @respondent = Respondent.find_by(uuid: params[:uuid])
    return redirect_to inquiry_path(params[:uuid]) if @respondent.inquiry
    @inquiry = Inquiry.new
  end
end
