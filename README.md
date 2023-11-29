# myVesta/VestaCP Nginx templates for laravel octane

I use this templates with `swoole`, but i thick it should be working with `openswoole` and `roadrunner` too.

## Installation

Copy template files into `/usr/local/vesta/data/templates/web/nginx`.
After that you can choose template in the web interface.

## Notice
- Octane should be running on 8000 port or you can change the port in the templates
- Don't foget to add `OCTANE_HTTPS=true` in your `.env`