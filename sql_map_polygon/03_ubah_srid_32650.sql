ALTER TABLE public.administrasi_ar_5k
ALTER COLUMN geometry
-- Tentukan Tipe Geometri (MultiPolygon) dan SRID yang benar (32650)
TYPE geometry(MultiPolygon, 32650)
USING ST_SetSRID(geometry, 32650);