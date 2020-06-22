class InvoicesController < ApplicationController
  before_action :set_invoices
  before_action :set_invoice, only: %i[show change_status remove_campaign]

  def index
    col_search = Invoice::SEARCHABLE
    @invoices  = filter_search(@invoices, col_search)
    @campaigns = get_campaigns
  end

  def create
    campaigns = Campaign.find(invoice_params[:campaign_ids])

    if campaigns.present?
      @invoice = @invoices.create
      @invoice.campaigns << campaigns
    end

    redirect_to invoice_path(@invoice)
  end

  def show
    @campaigns = @invoice.campaigns.page(params[:page]).per(params[:per])
  end

  def search_campaigns
    @campaigns = get_campaigns
  end

  def change_status
    @invoice.send("#{params[:event]}!")
    render :change_status
  rescue AASM::InvalidTransition
    update_alert('status')
    render 'layouts/alert'
  end

  def remove_campaign
    raise "Invoice must be in 'draft' status to be edited." unless @invoice.draft?

    @campaign = Campaign.find(params[:campaign_id])
    @invoice.campaigns.delete(@campaign)
  rescue => e
    @alert = e.message
    render 'layouts/alert'
  end

  private

  def set_invoices
    @invoices = Invoice.includes(:campaigns)
  end

  def set_invoice
    @invoice = @invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(campaign_ids: [])
  end

  def get_campaigns
    col_search = Campaign::SEARCHABLE
    statuses   = Invoice::FAIL_STATUS.join("', '")
    @campaigns = Campaign.includes(:line_items).left_joins(:invoices).where("invoices.id IS NULL OR invoices.status IN ('#{statuses}')")
    filter_search(@campaigns, col_search)
  end
end
