module NoValueHelper

  @@no_value_text = lambda { %Q{<em class="no_value">#{I18n.t(:no_value, :default => "no value")}</em>} }
  @@no_value_check_method = :blank?

  def display(*args, &block)
    if block_given?
      value = yield
    else
      value = args.shift
    end
    if value.send(@@no_value_check_method)
      @@no_value_text.call
    else
      if method = args.shift
        send(method, value, *args)
      else
        value
      end
    end
  rescue NoMethodError
    @@no_value_text.call
  end

end
