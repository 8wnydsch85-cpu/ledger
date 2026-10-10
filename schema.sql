-- Yusuf's Ledger — database setup.
-- Run this once in Supabase: SQL Editor → New query → paste → Run.

-- Your monthly plan: one row per account, holding the list of categories.
create table if not exists public.plans (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  categories jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

-- Every transaction you log.
create table if not exists public.transactions (
  id       uuid primary key default gen_random_uuid(),
  user_id  uuid not null references auth.users(id) on delete cascade,
  date     date not null,
  month    text not null,          -- "2026-10"
  cat      text not null,          -- category id from your plan
  amount   numeric(12,2) not null check (amount > 0),
  note     text default '',
  ts       bigint not null         -- when it was logged, for ordering
);
create index if not exists transactions_user_month on public.transactions (user_id, month);

-- Row Level Security: each signed-in person sees and edits only their own rows.
-- This is what makes it safe for the anon key to sit in config.js on a public site.
alter table public.plans enable row level security;
alter table public.transactions enable row level security;

drop policy if exists "own plan" on public.plans;
create policy "own plan" on public.plans
  for all to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "own transactions" on public.transactions;
create policy "own transactions" on public.transactions
  for all to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
