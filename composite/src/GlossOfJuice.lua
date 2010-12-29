from 'src' import 'Composite' 'Juice' 'DecoreJuice'

class 'GlossOfJuice' extends 'Composite' 

	function GlossOfJuice()
		super(self, "Gloss os juice")
		add_subtask(Juice:new())
		super:add_subtask(DecoreJuice:new())
	end