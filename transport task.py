# решение открытой/закрытой задачи 3x3
import numpy as np
from random import randint
import cvxopt
from cvxopt.modeling import variable, op

z = cvxopt.modeling._function()

c = []
supply = []
a = 3
b = 3
sumA = 0
sumB = 0
x = variable(9, 'x')

for i in range(a + b):
    supply.append(randint(20, 75))
    if (i < a):
        sumA += supply[i]
    if (i >= b):
        sumB += supply[i]
for i in range(a * b):
    c.append(randint(1, 9))

for i in range(a * b):
    z += c[i] * x[i]
# mainMass = []
# mainMass.append()


if (sumA > sumB):
    # for i in range(a + b):
    #     for i in range(a):

    mass1 = (x[0] + x[1] + x[2] <= supply[0])
    mass2 = (x[3] + x[4] + x[5] <= supply[1])
    mass3 = (x[6] + x[7] + x[8] <= supply[2])

    mass4 = (x[0] + x[3] + x[6] == supply[3])
    mass5 = (x[1] + x[4] + x[7] == supply[4])
    mass6 = (x[2] + x[5] + x[8] == supply[5])

if (sumA < sumB):
    mass1 = (x[0] + x[1] + x[2] == supply[0])
    mass2 = (x[3] + x[4] + x[5] == supply[1])
    mass3 = (x[6] + x[7] + x[8] == supply[2])
    mass4 = (x[0] + x[3] + x[6] <= supply[3])
    mass5 = (x[1] + x[4] + x[7] <= supply[4])
    mass6 = (x[2] + x[5] + x[8] <= supply[5])

x_non_negative = (x >= 0)
list = [mass1, mass2, mass3, mass4, mass5, mass6, x_non_negative]
problem = op(z, list)
problem.solve(solver='glpk')
print("Результат Xopt:")
for i in x.value:
    print(i)
print("Стоимость доставки:")
print(problem.objective.value()[0])

print("supply = ", supply)
