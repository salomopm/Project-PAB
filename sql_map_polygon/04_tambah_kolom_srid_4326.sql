ALTER TABLE public.administrasi_ar_5k
  ADD COLUMN geom_4326 geometry(MultiPolygon, 4326);

UPDATE public.administrasi_ar_5k
  SET geom_4326 = ST_Transform(geometry, 4326);
