
from 'src' import 'Subject'

class 'Funcionario' mixin 'Subject'

	function Funcionario(nome, titulo, salario)
		self.nome = nome
		self.titulo = titulo
		self.salario = salario
	end
	
	function this:set_salario(novo_salario)
		self.salario = novo_salario
		notify_observers()
	end