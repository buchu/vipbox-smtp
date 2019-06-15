vipbox-smtp
==============

Forked from catatnight/postfix, add a filter for destinations rewrite or other stuff.
It runs postfix with smtp authentication (sasldb) in a docker container.
TLS and OpenDKIM support are optional. 

## Requirement
+ Docker 1.0

## Installation
1. Build image

	```bash
	$ sudo docker pull buchu/vipbox-smtp
	```

## Usage
1. Create postfix container with smtp authentication

	```bash
	$ sudo docker run -p 25:25 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			--name vipbox-smtp -d buchu/vipbox-smtp
	# Set multiple user credentials: -e smtp_user=user1:pwd1,user2:pwd2,...,userN:pwdN
	```
2. Enable OpenDKIM: save your domain key ```.private``` in ```/path/to/domainkeys```

	```bash
	$ sudo docker run -p 25:25 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			-v /path/to/domainkeys:/etc/opendkim/domainkeys \
			--name vipbox-smtp -d vipbox-smtp
	```
3. Enable TLS(587): save your SSL certificates ```.key``` and ```.crt``` to  ```/path/to/certs```

	```bash
	$ sudo docker run -p 587:587 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			-v /path/to/certs:/etc/postfix/certs \
			--name postfix -d vipbox-smtp
	```

4. Add filter for mail, for example that rewrite destinations with ```rewrite_to``` variable, you can edit assets/filter.py and do whatever you want.
	```bash
	$ sudo docker run -p 2525:25 \
			-e maildomain=mail.example.com \
			-e smtp_user=user:pwd \
			-e rewrite_to=user@mydomain.com
			--name vipbox-smtp -d buchu/vipbox-smtp
	```

## Note
+ Login credential should be set to (`username@mail.example.com`, `password`) in Smtp Client
+ You can assign the port of MTA on the host machine to one other than 25 ([postfix how-to](http://www.postfix.org/MULTI_INSTANCE_README.html))
+ Read the reference below to find out how to generate domain keys and add public key to the domain's DNS records

## Reference
+ [Postfix SASL Howto](http://www.postfix.org/SASL_README.html)
+ [How To Install and Configure DKIM with Postfix on Debian Wheezy](https://www.digitalocean.com/community/articles/how-to-install-and-configure-dkim-with-postfix-on-debian-wheezy)
+ TBD