**Problem:**

Sometimes you will be asked to provide callback URL when you work with third party software. In development phase, if you want to test whether the third party software can interact with your callback URL correctly, you will need to prepare a callback URL that is public accessible.

To do so, you need to have a domain name registered in a DNS Server, and its DNS record points to a web server where your callback URL will be at. It will cost you some times to set them up.

**Solution:**

This package lets you get the public accessible dynamic callback URL(s) easily with just one command. You download the package, run the command, and the callback URL is there for you.

And the callback URL is dynamic, you can modify the callback URL path to let them listen for different callbacks, and each of the callback message is stored in different log files. This feature enable you to have unlimited callback URL as you need.

But keep in mind that the callback URL is ephemeral. After you run the shut down script, the callback URL will be gone. The next time you start the container, another random callback URL will be generated.