{
  library("lpSolve")
  m = as.integer(readline('введите кол-во складов(через Enter):'))
  n = as.integer(readline('введите кол-во потребителей(через Enter):'))
  
  #вводим кол-во поставляемого товара
  SumA <- c() #задаем пустой вектор, куда будем добавлять значения
  a <- m
  while (a>0){
    b <- readline('введите кол-во запасов на складах(через Enter):')
    SumA <- append(b, SumA)
    a <- a-1
  }
  SumA <- rev(as.numeric(SumA))

    #вводим кол-во потребляемого товара
  SumB <- c() #задаем пустой вектор, куда будем добавлять значения
  c <- n
  while (c>0){
    g <- readline('введите кол-во требуемого товара(через Enter):')
    SumB <- append(g, SumB)
    c <- c-1
  }
  SumB <- rev(as.numeric(SumB)) #переворачиваем вектор
  
  matr <- c() #задаем пустой вектор, куда будем добавлять значения матрицы
  count <- m*n
  while (count>0){
    b <- readline('введите значения тарифов построчно(через Enter):')
    matr <- append(b, matr)
    count <- count-1
  }
  matr <- rev(as.numeric(matr)) #переворачиваем вектор
  P = matrix(matr,ncol = n, nrow = m, byrow=TRUE)
  if (sum(SumA)==sum(SumB)){
    print('ТРАНСПОРТНАЯ ЗАДАЧА ЗАКРЫТОГО ТИПА')
    SignA <- rep("==", m)
    SignB <- rep("==", n)
    M.Tr <- lp.transport(cost.mat = P, direction = "min",
                         
                         row.signs = SignA, row.rhs = SumA,
                         
                         col.signs = SignB, col.rhs = SumB)
  }else{
    print('ТРАНСПОРТНАЯ ЗАДАЧА ОТКРЫТОГО ТИПА')
    if (sum(SumA)>sum(SumB)){
      SignA <- rep("<=", m)
      SignB <- rep("==", n)
    } else{
      SignA <- rep("==", m)
      SignB <- rep("<=", n)
    }
  }
  # Записываем составленную транспортную задачу в переменную M.Tr:
  M.Tr <- lp.transport(cost.mat = P, direction = "min",
                       
                       row.signs = SignA, row.rhs = SumA,
                       
                       col.signs = SignB, col.rhs = SumB)
  print('Оптимальный план перевозок:')
  print(M.Tr$solution) # Оптимальный план перевозок (матрица X)
  print(paste0('Минимальные суммарные транспортные расходы на перевозку составят ',M.Tr$objval, ' у.е.'))  # Минимальные суммарные транспортные расходы на перевозку 
}  
