# Funções Para Validar CEPs Brasileiros

# Modelo de consulta Oracle SQL:
SELECT FNC_VERIFY_CEP(LPAD(REPLACE('1234-5678','-',''),8,0)) FROM DUAL;

# Modelo de consulta JavaScript:
const result = await verifyCEP("12345-678");
<br>console.log(result);

# Valor de retorno:
Inválido = 0
<br>Válido = 1
