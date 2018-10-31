extends Node

var history = ['/city']

func assign(target):
  history.push_back(target)

func back():
  if history.size() > 1:

    history.pop_back()

func get_route_node(position):
  var nodes = href().split('/')

  nodes.remove(0) # remove the first empty node

  if (nodes.size() <= position): return ''

  return nodes[position]

func href():
  return history[history.size() - 1]

func replace(target):
  history.pop_back()
  history.push_back(target)