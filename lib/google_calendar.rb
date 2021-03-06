class GoogleCalendar

  def initialize(token)
    @client = Google::APIClient.new
    @client.authorization.access_token = token
    @calendar = @client.discovered_api('calendar', 'v3')
  end

  def new_orange_calendar
    @client.execute(:api_method => @calendar.calendars.insert,
                    :body => ActiveSupport::JSON.encode({:summary => 'Orange Planner'}),
                    :headers => {'Content-Type' => 'application/json'},
                    )
  end

  def find_calendar_id
    calendars_json = calendar_list.body
    parsed_calendars = ActiveSupport::JSON.decode(calendars_json)
    all_calendars = {}
    parsed_calendars['items'].each { |c| all_calendars[c['summary']] = c['id'] }
    new_orange_calendar unless all_calendars['Orange Planner'].present?
    all_calendars['Orange Planner']
  end

  def get_time_zone
    ActiveSupport::JSON.decode(@client.execute(api_method: @calendar.settings.get, :parameters => {'setting' => 'timezone'}).response.env[:body])['value']
  end


  def calendar_list
    @client.execute(
        :api_method => @calendar.calendar_list.list,
        :parameters => {},
        :headers => {'Content-Type' => 'application/json'})
  end

end