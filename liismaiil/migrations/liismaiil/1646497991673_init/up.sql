SET check_function_bodies = false;
CREATE FUNCTION public.set_current_timestamp_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$;
CREATE TABLE public.cards (
    title text NOT NULL,
    "titleSlug" text NOT NULL,
    _id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    tablet_id uuid NOT NULL,
    viewer_id uuid NOT NULL,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.tablets (
    title text NOT NULL,
    _id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    "titleSlug" text NOT NULL,
    description text NOT NULL,
    tags text[] NOT NULL,
    souras integer NOT NULL,
    words text[] NOT NULL,
    coll text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.viewers (
    login text NOT NULL,
    bio text NOT NULL,
    liims integer DEFAULT 1 NOT NULL,
    level text DEFAULT 1 NOT NULL,
    tabllets_id uuid,
    _id uuid DEFAULT public.gen_random_uuid() NOT NULL
);
ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (_id, "titleSlug");
ALTER TABLE ONLY public.tablets
    ADD CONSTRAINT tablets_pkey PRIMARY KEY (_id, "titleSlug");
ALTER TABLE ONLY public.tablets
    ADD CONSTRAINT "tablets_titleSlug_key" UNIQUE ("titleSlug");
ALTER TABLE ONLY public.viewers
    ADD CONSTRAINT viewers_login_key UNIQUE (login);
ALTER TABLE ONLY public.viewers
    ADD CONSTRAINT viewers_pkey PRIMARY KEY (_id, login);
CREATE TRIGGER set_public_tablets_updated_at BEFORE UPDATE ON public.tablets FOR EACH ROW EXECUTE FUNCTION public.set_current_timestamp_updated_at();
COMMENT ON TRIGGER set_public_tablets_updated_at ON public.tablets IS 'trigger to set value of column "updated_at" to current timestamp on row update';
