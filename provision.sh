#!/bin/sh


# setup server
yum install -y krb5-server

# vim /etc/krb5.conf
kdb5_util create -s


tee /var/kerberos/krb5kdc/kdc.conf <<-EOF 
[kdcdefaults]
 kdc_ports = 88
 kdc_tcp_ports = 88

[realms]
 EXAMPLE.COM = {
  #master_key_type = aes256-cts
  acl_file = /var/kerberos/krb5kdc/kadm5.acl
  dict_file = /usr/share/dict/words
  admin_keytab = /var/kerberos/krb5kdc/kadm5.keytab
  supported_enctypes = aes256-cts:normal aes128-cts:normal des3-hmac-sha1:normal arcfour-hmac:normal camellia256-cts:normal camellia128-cts:normal des-hmac-sha1:normal des-cbc-md5:normal des-cbc-crc:normal
 }
EOF

tee /etc/krb5.conf <<-EOF 
[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 rdns = false
 default_realm = EXAMPLE.COM
 default_ccache_name = KEYRING:persistent:%{uid}

[realms]
 EXAMPLE.COM = {
  kdc = kerberos.example.com
  admin_server = kerberos.example.com
  default_domain = example.com
 }

[domain_realm]
 .example.com = EXAMPLE.COM
 example.com = EXAMPLE.COM
EOF

echo "192.168.33.60 kerberos.example.com" >> /etc/hosts

kdb5_util create -s
# kadmin.local
# addprinc root/admin
# addprinc user01
# listprincs
# exit

#systemctl start krb5kdc.service

# client
#yum install -y krb5-workstation

#kinit user01@EXAMPLE.COM
#klist





