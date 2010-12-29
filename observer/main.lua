dofile '../lib/LOS.lua'

from 'src' import 'Funcionario' 'Mensagem' 'Pagamento'

funcionario = Funcionario:new('Laécio', 'Universitario', 1100)
funcionario:add_observer(Mensagem:new())
funcionario:add_observer(Pagamento:new())
funcionario:set_salario(2000)