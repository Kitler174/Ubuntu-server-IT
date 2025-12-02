# Server Automation

This repository contains scripts used for server automation: volume backups, Docker container deployment, and autostart services.

---

## Repository Structure

| File/Service        | Description |
|--------------------|-------------|
| `autostart.service` | Systemd service that automatically starts Docker containers on system boot. |
| `start.sh`          | Script executed by `autostart.service` to start all Docker containers. |
| `backup_vol.sh`     | Script performing daily volume backups at 01:00 via Cron. |
| `deploy.sh`         | Script checking for Git updates every minute via Cron and redeploying Docker containers. |
| `README.md`         | This documentation file. |

---

## Usage

### 1. Autostart Docker Containers

`start.sh` is executed by `autostart.service`.

- To run manually for testing:

```bash
sudo /path/to/start.sh 
or
sudo systemctl start autostart.service
```

### 2. Volumine backup
`backup_vol.sh` is executed by cron 

- For testing:

```bash
sudo /path/to/backup_vol.sh 
```

### 3. Autopull git
`deploy.sh` is executed by cron 

- For testing:

```bash
sudo /path/to/deploy.sh 
```

### 4. Cron edit

edit cron configuration:

```bash
crontab -e
```