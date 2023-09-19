# Função Para Validar CEPs Brasileiros

# Modelo de consulta:
'SELECT LPAD(REPLACE('1234-5678','-',''),8,0) FROM DUAL;'

# Valor de retorno:
Inválido = 0
Válido = 1
