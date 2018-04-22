module Admin
  class StatisticsController < AdminBaseController
    def index
      statistic = Admin::StatisticService.new
      date = params[:date]
      @month, @year =
        if date
          [date[:month].to_i, date[:year].to_i]
        else
          [Time.now.month, Time.now.year]
        end
      @data = statistic.render_data @month, @year
      @start_year = statistic.start_year
    end
  end
end
