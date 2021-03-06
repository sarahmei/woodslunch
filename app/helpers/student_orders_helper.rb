module StudentOrdersHelper

  include OrdersHelper

  def link_to_current_student_order(student, options={})
    options.reverse_merge!(:text => "Lunch order for #{student.name}")
    date = first_available_order_date
    month = date.month
    year = date.year
    path = student_orders_path(student, :year => year, :month => month)
    link_to(options[:text], path)
  end

  def link_to_student_month_order(student, date)
    month = date.month
    year = date.year
    path = student_orders_path(student, :year => year, :month => month)
    link_text = date.strftime('%B orders')
    link_to(link_text, path)
  end
end
