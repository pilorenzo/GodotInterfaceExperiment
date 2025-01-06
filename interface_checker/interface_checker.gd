@tool
extends Node

@export var interfaces : Array[Script]
var interface_methods : Dictionary
var is_error : bool = false


func _ready() -> void:
    if(not Engine.is_editor_hint()):
        return

    # this signal is slow, is emitted only when another script is selected in the editor,
    # and don't know why but is not always emitted
    EditorInterface.get_script_editor().script_changed.connect(func (_s : Script) -> void:
        if get_tree() != null:
            check_interfaces())

    var temp_interface := Interface.new()
    interface_methods = get_methods_signatures(temp_interface)
    temp_interface.free()


func _notification(what : int) -> void:
    if not Engine.is_editor_hint():
        return
    match what:
        NOTIFICATION_APPLICATION_FOCUS_IN:
            check_interfaces()


func check_interfaces() -> void:
    is_error = false
    for script in interfaces:
        var interface_instance : Interface = script.new()
        var signatures_interface := get_methods_signatures(interface_instance)
        var implementations := get_tree().get_nodes_in_group(script.get_global_name())
        for node : Node in implementations:
            compare_method_signatures(signatures_interface, node, script.get_global_name())
        interface_instance.free()

    if is_error:
        printerr("Errors found when checking interfaces")


func get_methods_signatures(node: Object) -> Dictionary:
    var signatures := {}
    for method_info : Dictionary in node.get_method_list():
        if method_info.name not in interface_methods:
            signatures[method_info.name] = {
                "par": erase_name(method_info.args),
                "ret": method_info.return
            }

    return signatures


func compare_method_signatures(interface_info: Dictionary, node: Node, interface_name : StringName) -> void:
    var node_info := get_methods_signatures(node)
    var node_path := get_node_path(node)
    for method_name : String in interface_info.keys():
        var print_values := [method_name, interface_name, node_path]
        if not node.has_method(method_name):
            is_error = true
            print_rich("[color=salmon]Method [b]%s()[/b] of interface [b]%s[/b] not implemented for node [b]%s[/b].[/color]" % print_values)
        elif interface_info[method_name] != node_info[method_name]:
            is_error = true
            print_rich("[color=salmon]Method [b]%s()[/b] of interface [b]%s[/b] has wrong signature in node [b]%s[/b].[/color]" % print_values)


# There is probably a better way to do this
func get_node_path(node: Node) -> String:
    var root := get_tree().edited_scene_root
    var path : String = root.get_path_to(node)
    return (root.name + "/" + path) if path != "." else str(root.name)



# implementation of interface' method can have different names for parameters
func erase_name(args : Array[Dictionary]) -> Array[Dictionary]:
    for dict in args:
        dict.erase("name")
    return args
