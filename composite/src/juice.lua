
from 'src' import 'Composite' 'AddIngredients' 'Mix'

class 'Juice' extends 'Composite'

	function Juice()
		super(self, "makes juice")
		super:add_subtask(AddIngredients:new())
		super:add_subtask(Mix:new())
	end
	