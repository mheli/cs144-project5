# README #

### What is this repository for? ###

The goal of this project is to securely obtain a user's credit card number while ensuring the integrity of the item price with SSL and HTTP session.

### How do I get set up? ###

A Google API key is needed for geocoding, replace PUTKEYHERE in getItem.jsp  
Run two commands to build and deploy the project:
`ant build`
`ant deploy`

### Other Info ###

Important constraints:  
1. SSL communication is computationally very expensive, so you need to protect your commmuication through HTTPS only when the credit card number is in transit. All other communication between your server and the browser should be done through plain HTTP, not HTTPS.

2. Due to the heavy load on the DBMS server at oak, you have to minimize the number of requests sent to oak. Clearly, you cannot avoid contacting oak to obtain the item information while you generate the "item page" (the communication from (0) to (1) in the above figure), but beyond that, the tomcat server CANNOT contact oak for the rest of the transaction. In particular, you are NOT allowed to send a request to oak while you are generating the "credit-card-input page" or the "confirmation page" in order to obtain the item information that is being purchased (i.e., the communication from (3) to oak or from (5) to oak is not allowed).

Q1: For which communication(s) do you use the SSL encryption? If you are encrypting the communication from (1) to (2) in Figure 2, for example, write (1)→(2) in your answer.  
Encrypt from (4)->(5) and (5)->(6) because the credit card number is in transit at these times.

Q2: How do you ensure that the item was purchased exactly at the Buy_Price of that particular item?  
The Tomcat server remembers the Buy_Price (and all the other item information) by attaching the item info to a new session when an item with a Buy_Price is looked up. If the user decides to purchase the item, this session is referenced for the Buy_Price, so the user cannot modify the Buy_Price.