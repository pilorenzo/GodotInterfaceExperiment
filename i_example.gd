class_name IExample extends Interface


func method_with_arg(args: float) -> String:
    return str(args)

func some_method() -> Sprite2D:
    return Sprite2D.new()

func absent_method() -> void:
    pass

func present_method(i : int) -> StringName:
    return str(i)
