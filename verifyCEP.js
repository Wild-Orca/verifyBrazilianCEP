async function verifyCEP(pCep) {
    
    pCep = pCep.replace(/-/g, '');

    // Validate CEP length (8 characters)
    if (pCep.length !== 8) {
      return 0; // Invalid CEP length
    }
  
    const vApiUrl = `https://viacep.com.br/ws/${pCep}/json/`;
  
    try {
      // Open the HTTP GET request
      const response = await fetch(vApiUrl, { method: "GET" });
  
      // Check if the response status is OK (200)
      if (response.status === 200) {
        const vBuffer = await response.text();
        
        // Check if the response contains an error message
        const responseData = JSON.parse(vBuffer);

        console.log(responseData);
        if (responseData.erro === true) {
          return 0; // Invalid CEP
        } else {
          return 1; // Valid CEP
        }
      } else {
        throw new Error(`Error validating CEP: ${response.statusText}`);
      }
    } catch (error) {
      console.error(`Error validating CEP: ${error.message}`);
      return 0; // An error occurred during the request
    }
  }

  // Example usage:
  // const result = await verifyCEP("12345678");
  // console.log(result);
  