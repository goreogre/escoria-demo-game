## `dec_global name value`[br]
##[br]
## Subtracts the given value from the specified global.[br]
##[br]
## #### Parameters[br]
##[br]
## - name: Name of the global to be changed.[br]
## - value: Value to be subtracted (default: 1).
##[br]
## @ESC
extends ESCBaseCommand
class_name DecGlobalCommand


## Returns the descriptor of the arguments of this command.[br]
##[br]
## *Returns* The argument descriptor for this command.
func configure() -> ESCCommandArgumentDescriptor:
	return ESCCommandArgumentDescriptor.new(
		1,
		[TYPE_STRING, TYPE_INT],
		[null, 1]
	)


## Validates whether the given arguments match the command descriptor.[br]
##[br]
## #### Parameters[br]
##[br]
## - arguments: The arguments to validate.[br]
##[br]
## *Returns* True if the arguments are valid, false otherwise.
func validate(arguments: Array):
	if not super.validate(arguments):
		return false

	if not escoria.globals_manager.get_global(arguments[0]) is int:
		raise_error(self, "Invalid global. Global %s isn't an integer value." % arguments[0])
		return false

	return true


## Run the command
func run(command_params: Array) -> int:
	escoria.globals_manager.set_global(
		command_params[0],
		escoria.globals_manager.get_global(command_params[0]) - \
				command_params[1]
	)
	return ESCExecution.RC_OK


## Function called when the command is interrupted.
func interrupt():
	## Do nothing
	pass
