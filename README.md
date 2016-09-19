# larning-kerberos

# setup server
```
kdb5_util create -s
kadmin.local
addprinc root/admin
addprinc user01
listprincs
exit

systemctl start krb5kdc.service
```

# setup client
```
yum install -y krb5-workstation

kinit user01@EXAMPLE.COM
klist
```

