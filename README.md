chef-jrockit Cookbook
=====================
Installs jrockit from a URL


Requirements
------------
An http URL to grab jrockit from.
chef-jrockit does not do any authentication.

Oracle supplies jrockit at http://www.oracle.com/technetwork/middleware/jrockit/downloads/index.html?ssSourceSiteId=otnpt , but this cookbook does not do the necessary login to download it directly.

SPS users should contact Engineering for a URL to use.


Attributes
----------
```ruby
default['media_path'] = '/u01/media'
default['jrockit_file'] = 'jrockit-jdk1.6.0_45-R28.2.7-4.1.0-linux-x64.bin'
default['jrockit_install_path'] = '/u01/app/oracle/jrockit'
default['jrockit_base_url'] = 'http://server.example/path/to/jrockit_dir'
```

Required:<br>
`jrockit_file` should contain the filename of the jrockit installer file only<br>
`jrockit_base_url` should be the http URL to the installation file's containing directory

Optional:<br>
`media_path` will defaults to `/u01/media` if unspecified<br>
`jrockit_install_path` will default to `/u01/app/oracle/jrockit` if unspecified

Usage
-----
At a minimum, specifiy the `jrockit_base_url` and `jrockit_file` attributes.

License and Authors
-------------------
Authors: Jeff Gibson/SPS Commerce
