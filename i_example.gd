# You should add every interface like this to the
# exported interfaces Array in interface_checker.tscn
class_name IExample extends Interface


func method_with_arg(args: float) -> String:
    pass

func some_method() -> Sprite2D:
    pass

func absent_method() -> void:
    pass

func present_method(i : int) -> StringName:
    pass
