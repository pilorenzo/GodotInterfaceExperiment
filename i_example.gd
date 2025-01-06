class_name IExample extends Interface

func some_method() -> Sprite2D:
    return Sprite2D.new()

func method_with_arg(args: float) -> String:
    return str(args)

func absent_method() -> void:
    pass

func present_method(i : int) -> StringName:
    return str(i)
