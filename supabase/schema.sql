-- Run this in Supabase SQL Editor before enabling online career saves.
create table if not exists public.career_saves (
  user_id uuid not null references auth.users(id) on delete cascade,
  slot integer not null check (slot between 1 and 3),
  career_data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, slot)
);
alter table public.career_saves enable row level security;
create policy "Users can read their own career saves"
  on public.career_saves for select to authenticated using (auth.uid() = user_id);
create policy "Users can insert their own career saves"
  on public.career_saves for insert to authenticated with check (auth.uid() = user_id);
create policy "Users can update their own career saves"
  on public.career_saves for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can delete their own career saves"
  on public.career_saves for delete to authenticated using (auth.uid() = user_id);
