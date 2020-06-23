class InvoicesController < ApplicationController
  before_action :set_invoices
  before_action :set_invoice, only: %i[show update change_status remove_campaign]
  before_action :set_new_campaigns, only: %i[create update]

  def index
    col_search = Invoice::SEARCHABLE
    @invoices  = filter_search(@invoices, col_search)
  end

  def create
    if @new_campaigns.present?
      @invoice = @invoices.create
      @invoice.campaigns << @new_campaigns
    end

    redirect_to invoice_path(@invoice)
  end

  def show
    @campaigns = sort_by(@invoice.campaigns)
    @campaigns = @campaigns.page(params[:page]).per(params[:per])

    respond_to do |format|
      format.html
      format.xlsx do
        headers['Content-Disposition'] = "attachment; filename=\"invoice-#{DateTime.current.strftime('%Q')}.xlsx\""
        headers['Content-Type'] ||= 'text/xlsx'
      end
    end
  end

  def update
    @invoice.campaigns << @new_campaigns if @new_campaigns.present?

    redirect_to invoice_path(@invoice)
  end

  def search_campaigns
    @select_campaigns = select_campaigns
  end

  def change_status
    @invoice.send("#{params[:event]}!")

    redirect_to invoice_path(@invoice)
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
    @invoices = Invoice.includes(campaigns: :line_items)
  end

  def set_invoice
    @invoice = @invoices.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(campaign_ids: [])
  end

  def select_campaigns
    col_search  = Campaign::SEARCHABLE
    has_invoice = Campaign.left_joins(:invoices).where(invoices: {status: Invoice::OK_STATUS}).pluck(:id)
    campaigns   = Campaign.includes(:line_items)
                          .left_joins(:invoices)
                          .where("invoices.id IS NULL OR campaigns.id NOT IN (#{has_invoice.join(', ')})")
                          .distinct

    filter_search(campaigns, col_search)
  end

  def set_new_campaigns
    @new_campaigns = Campaign.find(invoice_params[:campaign_ids])
  end
end
