-- Supabase/PostgreSQL schema for Maqsade Nahayi Farda
create extension if not exists "pgcrypto";

create type public.user_role as enum ('ADMIN','STAFF','STUDENT');
create type public.application_status as enum ('NEW','CONTACTED','DOCUMENTS_PENDING','UNDER_REVIEW','SUBMITTED','ADMITTED','VISA_PROCESS','COMPLETED','REJECTED','CANCELLED');
create type public.consultation_status as enum ('NEW','CONTACTED','FOLLOW_UP','CONVERTED','CLOSED');
create type public.document_status as enum ('PENDING','VERIFIED','REJECTED');
create type public.content_status as enum ('DRAFT','PUBLISHED','ARCHIVED');
create type public.admission_status as enum ('DRAFT','PENDING_REVIEW','PUBLISHED','ARCHIVED');

create table public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 user_id uuid unique not null references auth.users(id) on delete cascade,
 first_name text, last_name text, phone text, email text,
 role public.user_role not null default 'STUDENT',
 avatar_url text, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);

create table public.countries (
 id uuid primary key default gen_random_uuid(), name_fa text not null, name_en text not null,
 slug text unique not null, code text, description text, hero_image text, is_active boolean default true, created_at timestamptz default now()
);

create table public.students (
 id uuid primary key default gen_random_uuid(), profile_id uuid unique not null references public.profiles(id) on delete cascade,
 birth_date date, gender text, nationality text, current_country text, current_city text,
 education_level text, current_field text, gpa numeric(5,2), graduation_year int, language_level text,
 budget text, notes text, created_at timestamptz default now(), updated_at timestamptz default now()
);

create table public.universities (
 id uuid primary key default gen_random_uuid(), country_id uuid references public.countries(id),
 name_fa text not null, name_en text not null, slug text unique not null, logo_url text, cover_image text,
 city text, website text, type text, description text, ranking_text text, language_options text[],
 tuition_min numeric, tuition_max numeric, currency text,
 admission_requirements text, documents_required jsonb default '[]'::jsonb, scholarship_info text,
 accommodation_info text, is_featured boolean default false, is_active boolean default true,
 created_at timestamptz default now(), updated_at timestamptz default now()
);

create table public.fields (
 id uuid primary key default gen_random_uuid(), name_fa text not null, name_en text, slug text unique not null,
 description text, icon text, is_active boolean default true, created_at timestamptz default now()
);

create table public.university_fields (
 id uuid primary key default gen_random_uuid(), university_id uuid references public.universities(id) on delete cascade,
 field_id uuid references public.fields(id) on delete cascade, unique(university_id,field_id)
);

create table public.programs (
 id uuid primary key default gen_random_uuid(), university_id uuid references public.universities(id) on delete cascade,
 field_id uuid references public.fields(id), name_fa text not null, name_en text, degree text,
 language text, duration text, tuition numeric, currency text, requirements text, description text,
 is_active boolean default true, created_at timestamptz default now()
);

create table public.consultation_requests (
 id uuid primary key default gen_random_uuid(), first_name text not null, last_name text not null,
 phone text not null, email text, age int, country_interest text, degree text, current_field text,
 desired_field text, gpa text, language_level text, budget text, message text,
 status public.consultation_status not null default 'NEW', assigned_to uuid references public.profiles(id),
 created_at timestamptz default now(), updated_at timestamptz default now()
);

create table public.applications (
 id uuid primary key default gen_random_uuid(), student_id uuid not null references public.students(id) on delete cascade,
 country_id uuid references public.countries(id), university_id uuid references public.universities(id),
 program_id uuid references public.programs(id), application_number text unique not null,
 status public.application_status not null default 'NEW', priority int default 0, assigned_to uuid references public.profiles(id),
 notes text, submitted_at timestamptz, created_at timestamptz default now(), updated_at timestamptz default now()
);

create table public.application_documents (
 id uuid primary key default gen_random_uuid(), application_id uuid not null references public.applications(id) on delete cascade,
 document_type text not null, file_name text not null, file_url text not null, status public.document_status default 'PENDING',
 admin_note text, uploaded_at timestamptz default now(), verified_at timestamptz
);

