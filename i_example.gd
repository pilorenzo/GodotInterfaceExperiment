# You should add every interface like this to the
# exported interfaces Array in interface_checker.tscn
class_name IExample extends Interface


func method_with_arg(_args: float) -> String:
    return ""

func some_method() -> Sprite2D:
    return null

func absent_method() -> void:
    pass

func present_method(_i : int) -> StringName:
    return &""
