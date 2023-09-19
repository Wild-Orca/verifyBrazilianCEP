CREATE OR REPLACE FUNCTION FNC_VERIFY_CEP(
  P_CEP IN VARCHAR2)
  RETURN NUMBER IS

  V_API_URL      VARCHAR2(100);
  V_REQUEST      UTL_HTTP.REQ;
  V_RESPONSE     UTL_HTTP.RESP;
  V_BUFFER       VARCHAR2(32767);
  V_VERIFY_CEP   NUMBER := 0; -- Default to invalid

BEGIN
  -- Validate CEP length (8 characters)
  IF (LENGTH(P_CEP) != 8) THEN
    RETURN V_VERIFY_CEP; -- Invalid CEP length
  END IF;

  V_API_URL := 'viacep.com.br/ws/' || P_CEP || '/json/';
  
  -- Open the HTTP GET request
  V_REQUEST := UTL_HTTP.BEGIN_REQUEST(V_API_URL, 'GET');
  UTL_HTTP.SET_HEADER(V_REQUEST, 'User-Agent', 'Mozilla/4.0');
  
  -- Perform the request and get the response
  V_RESPONSE := UTL_HTTP.GET_RESPONSE(V_REQUEST);
  
  -- Read the response
  BEGIN
    UTL_HTTP.READ_TEXT(V_RESPONSE, V_BUFFER);
    
    -- Check if the response contains an error message
    IF JSON_EXISTS(V_BUFFER, '$.erro') AND JSON_VALUE(V_BUFFER, '$.erro') = 'true' THEN
      V_VERIFY_CEP := 0; -- Invalid CEP
    ELSE 
      V_VERIFY_CEP := 1; -- Valid CEP
    END IF;
      
    UTL_HTTP.END_RESPONSE(V_RESPONSE);
  EXCEPTION
    WHEN UTL_HTTP.END_OF_BODY THEN
      UTL_HTTP.END_RESPONSE(V_RESPONSE);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001,'Erro ao Validar CEP: ' || SQLERRM);
  END;
  
  RETURN V_VERIFY_CEP;
  
END FNC_VERIFY_CEP;
/