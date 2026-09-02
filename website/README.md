# Swapnojatri Web Platform (Next.js)

Official production web application for the **Swapnojatri Investment Platform**, centered on the flagship **LandVest 100** asset-backed land crowdfunding project.

Consumes the unified FastAPI + PostgreSQL REST backend (`https://api.swapnojatri.com/api/v1/`).

---

## 🚀 Tech Stack

- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS (Custom Emerald & Champagne Gold fintech tokens)
- **State Management**: TanStack Query v5 (React Query)
- **Icons**: Lucide React
- **Validation**: Zod + React Hook Form
- **API Client**: Centralized Axios with Bearer JWT Interceptors & StandardResponse unwrapping

---

## 📦 Local Development

1. **Install Dependencies**:
   ```bash
   cd website
   npm install
   ```

2. **Configure Environment Variables**:
   Copy `.env.example` to `.env.local`:
   ```env
   NEXT_PUBLIC_API_BASE_URL=http://localhost:8000/api/v1
   NEXT_PUBLIC_APP_URL=http://localhost:3000
   NEXT_PUBLIC_ENVIRONMENT=development
   ```

3. **Start Development Server**:
   ```bash
   npm run dev
   ```
   Open `http://localhost:3000`.

4. **Run Production Build**:
   ```bash
   npm run build
   npm run start
   ```

---

## 🌐 cPanel Production Deployment Guide

### Option A: cPanel Node.js Application Manager (Recommended for SSR & SEO)

1. **Login to cPanel** and navigate to **"Setup Node.js App"** (or **"Application Manager"**).
2. **Create New Application**:
   - **Node.js Version**: Select `18.x`, `20.x`, or `22.x`.
   - **Application Mode**: `Production`.
   - **Application Root**: `public_html/website` or `subdomains/app`.
   - **Application Startup File**: `node_modules/next/dist/bin/next` or custom server script `server.js`.
3. **Upload Files & Build**:
   - Upload the Next.js project files (excluding `node_modules` and `.next`).
   - Run `npm install` and `npm run build` from the cPanel terminal or UI console.
4. **Environment Variables**:
   - In the cPanel Node.js App interface, add:
     - `NODE_ENV=production`
     - `PORT=3000`
     - `NEXT_PUBLIC_API_BASE_URL=https://api.swapnojatri.com/api/v1`
5. **Restart Application** in cPanel.

---

### Option B: Reverse Proxy via Nginx / Cloudflare
For subdomains:
- `swapnojatri.com` -> Next.js Web Frontend (Port 3000)
- `api.swapnojatri.com` -> FastAPI REST Backend (Port 8000)
- SSL: Managed via Let's Encrypt / Cloudflare Full (Strict) SSL.
