extends MarginContainer

var last_href = ''
var route_depth = 0

func _process(delta):
  var href = RouteStore.href()

  if href != last_href:
    last_href = href
    __route()
    on_route()

# By default, the route container is an immediate child node named Route.
# Override if the route container lives elsewhere in this node's children tree.
# Leaf routers don't have child routes, so don't need to implement this.
func get_route_container():
  return $Route

# Most extending classes should implement this function!
# It must return a PackedScene that also extends Router.
# Only the leaf router nodes in the route tree shouldn't implement this.
func get_route_scene(node):
  pass

# Will be called when routing occurs and the Router is done with its magic. 
# Override to run stuff at that point in time.
func on_route():
  pass

func __route():
  var node = RouteStore.get_route_node(route_depth)

  var scene = get_route_scene(node)

  if !scene: return
  
  var routeContainer = get_route_container()
  var scene_instance = scene.instance()
  scene_instance.route_depth = route_depth + 1

  routeContainer.remove_child(routeContainer.get_child(0))
  routeContainer.add_child(scene_instance)