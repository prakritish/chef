The chef-repo
===============
All installations require a central workspace known as the chef-repo. This is a place where primitive objects--cookbooks, roles, environments, data bags, and chef-repo configuration files--are stored and managed.

The chef-repo should be kept under version control, such as [git](http://git-scm.org), and then managed as if it were source code.

Knife Configuration
-------------------
Knife is the [command line interface](https://docs.chef.io/knife.html) for Chef. The chef-repo contains a .chef directory (which is a hidden directory by default) in which the Knife configuration file (knife.rb) is located. This file contains configuration settings for the chef-repo.

The knife.rb file is automatically created by the starter kit. This file can be customized to support configuration settings used by [cloud provider options](https://docs.chef.io/plugin_knife.html) and custom [knife plugins](https://docs.chef.io/plugin_knife_custom.html).

Also located inside the .chef directory are .pem files, which contain private keys used to authenticate requests made to the Chef server. The USERNAME.pem file contains a private key unique to the user (and should never be shared with anyone). The ORGANIZATION-validator.pem file contains a private key that is global to the entire organization (and is used by all nodes and workstations that send requests to the Chef server).

More information about knife.rb configuration options can be found in [the documentation for knife](https://docs.chef.io/config_rb_knife.html).

Cheatsheet
===========
### Bootstrap a node
    knife bootstrap <FQDN> -N <node name or alias> --ssh-user <user name> --sudo
e.g.,
    knife bootstrap prakritish3.mylabserver.com -N minion2 --ssh-user user --sudo

### List nodes
    knife node list

### View node information
    knife node show <node name>
e.g.,
    [root@prakritish1 chef]# knife node show minion2
    Node Name:   minion2
    Environment: _default
    FQDN:        prakritish3.mylabserver.com
    IP:          52.221.231.22
    Run List:
    Roles:
    Recipes:
    Platform:    centos 7.3.1611
    Tags:
    [root@prakritish1 chef]#

### Create a cookbook
    chef generate cookbook <path of cookbook>
e.g.,
```
[root@prakritish1 chef]# chef generate cookbook cookbooks/my_cook_book
Generating cookbook my_cook_book
- Ensuring correct cookbook file content
- Ensuring delivery configuration
- Ensuring correct delivery build cookbook content

Your cookbook is ready. Type `cd cookbooks/my_cook_book` to enter it.

There are several commands you can run to get started locally developing and testing your cookbook.
Type `delivery local --help` to see a full list.

Why not start by writing a test? Tests for the default recipe are stored at:

test/smoke/default/default_test.rb

If you'd prefer to dive right in, the default recipe can be found at:

recipes/default.rb

[root@prakritish1 chef]# ls -l cookbooks/my_cook_book/
total 16
-rw-r--r--. 1 root root   47 Mar 19 22:36 Berksfile
-rw-r--r--. 1 root root 1133 Mar 19 22:36 chefignore
-rw-r--r--. 1 root root  775 Mar 19 22:36 metadata.rb
-rw-r--r--. 1 root root   60 Mar 19 22:36 README.md
drwxr-xr-x. 2 root root   23 Mar 19 22:36 recipes
drwxr-xr-x. 3 root root   38 Mar 19 22:36 spec
drwxr-xr-x. 3 root root   18 Mar 19 22:36 test
[root@prakritish1 chef]#
```

### Generate a recipe
    chef generate recipe <path to cookbook> <recipe name>
e.g.,
```
[root@prakritish1 chef]# chef generate recipe cookbooks/my_cook_book my_recipe
Recipe: code_generator::recipe
  * directory[cookbooks/my_cook_book/spec/unit/recipes] action create (up to date)
  * cookbook_file[cookbooks/my_cook_book/spec/spec_helper.rb] action create_if_missing (up to date)
  * template[cookbooks/my_cook_book/spec/unit/recipes/my_recipe_spec.rb] action create_if_missing
    - create new file cookbooks/my_cook_book/spec/unit/recipes/my_recipe_spec.rb
    - update content in file cookbooks/my_cook_book/spec/unit/recipes/my_recipe_spec.rb from none to b7f068
    (diff output suppressed by config)
    - restore selinux security context
  * directory[cookbooks/my_cook_book/test/smoke/default] action create (up to date)
  * template[cookbooks/my_cook_book/test/smoke/default/my_recipe.rb] action create_if_missing
    - create new file cookbooks/my_cook_book/test/smoke/default/my_recipe.rb
    - update content in file cookbooks/my_cook_book/test/smoke/default/my_recipe.rb from none to 3ddb39
    (diff output suppressed by config)
    - restore selinux security context
  * template[cookbooks/my_cook_book/recipes/my_recipe.rb] action create
    - create new file cookbooks/my_cook_book/recipes/my_recipe.rb
    - update content in file cookbooks/my_cook_book/recipes/my_recipe.rb from none to d23697
    (diff output suppressed by config)
    - restore selinux security context
[root@prakritish1 chef]# ls -l cookbooks/my_cook_book/recipes/my_recipe.rb
-rw-r--r--. 1 root root 105 Mar 19 22:40 cookbooks/my_cook_book/recipes/my_recipe.rb
[root@prakritish1 chef]#
```
