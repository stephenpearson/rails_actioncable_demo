class ItemChannel < ApplicationCable::Channel
  def subscribed
    stream_from "item_events"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
