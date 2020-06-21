class CampaignsController < ApplicationController
  before_action :set_campaigns
  before_action :set_campaign, only: %i[show change_status]

  def index
    if params[:search_text].present?
      sql_query  = query_str(Campaign::SEARCHABLE)
      @campaigns = @campaigns.where(sql_query)
    end

    if params[:sort_by].present?
      @campaigns = @campaigns.order("#{params[:sort_by]} #{params[:order_by] || 'asc'}")
    end

    @campaigns = @campaigns.page(params[:page]).per(params[:per])
  end

  def show
    @line_items = @campaign.line_items.page(params[:page]).per(params[:per])
  end

  def change_status
    @campaign.send("#{params[:event]}!")

    render :change_status
  rescue AASM::InvalidTransition
    update_alert('status')

    @alert += " Please make sure all line_items have been reviewed first."

    render 'layouts/alert'
  end

  private

  def set_campaigns
    @campaigns = Campaign.includes(:line_items)
  end

  def set_campaign
    @campaign = @campaigns.find(params[:id])
  end
end
