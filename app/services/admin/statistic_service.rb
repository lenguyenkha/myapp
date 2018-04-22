module Admin
  class StatisticService
    def render_data month, year
      return unless ((1..12).to_a.include? month) && ((start_year..Time.now.year).to_a.include? year)
      date = Date.new(year.to_i, month.to_i)
      start_point = date.to_time.to_i
      range_time = (date..date.end_of_month)
      load_data start_point, range_time
    end

    def start_year
      if Order.minimum(:created_at)
        Order.minimum(:created_at).year
      else
        Time.now.year
      end
    end

    private

    def load_data start_point, range_time
      array = []
      {accept: Order.accept, pending: Order.pending}.each do |name, orders|
        array << {
          name: name.to_s,
          pointInterval: (1.day * 1000).to_i,
          pointStart: start_point * 1000,
          data: range_time.map{|date| orders.total_on(date).to_f}
        }
      end
      array
    end
  end
end
