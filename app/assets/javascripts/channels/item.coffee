App.item = App.cable.subscriptions.create "ItemChannel",
  connected: ->
    console.log("Connected to ActionCable")

  disconnected: ->
    console.log("Disconnected from ActionCable")

  received: (data) ->
    if data.action is "create"
      attachNode(data.id, data.parent_id, data.name)
    else if data.action is "update"
      updateNode(data.id, data.parent_id, data.name)
    else if data.action is "delete"
      removeNode(data.id)
