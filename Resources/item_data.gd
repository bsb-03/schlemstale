extends Resource
class_name ItemResource

@export var name : String
@export_enum("Tool", "Consumable", "Material") var type : String
@export var icon : Texture2D
@export var stack_amt : int
@export var item_path : String
