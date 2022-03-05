Build obrazu:
```docker build -t pilifs/grafana-influx:1 .```

Výpis obrazů:
```docker image ls | findstr pilifs```

Exec:
```docker exec -it --user root grafana_influx sh```

Reaload nginx:
```nginx -s reload -c /etc/nginx/nginx.conf```