class Person < ApplicationRecord
  belongs_to :item

  after_create do
    ActionCable.server.broadcast("person_events_#{self.item_id}", {
      :action => "create",
      :name => self.name,
      :job => self.job,
      :beer => self.beer,
      :id => self.id,
      :item_id => self.item_id
    })
  end

  after_update do
    ActionCable.server.broadcast("person_events_#{self.item_id}", {
      :action => "update",
      :name => self.name,
      :job => self.job,
      :beer => self.beer,
      :id => self.id,
      :item_id => self.item_id
    })
  end

  after_destroy do |record|
    ActionCable.server.broadcast("person_events_#{self.item_id}", {
      :action => "delete",
      :id => record.id
    })
  end
end
