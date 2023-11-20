map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

server {
    listen      %ip%:%proxy_port%;
    listen [::]:%proxy_port%;

    server_name %domain_idn% %alias_idn%;
    error_log  /var/log/%web_system%/domains/%domain%.error.log error;
    root           %sdocroot%/public;  # Путь к корневой директории сайта
    charset utf-8;

    index index.php;

    location /index.php {
        try_files /not_exists @octane;
    }

    location / {
        location ~* ^.+\.(%proxy_extentions%)$ {
            root           %sdocroot%/public;  # Путь к корневой директории сайта
            access_log     /var/log/%web_system%/domains/%domain%.log combined;  # Путь к жур>
            access_log     /var/log/%web_system%/domains/%domain%.bytes bytes;  # Путь к журн>
            expires        max;  # Установка максимального срока действия кэширования
        }

        try_files $uri $uri/ @octane;
    }

    location @octane {
        set $suffix "";

        if ($uri = /index.php) {
            set $suffix ?$query_string;
        }

        proxy_http_version 1.1;
        proxy_set_header Host $http_host;
        proxy_set_header Scheme $scheme;
        proxy_set_header SERVER_PORT $server_port;
        proxy_set_header REMOTE_ADDR $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_pass http://%ip%:8000$suffix;
    }

    location /error/ {
        alias   %home%/%user%/web/%domain%/document_errors/;
    }

    location @fallback {
        proxy_pass      https://%ip%:%web_ssl_port%;
    }

    location ~ /\.ht    {return 404;}
    location ~ /\.env   {return 404;}
    location ~ /\.svn/  {return 404;}
    location ~ /\.git/  {return 404;}
    location ~ /\.hg/   {return 404;}
    location ~ /\.bzr/  {return 404;}

    disable_symlinks if_not_owner from=%docroot%/public;

    include %home%/%user%/conf/web/snginx.%domain_idn%.conf*;
}

