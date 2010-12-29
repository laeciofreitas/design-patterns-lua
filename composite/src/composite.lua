
from 'src' import 'Task'

class 'Composite' extends 'Task'
	
	function Composite(name)
		super(self, name)
		self.sub_tasks = {}
		sub_tasks = self.sub_tasks
	end
	
	function this:add_subtask(task)
		table.insert(sub_tasks, task)
	end
	
	function this:delete_subtask(task)
		table.remove(self.subtasks, task)
	end
	
	function this:duration()
		local time = 0
		for _, task in ipairs(sub_tasks) do
			for k,v in pairs(task) do
				print(k,v)
			end
			time = time + task:duration()
		end
		return time
	end
	
	