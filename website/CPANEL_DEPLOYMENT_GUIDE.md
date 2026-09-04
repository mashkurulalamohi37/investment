# 🚀 cPanel 1-Click Deployment Guide

Your production deployment archive has been built and packaged:
📁 **`website/swapnojatri_cpanel_deploy.zip`** (37.8 MB)

This single package hosts:
1. **Public Website & Investor Portal**
2. **Admin Console**
3. **REST API Endpoints (`/api/*`)** for your Flutter mobile app

---

## 📋 4-Step cPanel Deployment

### Step 1: Create the Node.js App in cPanel
1. Log into your **cPanel Dashboard**.
2. Search for **"Setup Node.js App"** (under Software section).
3. Click **"Create Application"**:
   - **Node.js version**: `20.x` (or `18.x`)
   - **Application mode**: `Production`
   - **Application root**: `swapnojatri` (or your preferred directory)
   - **Application URL**: `yourdomain.com` (or your subdomain)
   - **Application startup file**: `server.js`
4. Click **"Create"**.

---

### Step 2: Upload the Deployment ZIP
1. In cPanel, open **"File Manager"**.
2. Navigate into your Application Root folder (`/home/username/swapnojatri`).
3. Click **"Upload"** and select:
   👉 **`website/swapnojatri_cpanel_deploy.zip`**
4. Right-click the uploaded `.zip` file and click **"Extract"**.
5. Delete the `.zip` file after extraction to save disk space.

---

### Step 3: Install Production Dependencies
1. Return to **"Setup Node.js App"** in cPanel.
2. Click the **"Run NPM Install"** button (or open the cPanel Terminal and run `npm install --omit=dev`).
3. Under **Environment Variables**, add:
   - `NODE_ENV`: `production`
   - `PORT`: `3000`
   - `NEXT_PUBLIC_APP_URL`: `https://yourdomain.com`

---

### Step 4: Restart & Test
1. Click **"Restart"** application at the top.
2. Test in your browser:
   - 🌐 **Website & Investor Portal**: `https://yourdomain.com`
   - 🛡️ **Admin Console**: `https://yourdomain.com/admin`
   - ⚙️ **Backend API Health**: `https://yourdomain.com/api/health`

---

## 📱 Connecting Your Flutter App to cPanel
In your Flutter project:
1. Open `lib/core/constants/app_config.dart`.
2. Update:
   ```dart
   static String productionApiBaseUrl = 'https://yourdomain.com/api';
   static bool useProduction = true;
   ```
3. Build your release APK / App:
   ```bash
   flutter build apk --release
   ```
