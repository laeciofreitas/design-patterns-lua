
from 'src' import 'Task'

class 'AddIngredients' extends 'Task'

	function AddIngredients()
		super(self, "add ingredients")
	end
	
	function this:duration()
		return 2
	end