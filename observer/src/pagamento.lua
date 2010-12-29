
class 'Pagamento'

	function Pagamento()
	end
	
	function this:update(funcionario)
		print("Aumentado salário do " .. funcionario.nome)
		print("Seu novo salário é " .. funcionario.salario)
	end