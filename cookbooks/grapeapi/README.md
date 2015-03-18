# grapeapi-cookbook

Installs a RoR4 Development Environment

Included Features:
RubyOnRails 4.2
Twitter Bootstrap 3.x Integration

## Supported Platforms

Ubuntu 14.04 LTS

## Attributes

## Usage

This Project is about helping you setting up a new RubyOnRails 4.x Webapplication with Twitter Bootstrap
Assets included. The gemified bootstrap-sass variant from [github link] is used.

By default a mysql based RoR Application is going to be initialized by invoking the grapeapi::default chef recipe.

The intended usage is:

1) clone the repo from github to your worksapce
git clone...


2)
bash ./scripts/app_create.sh <new_app_name>

This will create a new folder ../<new_app_name> and prepare everything inside this folder to be
automatically setup during the first vagrant up run:

3)
cd ../<new_app_name>
vagrant up

4) Afterwards you can point your editor to ../<new_app_name> and vagrant ssh inside the ror4 box and start
developing right away!

### grapeapi::default

Include `grapeapi::default` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[grapeapi::default]"
  ]
}
```

## License and Authors

Author:: Alexander Birk (birk@pingworks.de)

Copyright 2015 pingworks - Alexander Birk und Christoph Lukas

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
