class DistributionsController < ApplicationController
  before_action :set_distribution, only: [:show, :edit, :update, :destroy, :send_email]

  def index
    @distributions = Distribution.all
    respond_to do |format|
      format.html
      format.csv do
        filename = "#{Time.zone.now.strftime('%Y%m%d%H%M%S')}_answered_all.csv"
        send_data Distribution.answered_csv_all, filename: filename, type: 'text/csv'
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.csv do
        filename = "#{Time.zone.now.strftime('%Y%m%d%H%M%S')}_answered_#{@distribution.name}.csv"
        send_data @distribution.answered_csv, filename: filename, type: 'text/csv'
      end
    end
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
      flash.now[:alert] = '入力内容をご確認ください。'
      render :new
    end
  end

  def update
    if @distribution.update(distribution_params)
      redirect_to @distribution, notice: '更新しました。'
    else
      flash.now[:alert] = '入力内容をご確認ください。'
      render :edit
    end
  end

  def destroy
    @distribution.destroy
    redirect_to distributions_url, notice: '削除しました。'
  end

  def send_email
    @distribution.not_answered_respondents.each do |respondent|
      InquiryMailer.request_email(respondent).deliver_now
      respondent.update_sent_attributes
    end
    redirect_to @distribution, notice: 'メールを送信しました。'
  end

  private

  def set_distribution
    @distribution = Distribution.find(params[:id])
  end

  def distribution_params
    params.require(:distribution).permit(:name)
  end
end
