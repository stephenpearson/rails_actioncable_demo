json.extract! item, :id, :name, :parent_id, :created_at, :updated_at
json.leaf item.leaf == 0 ? false : true
