---
layout: post
title: Ghost On Apache
date: 2013-10-14
tags: misc
---

Given that Ghost was just released today to the public, there is a bit of lack of documentation. In order to install Ghost using Apache using a subdomain you must go through the regular given instructions to install Ghost and use this config for your Ghost instance (create the file in `sites-available` and name it `whateveryouwant.conf`):
###whateveryouwant.conf
{% highlight http %}
<VirtualHost *:80>
	ServerName your.blog.com 
    ProxyPass / http://127.0.0.1:2368/
    ProxyPassReverse / http://127.0.0.1:2368/
    ProxyPreserveHost On
</VirtualHost>
{% endhighlight %}
Then enable the site using `a2ensite whateveryouwant.conf`. This serves to redirect to the path that Ghost is installed into. Enable the mods `proxy` and `proxy_http` by using `a2enmod proxy proxy_http`, then restart Apache (`service apache2 restart`).

###config.js
In order to connect to your server using a proxy you must change your `config.js` to reflect the changes done as so by chaning both the `url` and `host` sections:
{% highlight javascript %}
    // ### Production
    // When running Ghost in the wild, use the production environment
    // Configure your URL and mail settings here
    production: {
        url: 'http://your.blog.com',
        mail: {},
        database: {
            client: 'sqlite3',
            connection: {
                filename: path.join(__dirname, '/content/data/ghost.db')
            },
            debug: false
        },
        server: {
            // Host to be passed to node's `net.Server#listen()`
            host: '127.0.0.1',
            // Port to be passed to node's `net.Server#listen()`, for iisnode set this to `process.env.PORT`
            port: '2368'
        }
    },
{% endhighlight %}
Note that this is under Production and **not** Development, as running `forever` will enable production.

An [update to the Ghost docs](http://docs.ghost.org/installation/deploy/) was also made recently to help enable Ghost run forever. It's often best to avoid platform specific configurations, so it's best to go with the forever package using:
###forever
{% highlight bash %}
npm install forever -g
NODE_ENV=production forever start index.js
{% endhighlight %}

You could now go to the subdomain used in `ServerName` and set up your instance of Ghost by going to your.blog.com/ghost/signup.

###Forbid Access to Your Directory
Putting your Ghost directory within `/var/www` will allow access to visitors to your blog directory through your main domain from [http://domain.com/blog](#). In order to prevent this you must forbid access to that directory by modifying `/etc/apache2/sites-available/default` (may also be named `000-default`) with the following:
{% highlight http %}
<DirectoryMatch /var/www/(directory to ghost)>
	Order allow,deny
    Deny from all
</DirectoryMatch>
{% endhighlight %}
**(NOTE: Running Ghost as root is not suggested)**
