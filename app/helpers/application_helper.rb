module ApplicationHelper
  def sort_link_to(name, params, column)
    if params['sort_by'] == column
      order_by = params['order_by'] == 'ASC' ? 'DESC' : 'ASC'
    else
      order_by = 'ASC'
    end

    link_to(name, params.merge(sort_by: column, order_by: order_by))
  end
end
