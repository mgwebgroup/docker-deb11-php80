### Self-signed SSL Certificate Generation ###
1. Create Server Private Key
```shell
openssl genpkey -out ssl-cert-snakeoil.key -algorithm RSA
```

2. Create Certificate Signing Request (CSR)
```shell
openssl req -new -key ssl-cert-snakeoil.key -out server.csr
```
This command will ask several questions in interactive mode. To populate default values press '.' (dot). 
Make sure when answering 'Common Name (e.g. server FQDN or YOUR name)' question, you enter 'localhost'. 
This name must match ServerName directive in VirtualHost in apache conf file. Otherwise SSL for Apache won't work.

3. Self-sign CSR
```shell
openssl x509 -req -days 365 -in server.csr -signkey ssl-cert-snakeoil.key -out ssl-cert-snakeoil.crt
```

4. To visually examine contents of the certificate use the following command:
```shell
openssl x509 -text -in ssl-cert-snakeoil.crt
```
Check for parameter CN = localhost

When calling site through a browser via https, accept warnings about invalid certificate.
To check if Apache is serving via https you can also use:
```shell
openssl s_client -port 443 -host localhost 
```
In the output look for 'Verify return code: 18 (self-signed certificate)'.
