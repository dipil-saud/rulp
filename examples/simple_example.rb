require_relative "../lib/rulp"


Rulp::log_level = Logger::DEBUG

# maximize
#   objective = 10 * x + 6 * y + 4 * z
#
# subject to
#   p:      x +     y +     z <= 100
#   q: 10 * x + 4 * y + 5 * z <= 600
#   r:  2 * x + 2 * y + 6 * z <= 300
#
# where all variables are non-negative integers
#   x >= 0, y >= 0, z >= 0
#


x = IV.new('x', [])
y = IV.new('y', [])
z = IV.new('z', [])

Rulp::Max(objective = 10 * x + 6 * y + 4 * z) [
  x >= 0,
  y >= 0,
  z >= 0,
  x + y + z <= 100,
  10 * x + 4 * y + 5 *z <= 600,
  2 * x + 2* y + 6 * z <= 300
].glpk


result = objective.evaluate

##
# 'result' is the result of the objective function.
# You can retrieve the values of variables by using the 'value' method
# E.g
#   X_i.value == 32
#   Y_i.value == 67
#   Z_i.value == 0
##
