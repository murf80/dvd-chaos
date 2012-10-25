module DateSelectHelper

  # take the result of shared/date_select_partial form and return the datetime object
  def self.to_datetime date_result
    return Date.new(date_result['value(1i)'].to_i, date_result['value(2i)'].to_i, date_result['value(3i)'].to_i)
  end

end