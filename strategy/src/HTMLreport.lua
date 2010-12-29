
from 'src' import 'Formatter'

class 'HTMLreport' extends 'Formatter'

	function HTMLreport()
		super(self)
	end
	
	function this:print_report(report)
		print '<html>'
		print ' <head>'
		print (' <title>'.. report.title ..'</title>')
		print ' </head> '
		print ' <body> '
		for _, line in ipairs(report.text) do
			print (' <p>' .. line .. '<p> ')
		end
		print ' </body> '
		print '</html>'
		
	end
	