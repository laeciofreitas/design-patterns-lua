dofile '../lib/LOS.lua'


from 'src' import 'Report' 'HTMLreport'

report = Report:new(HTMLreport:new())
report:print_report()
