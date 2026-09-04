# 🚀 Hostinger Deployment Guide for Swapnojatri

This guide outlines the step-by-step process for deploying the **Swapnojatri Platform** (Next.js 14 Frontend + Backend REST API) to **Hostinger**.

---

## 🎯 Which Hostinger Plan Are You Using?

- **Option A: Hostinger VPS / Cloud Hosting (Ubuntu)** *(Recommended — 100% full feature support, high performance, automated PM2 clustering, SSL)*
- **Option B: Hostinger Web / Cloud Hosting with hPanel Node.js**
- **Option C: Automated Deployment via GitHub Actions / Webhooks**

---

# 🌟 Option A: Hostinger VPS (Recommended & Easiest)

A Hostinger VPS (KVM 1 or KVM 2 running Ubuntu 22.04 / 24.04) gives you complete control, zero resource limits, and instant SSL.

### Step 1: Connect to your Hostinger VPS via SSH
Open PowerShell or Terminal and run:
```bash
ssh root@YOUR_SERVER_IP
# Enter your VPS password when prompted
```

### Step 2: Install Node.js 20 & PM2
Run the following commands on your server:
```bash
# Update package lists
sudo apt update && sudo apt upgrade -y

# Install Node.js 20 LTS (NodeSource)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs git nginx

# Install PM2 process manager globally
sudo npm install -g pm2

# Verify installation
node -v   # Should show v20.x
npm -v
pm2 -v
```

### Step 3: Clone the GitHub Repository
```bash
# Navigate to web root directory
cd /var/www

# Clone your repository
git clone https://github.com/mashkurulalamohi37/investment.git swapnojatri

# Enter website directory
cd /var/www/swapnojatri/website
```

### Step 4: Install Dependencies & Build
```bash
# Install production dependencies
npm install

# Build Next.js production bundle
npm run build
```

### Step 5: Start the Platform with PM2
```bash
# Start Next.js with PM2 in cluster/daemon mode
pm2 start npm --name "swapnojatri" -- start -- -p 3000

# Save PM2 state and enable auto-restart on server reboot
pm2 save
pm2 startup
```

### Step 6: Configure Nginx Reverse Proxy with Domain & SSL
Create an Nginx configuration file for your domain:
```bash
sudo nano /etc/nginx/sites-available/swapnojatri
```
Paste the following configuration (replace `yourdomain.com` with your actual domain):
```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
Save and exit (`Ctrl + O`, `Enter`, then `Ctrl + X`).

Enable the site and reload Nginx:
```bash
sudo ln -s /etc/nginx/sites-available/swapnojatri /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### Step 7: Install Free SSL Certificate (Let's Encrypt / Certbot)
```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```
Follow the prompt. Certbot will configure HTTPS with automatic auto-renewal.

---

# 🌟 Option B: Hostinger hPanel (Web Hosting with Node.js)

If your Hostinger plan includes **Node.js support in hPanel**:

### Step 1: Upload the cPanel/Hostinger Package
1. On your local machine, generate the deployment archive:
   ```powershell
   cd website
   powershell -ExecutionPolicy Bypass -File bundle_cpanel.ps1
   ```
2. Log in to **Hostinger hPanel**.
3. Go to **Websites** $\rightarrow$ **Manage** $\rightarrow$ **File Manager**.
4. Upload `swapnojatri_cpanel_deploy.zip` to `public_html` (or your subdomain directory) and click **Extract**.

### Step 2: Configure Node.js in hPanel
1. In hPanel, search for **Node.js** or go to **Advanced** $\rightarrow$ **Node.js**.
2. Click **Create Application**:
   - **Node.js Version**: Select `20.x` or `18.x`.
   - **Application Mode**: `Production`.
   - **Application Root**: `/public_html` (or your subfolder).
   - **Application Startup File**: `server.js`.
3. Click **Create**.
4. In the Node.js settings, click **Run NPM Install**.
5. Click **Restart Application**.

---

## 🔄 How to Update After Pushing New Code to GitHub

Whenever you push new changes to GitHub:

### If on Hostinger VPS:
```bash
cd /var/www/swapnojatri
git pull origin main
cd website
npm install
npm run build
pm2 reload swapnojatri
```
*Your website updates with zero downtime!*

---

## 🔍 Verification & Health Checks

After deployment, verify the platform:
- Public Portal: `https://yourdomain.com`
- Contact & Map: `https://yourdomain.com/contact`
- REST API Health: `https://yourdomain.com/api/health`
- Investor Login: `https://yourdomain.com/login`
- Admin Console: `https://yourdomain.com/admin`
