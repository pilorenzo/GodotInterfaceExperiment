class_name NodeExample extends Sprite2D


func method_with_arg(args: int) -> String:
    return str(args)

func some_method() -> NodeExample:
    return NodeExample.new()

func _process(_delta: float) -> void:
    pass

func present_method(_i : int) -> StringName:
    return "Present"
