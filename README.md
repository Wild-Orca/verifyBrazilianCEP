# Função Para Validar CEPs Brasileiros

# Modelo de consulta:
SELECT FNC_VERIFY_CEP_API(LPAD(REPLACE('1234-5678','-',''),8,0)) FROM DUAL;

# Valor de retorno:
Inválido = 0
<br>Válido = 1
