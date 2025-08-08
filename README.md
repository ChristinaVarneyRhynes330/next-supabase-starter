# Next + Supabase Starter (with CI)

A minimal, beginner-friendly Next.js 14 + Supabase starter with GitHub Actions CI.  
Run locally with `npm run dev` after setting your Supabase keys.

## What you get
- Next.js 14 (TypeScript) + `pages/` router
- Supabase client already wired (`lib/supabaseClient.ts`)
- Example API route and UI component
- CI via GitHub Actions (`.github/workflows/ci.yml`) running lint, typecheck, tests, and build
- ESLint + Prettier + Vitest
- Example env file

## Prerequisites
- Node.js 20.x (use `.nvmrc` if you have `nvm`)
- A free Supabase project (https://supabase.com)

## Quick Start
1. **Install deps**
   ```bash
   npm install
   ```

2. **Copy envs**
   ```bash
   cp .env.local.example .env.local
   # Fill in your values
   ```

3. **Run**
   ```bash
   npm run dev
   ```
   Visit http://localhost:3000

## Supabase Setup
- In your Supabase project, go to **Project Settings → API** and copy:
  - `Project URL` → `NEXT_PUBLIC_SUPABASE_URL`
  - `anon public` key → `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- Paste them into `.env.local`.

## CI (GitHub Actions)
On every push/PR to `main`:
- Installs deps with `npm ci`
- Lints + typechecks
- Runs tests (`vitest`)
- Builds (`next build`)

Config file: `.github/workflows/ci.yml`

## Project Structure
```
next-supabase-starter/
├─ .github/workflows/ci.yml
├─ components/
├─ lib/
├─ pages/
│  ├─ api/hello.ts
│  └─ index.tsx
├─ public/
├─ styles/
├─ .env.local.example
├─ next.config.js
├─ package.json
├─ tsconfig.json
└─ README.md
```

## Notes
- This starter **does not** require any paid services.
- If env vars are missing, the homepage will tell you exactly what to set.
