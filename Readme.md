# Nginx Configurations Repository

This repository stores my **Nginx configuration files** used for setting up domains, HTTPS, reverse proxy, static file serving, etc.

---

## Structure

* `/etc/nginx/sites-available/` → Contains site configurations (saved as separate files per domain).
* `/etc/nginx/sites-enabled/` → Symlinks to enabled configurations.
* `/var/www/static/` → Static files directory.
* `/var/www/static2/` → Secondary static files directory.

---

## Usage

### 1. Clone this repository

```bash
git clone https://github.com/yourusername/nginx-configs.git
cd nginx-configs
```

### 2. Copy configuration file to Nginx

```bash
sudo cp yourdomain.com /etc/nginx/sites-available/
```

### 3. Enable site

```bash
sudo ln -s /etc/nginx/sites-available/yourdomain.com /etc/nginx/sites-enabled/
```

### 4. Test configuration

```bash
sudo nginx -t
```

### 5. Restart Nginx

```bash
sudo systemctl restart nginx
```

---

## SSL Certificates

This setup assumes you are using **Let’s Encrypt** certificates stored in:

```
/etc/letsencrypt/live/yourdomain.com/fullchain.pem
/etc/letsencrypt/live/yourdomain.com/privkey.pem
```

Generate or renew them with:

```bash
sudo certbot --nginx -d yourdomain.com
```

---

## Notes

* Always test with `sudo nginx -t` before restarting.
* Reload using `sudo systemctl reload nginx`.
* Keep configs version-controlled in this repository.
* Update SSL certificates periodically with Certbot.

---

### Example Configuration Snippet

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name yourdomain.com;
    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    location /static/ {
        alias /var/www/static/;
        expires max;
        access_log off;
    }
}
```
