

class 'Report'

	function Report()
		self.title = 'Relatorio mensal'
		self.text = {'Gastos do mês', 'Contas e mais contas'}
	end
	
	function this:print_report()
		self:print_start()
		self:print_head()
		self:print_body_start()
		self:print_body()
		self:print_body_end()
		self:print_end()
	end
	
	function this:print_body()
		for _, line in pairs(self.text) do
			self:print_line(line)
		end
	end