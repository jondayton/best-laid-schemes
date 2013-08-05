require 'pp'
require 'active_support/all'
class CalendarsController < ApplicationController


  def index
    current_user

    right_now = DateTime.now
    week_ago = Time.now - 7.days

    custom_start_month = DateTime.new(right_now.year, 7, 16)

    #@month_left = get_category_totals({timeMin: right_now.strftime("%FT%T%:z"),
    #                                   timeMax: right_now.at_beginning_of_month.next_month.strftime("%FT%T%:z")})
    #
    #@month_total = get_category_totals({timeMin: right_now.at_beginning_of_month.strftime("%FT%T%:z"),
    #                                    timeMax: right_now.at_beginning_of_month.next_month.strftime("%FT%T%:z")})
    #
    #@custom_left = get_category_totals({timeMin: custom_start_month,
    #                                    timeMax: right_now.at_beginning_of_month.next_month.strftime("%FT%T%:z")})

    #@custom_so_far = get_category_totals({timeMin: custom_start_month,
    #                                      timeMax: right_now})


    future = get_category_totals({timeMin: right_now,
                                      timeMax: right_now + 1.week})

    one_week_ago = get_category_totals({timeMin: right_now - 1.week,
                                          timeMax: right_now})

    two_weeks_ago = get_category_totals({timeMin: right_now - 2.weeks,
                                        timeMax: right_now - 1.week})

    @categories = Category.includes(:activities).all

    @time_periods = [future,one_week_ago,two_weeks_ago]

  end

end
