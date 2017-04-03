class PersonChannel < ApplicationCable::Channel
  def subscribed
    stream_from "person_events_#{params['item_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
