class Item < ApplicationRecord
  has_many :children, class_name: "Item", foreign_key: 'parent_id'
  has_many :people, :dependent => :destroy

  after_create do
    ActionCable.server.broadcast("item_events", {
      :action => "create",
      :name => self.name,
      :id => self.id,
      :parent_id => self.parent_id
    })
  end

  after_update do
    ActionCable.server.broadcast("item_events", {
      :action => "update",
      :name => self.name,
      :id => self.id,
      :parent_id => self.parent_id
    })
  end

  before_destroy do |record|
    record.children.each do |child|
      child.destroy
    end
  end

  after_destroy do |record|
    ActionCable.server.broadcast("item_events", {
      :action => "delete",
      :id => record.id
    })
  end

  def leaf
    Item.where(:parent_id => self.id).count == 0 ? 1 : 0
  end

  def people_recursive
    child_map = Item.all.inject({}) do |a,v|
      a[v.parent_id] ||=[]
      a[v.parent_id] << v.id
      a
    end
    children_ids = ([self.id] + (recurse_children(self.id, child_map) || [])).sort
    Person.where(item_id: children_ids)
  end

  private
    def recurse_children(id, child_map)
      if child_map[id] then
        child_map[id].map do |c|
          [c, recurse_children(c, child_map)]
        end.flatten.compact
      end
    end
end
