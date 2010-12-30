dofile '../lib/LOS.lua'


from 'src' import 'GlossOfJuice' 'Juice'


gloss_of_juice = GlossOfJuice:new()
print (gloss_of_juice:duration()) 

juice = Juice:new()
print(juice:duration())