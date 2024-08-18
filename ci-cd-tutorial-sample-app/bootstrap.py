from app import app

# systemctl stop haproxy
#  1815  sudo certbot certonly --standalone --preferred-challenges http --http-01-port 80 -d sms.mobilexcetera.com
#  1816  sudo certbot certonly --standalone --preferred-challenges http --http-01-port 80 -d auth.mobilexcetera.com -d mobilexcetera.com -d mxpay.mx -d secure.mobilexcetera.com -d sms.api.mobilexcetera.com -d texteasy.com.ng -d  www.mobilexcetera.com  -d www.mxpay.mx -d www.texteasy.com.ng
 
 
#   cat auth.mobilexcetera.com/fullchain.pem auth.mobilexcetera.com/privkey.pem > auth.mobilexcetera.com.pem
#  1865  cat mxpay.mx/fullchain.pem mxpay.mx/privkey.pem > mxpay.mx.pem
#  1866  cat secure.mobilexcetera.com/fullchain.pem secure.mobilexcetera.com/privkey.pem > secure.mobilexcetera.com.pem
#  1867  cat sms.api.mobilexcetera.com/fullchain.pem sms.api.mobilexcetera.com/privkey.pem > sms.api.mobilexcetera.com.pem
#  1868  cat sms.mobilexcetera.com/fullchain.pem sms.mobilexcetera.com/privkey.pem > sms.mobilexcetera.com.pem
#  1869  cat www.mxpay.mx/fullchain.pem www.mxpay.mx/privkey.pem > www.mxpay.mx.pem
#  1870  cat www.texteasy.com.ng/fullchain.pem www.texteasy.com.ng/privkey.pem > www.texteasy.com.ng.pem
#  1871  cat /etc/haproxy/haproxy.cfg
#  1872  nano /etc/haproxy/haproxy.cfg
 
#   1878  cat fullchain.pem privkey.pem > mobilexcetera.com.pem