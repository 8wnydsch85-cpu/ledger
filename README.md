# Yusuf's Ledger

A private monthly budget: plan versus actual by category, with a transaction log.
The site is hosted free on GitHub Pages, and your data lives in Supabase behind a sign-in.

## Setup (about 15 minutes, once)

### 1. Supabase: the database
1. Go to supabase.com, sign in, and create a **New project** (free plan). Note the database password somewhere safe.
2. When it has finished creating, open **SQL Editor → New query**, paste the whole of `schema.sql`, and press **Run**.
3. Open **Project Settings → API**. Copy the **Project URL** and the **anon public** key.
4. Open `config.js` and paste them in place of `YOUR-PROJECT-ID` and `YOUR-ANON-KEY`.

### 2. GitHub: the website
1. On github.com, create a **New repository** named `ledger`. Leave it empty.
2. Choose **uploading an existing file**, drag in every file from this folder, and **Commit changes**.
3. Open **Settings → Pages**. Under *Build and deployment*, choose **Deploy from a branch**, branch **main**, folder **/ (root)**, then **Save**.
4. After a minute the site is live at `https://<your-username>.github.io/ledger/`.

### 3. Sign in and lock the door
1. Open the site, tap **First time here? Create your account**, and choose an email and password.
2. If Supabase sends a confirmation email, confirm it, then sign in.
3. Back in Supabase, open **Authentication → Sign In / Providers** and turn **off** "Allow new users to sign up", so nobody else can make an account.

Your budget categories are filled in automatically the first time you sign in.

### 4. Home screen
On iPhone, open the site in Safari → **Share** → **Add to Home Screen**. It opens full-screen with its own icon, and stays signed in.

## Notes
- **Privacy:** a GitHub Pages site on a free account requires a public repository, so the code is visible, but your figures are not. They sit in Supabase, and the rules in `schema.sql` allow only your signed-in account to read or change them.
- **Inactivity:** Supabase pauses free projects after a week without use. Opening the ledger regularly prevents that, and a paused project can be resumed from the Supabase dashboard.
- **Changes:** edit the files on GitHub (pencil icon) and the site updates within a minute.
