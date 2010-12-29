

class 'Report'

	function Report(formatter)
		self.title = 'Relatorio mensal'
		self.text = {'Gastos do mês', 'Contas e mais contas'}
		self.formatter = formatter
	end
	
	function this:print_report()
		self.formatter:print_report(self)
	end
	