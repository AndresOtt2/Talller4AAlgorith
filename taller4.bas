' Leer inputs de nombre de archivo y peso maximo para la mochila
Input "Escriba el nombre del archivo: ", file$
Input "Enter the weight capacity of knapsack: ", wmax
'Abrir archivo
Open file$ For Input As #1
' Tamños maximos de arreglo
Dim K(100, 100)
Dim B(100, 100)
Dim pesos(100)
Dim valores(100)
n = 0

' Leyendo archivo
Do While Not EOF(1)
    Input #1, pesos(n), valores(n)
    n = n + 1
Loop

' Cerrar archivo
Close #1
Print "Estos son los valores que se leyeron del archivo"
Print "#", "peso", "valor"
'Valores del archivo de pesos y valores
For i = 0 To n - 1
    Print i, pesos(i), valores(i)
Next i


For i = 1 To n
    For w = 1 To wmax
        If pesos(i) > w Then
            K(i, w) = K(i - 1, w)
            B(i, w) = i - 1
        Else
            a = K(i - 1, w)
            b = K(i - 1, w - pesos(i)) + valores(i)
            If b > a Then
                K(i, w) = b
                B(i, w) = i
            Else
                K(i, w) = a
                B(i, w) = i - 1
            End If
        End If
    Next w
Next i

' Backtracking
i = n
w = wmax
j = 0
'Mientras aun hayan objetos y peso restante
Do While i > 0 And w > 0
    If B(i, w) = i Then
        ' Guarda la posicion del objeto
        mochila(j) = i
        j = j + 1
        'Se resta el peso del maximo
        w = w - mochila(i)
        i = i - 1
    Else
        i = B(i, w)
    End If
Loop

' Print the optimal solution
Print "Valor maximo posible: "; K(n, wmax)
Print "Objetos que suman ese valor:"
For i = j - 1 To 0 Step -1
    Print "Objeto "; mochila(i); ": weight="; pesos(mochila(i)); ", value="; valores(mochila(i))
Next i


