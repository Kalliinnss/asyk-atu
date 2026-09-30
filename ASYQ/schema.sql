-- Выполнить в Supabase: SQL Editor -> New query -> Run
create table progress(user_id uuid primary key references auth.users on delete cascade,best int default 0,lv int default 0,score int default 0,clears int default 0,in_round boolean default false,seen boolean default false,updated_at timestamptz default now());
create table results(id bigint generated always as identity primary key,user_id uuid references auth.users on delete cascade,score int not null,stages int default 0,created_at timestamptz default now());
alter table progress enable row level security;
alter table results enable row level security;
create policy "own progress" on progress for all using(auth.uid()=user_id) with check(auth.uid()=user_id);
create policy "own results read" on results for select using(auth.uid()=user_id);
create policy "own results insert" on results for insert with check(auth.uid()=user_id);
