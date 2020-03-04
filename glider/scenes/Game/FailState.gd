extends State

# This state gets activated when the player has failed for some reason.
class_name FailState

####################################################################################
# Signals

# Emitted when the player clicks the Main Menu button.
signal main_menu()
# Emitted when the player clicks the Try Again button.
signal try_again()

####################################################################################
# Constants

const PARAMS_REASON := "reason"


####################################################################################
# Scene Objects

onready var _reason_label: Label = $VBoxContainer/FailReasonLabel
onready var _focus_button: Button = $VBoxContainer/HBoxContainer/TryAgainButton


####################################################################################
# State

func state_started(prev_state: State, params: Dictionary) -> void:
    .state_started(prev_state, params)

    if params.has(PARAMS_REASON):
        if params[PARAMS_REASON] == Aircraft.State.EXPLODED:
            _reason_label.text = "Everyone's dead."
        elif params[PARAMS_REASON] == Aircraft.State.LEFT:
            _reason_label.text = "You bailed."

    _focus_button.grab_focus()


####################################################################################
# Event Handling

func _on_TryAgainButton_pressed() -> void:
    emit_signal("try_again")


func _on_MenuButton_pressed() -> void:
    emit_signal("main_menu")
