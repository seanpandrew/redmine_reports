require File.dirname(__FILE__) + '/../spec_helper'

def data(additional_data={})
  {
    "start_date"=>"2009-07-01",
    "end_date"=>"2009-07-31",
    "user_ids" => [""],
  }.merge(additional_data)
end

  

describe ActivityReport, '#fetch' do
  before(:each) do
    @current_user = mock_model(User, :id => 1)
    @another_user = mock_model(User, :id => 2)
    @users = [@current_user, @another_user]
    @users.stub!(:sort).and_return(@users)

    @events = [
               mock_model(Issue, :event_author => @current_user),
               mock_model(Issue, :event_author => @current_user),
               mock_model(Journal, :event_author => @another_user),
               mock_model(Journal, :event_author => @current_user)
              ]
    User.stub!(:active).and_return(@users)
  end

  def mock_fetcher
    @fetcher = Redmine::Activity::Fetcher.new(User.current)
    Redmine::Activity::Fetcher.should_receive(:new).and_return(@fetcher)
    @fetcher.stub!(:events).and_return(@events)
  end
  
  it 'should fetch all Activity data in the date range' do
    mock_fetcher
    @fetcher.should_receive(:events).with(data['start_date'], '2009-08-01').and_return(@events)
    activity = ActivityReport.new(data)
    activity.fetch
  end

  it 'should set @fetcher to the Redmine Activity Fetcher' do
    mock_fetcher
    activity = ActivityReport.new(data)
    activity.fetch
    activity.fetcher.should eql(@fetcher)
  end

  it 'should set @events' do
    mock_fetcher
    activity = ActivityReport.new(data)
    activity.fetch
    activity.events.should_not be_nil
    activity.events.size.should eql(4)
  end

end

describe ActivityReport, '#group_events_by_user' do

  it 'should set return the events grouped by user'

end