create table public.blog_categories (id uuid primary key default gen_random_uuid(), name text not null, slug text unique not null);
create table public.blog_posts (
 id uuid primary key default gen_random_uuid(), title text not null, slug text unique not null, excerpt text,
 content text not null, cover_image text, author_id uuid references public.profiles(id), category_id uuid references public.blog_categories(id),
 status public.content_status default 'DRAFT', seo_title text, seo_description text, published_at timestamptz,
 created_at timestamptz default now(), updated_at timestamptz default now()
);

create table public.faqs (id uuid primary key default gen_random_uuid(), question text not null, answer text not null, category text, sort_order int default 0, is_active boolean default true);
create table public.contact_messages (id uuid primary key default gen_random_uuid(), name text not null, phone text, email text, subject text, message text not null, status text default 'NEW', created_at timestamptz default now());
create table public.testimonials (id uuid primary key default gen_random_uuid(), name text, country text, university text, field text, content text not null, image text, is_published boolean default false, created_at timestamptz default now());

create table public.admissions (
 id uuid primary key default gen_random_uuid(), student_id uuid references public.students(id), university_id uuid references public.universities(id),
 program_id uuid references public.programs(id), country_id uuid references public.countries(id),
 degree text, field text, admission_year int, admission_type text, title text not null, description text,
 image_url text, thumbnail_url text, is_featured boolean default false, is_published boolean default false,
 status public.admission_status default 'DRAFT',
 show_student_name boolean default false, show_student_photo boolean default false, show_university boolean default true,
 show_field boolean default true, show_year boolean default true, created_at timestamptz default now(), updated_at timestamptz default now()
);

create table public.media_library (
 id uuid primary key default gen_random_uuid(), file_path text not null, file_name text not null, category text,
 alt_text text, caption text, is_featured boolean default false, created_by uuid references public.profiles(id),
 created_at timestamptz default now()
);

create table public.notifications (
 id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
 title text not null, body text not null, is_read boolean default false, created_at timestamptz default now()
);

create table public.site_settings (
 id boolean primary key default true, site_name text default 'مقصد نهایی فردا', logo_path text, favicon_path text,
 primary_color text default '#0B1F3A', secondary_color text default '#2563EB', phone text,
 whatsapp text, email text, address text, social_links jsonb default '{}'::jsonb, seo_defaults jsonb default '{}'::jsonb,
 footer_text text, analytics_id text, pixel_id text, updated_at timestamptz default now()
);

-- Helper functions
create or replace function public.is_admin_or_staff() returns boolean language sql stable security definer set search_path=public
as $$ select exists(select 1 from public.profiles where user_id=auth.uid() and role in ('ADMIN','STAFF')); $$;
create or replace function public.is_admin() returns boolean language sql stable security definer set search_path=public
as $$ select exists(select 1 from public.profiles where user_id=auth.uid() and role='ADMIN'); $$;

-- RLS
alter table public.profiles enable row level security;
alter table public.students enable row level security;
alter table public.applications enable row level security;
alter table public.application_documents enable row level security;
alter table public.consultation_requests enable row level security;
alter table public.notifications enable row level security;
alter table public.admissions enable row level security;
alter table public.media_library enable row level security;
alter table public.universities enable row level security;
alter table public.programs enable row level security;
alter table public.fields enable row level security;
alter table public.countries enable row level security;
alter table public.blog_posts enable row level security;
alter table public.faqs enable row level security;
alter table public.testimonials enable row level security;

create policy "profile self read" on public.profiles for select using (user_id=auth.uid() or public.is_admin_or_staff());
create policy "profile self update" on public.profiles for update using (user_id=auth.uid() or public.is_admin());
create policy "admin insert profiles" on public.profiles for insert with check (public.is_admin());

create policy "student self or staff" on public.students for select using (profile_id in (select id from public.profiles where user_id=auth.uid()) or public.is_admin_or_staff());
create policy "student self update" on public.students for update using (profile_id in (select id from public.profiles where user_id=auth.uid()) or public.is_admin_or_staff());
create policy "staff manage students" on public.students for all using (public.is_admin_or_staff()) with check (public.is_admin_or_staff());

