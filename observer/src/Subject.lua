module('Subject', package.seeall)
	
	observers = {}
	observer = nil
	
	function add_observer(self, obs)
		observer = self
		table.insert(observers, obs)
	end
	
	function delete_observer(observer)
		table.remove(observers, observer)
	end
	
	function notify_observers()
		for _, obs in ipairs(observers) do
			obs:update(observer)
		end
	end
