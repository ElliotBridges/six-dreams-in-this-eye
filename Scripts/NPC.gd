extends Spatial

var active = false
var active_body = null
var wait_timer = 0
var dialoge_pointer = 0

var dialoge = ['NPCDefault']

var dialogNode = null

func _ready():
	dialoge_pointer = Mind.npc_dialoge_pointer[Mind.in_room][int(self.name)]

func talk():
	if wait_timer <= 0 and not Player.paused and dialoge_pointer < 6:
		var dialog = Dialogic.start(dialoge[dialoge_pointer])
		dialog.connect('timeline_end', self, 'unpause')
		add_child(dialog)
		dialogNode = dialog
		Player.paused = true
		
		var head=$Head
		Player.get_node("Head").look_at(head.global_transform.origin, Vector3.UP)
		
		Mind.talkingNode = self
		
func stop_talking():
	
	if dialogNode != null:
		dialogNode.queue_free()
		dialogNode = null
	unpause('')
	#et_node('DialogNode').queue_free()

func unpause(timeline_name):
	#get_tree().paused = false
	Player.paused = false
	Player.get_node("Head").rotation.y = 0
	wait_timer = 10
	dialogNode = null
	Mind.talkingNode = null
	next_dialoge()
	#Mind.save_game()
	
func next_dialoge():
	dialoge_pointer += 1
	dialoge_pointer = clamp(dialoge_pointer, 0, dialoge.size() - 1)
	Mind.npc_dialoge_pointer[Mind.in_room][int(self.name)] = dialoge_pointer

func _process(delta):
	wait_timer -= 1
	#$Label.text = String(dialoge_pointer)