create policy "student applications read" on public.applications for select using (student_id in (select s.id from public.students s join public.profiles p on p.id=s.profile_id where p.user_id=auth.uid()) or public.is_admin_or_staff());
create policy "student applications insert" on public.applications for insert with check (student_id in (select s.id from public.students s join public.profiles p on p.id=s.profile_id where p.user_id=auth.uid()) or public.is_admin_or_staff());
create policy "staff applications manage" on public.applications for all using (public.is_admin_or_staff()) with check (public.is_admin_or_staff());

create policy "student docs read" on public.application_documents for select using (application_id in (select a.id from public.applications a join public.students s on s.id=a.student_id join public.profiles p on p.id=s.profile_id where p.user_id=auth.uid()) or public.is_admin_or_staff());
create policy "student docs insert" on public.application_documents for insert with check (application_id in (select a.id from public.applications a join public.students s on s.id=a.student_id join public.profiles p on p.id=s.profile_id where p.user_id=auth.uid()) or public.is_admin_or_staff());
create policy "staff docs manage" on public.application_documents for all using (public.is_admin_or_staff()) with check (public.is_admin_or_staff());

create policy "public published admissions" on public.admissions for select using (is_published=true and status='PUBLISHED' or public.is_admin_or_staff());
create policy "staff admissions manage" on public.admissions for all using (public.is_admin_or_staff()) with check (public.is_admin_or_staff());

create policy "public active universities" on public.universities for select using (is_active=true or public.is_admin_or_staff());
create policy "public active programs" on public.programs for select using (is_active=true or public.is_admin_or_staff());
create policy "public active fields" on public.fields for select using (is_active=true or public.is_admin_or_staff());
create policy "public active countries" on public.countries for select using (is_active=true or public.is_admin_or_staff());
create policy "public published blogs" on public.blog_posts for select using (status='PUBLISHED' or public.is_admin_or_staff());
create policy "public faq" on public.faqs for select using (is_active=true or public.is_admin_or_staff());
create policy "public testimonials" on public.testimonials for select using (is_published=true or public.is_admin_or_staff());

create policy "public can create consultation" on public.consultation_requests for insert with check (true);
create policy "staff consultation manage" on public.consultation_requests for all using (public.is_admin_or_staff()) with check (public.is_admin_or_staff());
create policy "own notifications" on public.notifications for select using (user_id=auth.uid() or public.is_admin_or_staff());
create policy "own notifications update" on public.notifications for update using (user_id=auth.uid() or public.is_admin_or_staff());
create policy "staff media manage" on public.media_library for all using (public.is_admin_or_staff()) with check (public.is_admin_or_staff());
create policy "public media read" on public.media_library for select using (true);

-- Storage buckets. Create these in Storage UI if your project disallows SQL bucket creation.
insert into storage.buckets (id,name,public) values
('public-assets','public-assets',true),
('university-images','university-images',true),
('blog-images','blog-images',true),
('admissions','admissions',true),
('student-private-documents','student-private-documents',false)
on conflict (id) do nothing;

-- Public buckets: read public files, staff/admin upload.
create policy "public asset read" on storage.objects for select using (bucket_id in ('public-assets','university-images','blog-images','admissions'));
create policy "staff public upload" on storage.objects for insert with check (bucket_id in ('public-assets','university-images','blog-images','admissions') and public.is_admin_or_staff());
create policy "staff public delete" on storage.objects for delete using (bucket_id in ('public-assets','university-images','blog-images','admissions') and public.is_admin_or_staff());

-- Private student documents: access only to owner or staff/admin.
create policy "private docs read" on storage.objects for select using (
 bucket_id='student-private-documents' and (
   public.is_admin_or_staff() or
   exists(select 1 from public.application_documents d
          join public.applications a on a.id=d.application_id
          join public.students s on s.id=a.student_id
          join public.profiles p on p.id=s.profile_id
          where p.user_id=auth.uid() and d.file_url=storage.objects.name)
 )
);
create policy "staff private docs upload" on storage.objects for insert with check (bucket_id='student-private-documents' and public.is_admin_or_staff());
