# myVesta/VestaCP Nginx templates for laravel octane

This template works with Laravel Octane (`swoole`, `openswoole`, `roadrunner`)

## Installation

Copy template files into `/usr/local/vesta/data/templates/web/nginx`.
After that you can choose template in the web interface.

## Notice
- Octane should be running on 8000 port or you can change the port in the templates
- Don't foget to add `OCTANE_HTTPS=true` in your `.env`
- If you use http without redirect to https, then i recommend you use `hosting-public.tpl` template. Just copy and rename it to `laravel-octane.tpl`.