mailcatcher Chef Cookbook
=========================

This cookbook installs [mailcatcher](http://mailcatcher.me/).  Any mail sent to port 25, or any mail coming
from PHP will be caught by mailcatcher instead of actually being sent.

You can see the mail that is sent by this VM by visiting [http://your.vm:1080](http://your.vm:1080)

This is confirmed working on Debian.  For different Linux flavors, some of the paths
may be wrong.


## Installation

### Add submodule dependency

```bash
$ git submodule add https://github.com/vube/chef-init-mailcatcher chef/cookbooks/chef-init-mailcatcher
```

The above assumes that `chef/cookbooks/` is the sub-directory where you want to store cookbook
dependencies.  Make sure that is in your cookbook search path, or change it to a location you prefer.

### In your metadata.rb

```ruby
depends "chef-init-mailcatcher"
```

### In your recipes/default.rb

```ruby
include_recipe "chef-init-mailcatcher"
```

## No Configuration Required

Currently there is no configuration required.  Mailcatcher is installed and replaces exim4
as the SMTP handler on your VM.
