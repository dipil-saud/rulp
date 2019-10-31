# Direct translation of the Whiskas Model 2 example from Pulp to Rulp
# https://github.com/coin-or/pulp/blob/master/examples/WhiskasModel2.py
#
# Usage: SOLVER=Cbc ruby whiskas_model2.rb
#
require_relative "../lib/rulp"

chicken = IV.new('Chicken', [])
beef = IV.new('Beef', [])
mutton = IV.new('Mutton', [])
rice = IV.new('Rice', [])
wheat = IV.new('Wheat', [])
gel = IV.new('Gel', [])

ingredients     = [chicken, beef, mutton, rice, wheat, gel]
costs           = {Chicken: 0.013, Beef: 0.008, Mutton: 0.010, Rice: 0.002, Wheat: 0.005, Gel: 0.001}
protein_percent = {Chicken: 0.100, Beef: 0.200, Mutton: 0.150, Rice: 0.000, Wheat: 0.040, Gel: 0.000}
fat_percent     = {Chicken: 0.080, Beef: 0.100, Mutton: 0.110, Rice: 0.010, Wheat: 0.010, Gel: 0.000}
fibre_percent   = {Chicken: 0.001, Beef: 0.005, Mutton: 0.003, Rice: 0.100, Wheat: 0.150, Gel: 0.000}
salt_percent    = {Chicken: 0.002, Beef: 0.005, Mutton: 0.007, Rice: 0.002, Wheat: 0.008, Gel: 0.000}

objective = ingredients.map{|i| costs[i.name.to_sym] * i}.inject(:+)
problem = Rulp::Min(objective)
problem[
  ingredients.inject(:+)                                      == 100,
  ingredients.map{|i| protein_percent[i.name.to_sym] * i}.inject(:+) >= 8.0,
  ingredients.map{|i| fat_percent[i.name.to_sym]     * i}.inject(:+) >= 6.0,
  ingredients.map{|i| fibre_percent[i.name.to_sym]   * i}.inject(:+) <= 2.0,
  ingredients.map{|i| salt_percent[i.name.to_sym]    * i}.inject(:+) <= 0.4
]

result = problem.solve

puts "Total Cost Per Can: #{result}"
puts
puts "Chicken: #{chicken.value}"
puts "Beef:    #{beef.value}"
puts "Mutton:  #{mutton.value}"
puts "Rice:    #{rice.value}"
puts "Wheat:   #{wheat.value}"
puts "Gel:     #{gel.value}"
