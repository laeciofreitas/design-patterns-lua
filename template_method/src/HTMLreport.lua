
from 'src' import 'Report'

class 'HTMLreport' extends 'Report'

	function HTMLreport()
		super(self)
	end
	
	function this:print_start()
		print '<html>'
	end
	
	function this:print_head()
		print ' <head>'
		print (' <title>'.. self.title ..'</title>')
		print ' </head> '
	end
	
	function this:print_body_start()
		print ' <body> '
	end
	
	function this:print_line(line)
		print (' <p>' .. line .. '<p> ')
	end
	
	function this:print_body_end()
		print ' </body> '
	end
	
	function this:print_end()
		print '</html>'
	end