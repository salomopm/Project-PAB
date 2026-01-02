# Manual Menjalankan Script SQL PostGIS

Dokumentasi ini menjelaskan **urutan dan cara menjalankan script SQL** untuk pembuatan dan konversi data **MultiPolygon Administrasi Kota Bontang** menggunakan **PostgreSQL + PostGIS**.  
Dokumen ini ditujukan agar dapat langsung dibaca di repository **GitLab**.

---

## 📁 Struktur Folder Repository

Disarankan menggunakan struktur berikut:

```
repository-root/
│
├── sql/
│   ├── 01_create_table_multipolygon_bontang.sql
│   ├── 02_insert_polygon_kelurahan.sql
│   ├── 03_ubah_srid_32650.sql
│   └── 04_tambah_kolom_srid_4326.sql
│
└── docs/
    └── manual-menjalankan-script-postgis.md
```

Folder:
- **sql/** → berisi seluruh script SQL
- **docs/** → berisi dokumentasi manual (file ini)

---

## 🧩 Prasyarat

Sebelum menjalankan script, pastikan:

1. **PostgreSQL** sudah terinstall
2. **Extension PostGIS** tersedia dan aktif
3. User database memiliki hak akses `CREATE`, `ALTER`, dan `INSERT`

### Cek & Aktifkan PostGIS

```sql
CREATE EXTENSION IF NOT EXISTS postgis;
```

Verifikasi:
```sql
SELECT PostGIS_Version();
```

---

## 🗺️ Gambaran Proses

Alur pengerjaan data:

1. Membuat tabel MultiPolygon `administrasi_ar_5k`
2. Memasukkan data polygon kelurahan Kota Bontang
3. Mengubah SRID geometry ke **EPSG:32650** (UTM Zone 50N)
4. Menambahkan kolom hasil konversi ke **EPSG:4326** (WGS84) untuk kebutuhan web

Kolom **SRID 4326** inilah yang digunakan oleh:
👉 `https://sirumah.bontangkota.go.id`

---

## ▶️ Urutan Menjalankan Script SQL

### 1️⃣ Membuat Tabel MultiPolygon

**File:**
```
sql/01_create_table_multipolygon_bontang.sql
```

**Fungsi:**
- Membuat tabel `administrasi_ar_5k`
- Mendefinisikan kolom geometry bertipe `MultiPolygon`

**Jalankan:**
```sql
\i sql/01_create_table_multipolygon_bontang.sql
```

Pastikan tabel berhasil dibuat:
```sql
\d administrasi_ar_5k
```

---

### 2️⃣ Insert Data Polygon Kelurahan

**File:**
```
sql/02_insert_polygon_kelurahan.sql
```

**Fungsi:**
- Memasukkan data polygon kelurahan Kota Bontang ke tabel `administrasi_ar_5k`

**Jalankan:**
```sql
\i sql/02_insert_polygon_kelurahan.sql
```

Verifikasi data:
```sql
SELECT COUNT(*) FROM administrasi_ar_5k;
```

---

### 3️⃣ Mengubah SRID Geometry ke EPSG:32650

**File:**
```
sql/03_ubah_srid_32650.sql
```

**Fungsi:**
- Mengubah SRID geometry menjadi **EPSG:32650**
- Digunakan untuk penggambaran polygon berbasis UTM

**Catatan:**
Pastikan SRID awal data sudah diketahui sebelum konversi.

**Jalankan:**
```sql
\i sql/03_ubah_srid_32650.sql
```

Cek SRID:
```sql
SELECT DISTINCT ST_SRID(geom) FROM administrasi_ar_5k;
```

---

### 4️⃣ Menambah Kolom Geometry SRID 4326 (Untuk Web)

**File:**
```
sql/04_tambah_kolom_srid_4326.sql
```

**Fungsi:**
- Menambahkan kolom geometry baru
- Mengonversi geometry dari **EPSG:32650 → EPSG:4326 (WGS84)**
- Kolom ini digunakan oleh aplikasi web **sirumah.bontangkota.go.id**

**Jalankan:**
```sql
\i sql/04_tambah_kolom_srid_4326.sql
```

Verifikasi:
```sql
SELECT
  ST_SRID(geom) AS srid_asli,
  ST_SRID(geom_4326) AS srid_web
FROM administrasi_ar_5k
LIMIT 1;
```

---

## ✅ Hasil Akhir

Tabel `administrasi_ar_5k` akan memiliki:

- Geometry utama: **EPSG:32650** (untuk analisis / pemetaan lokal)
- Geometry web: **EPSG:4326** (untuk visualisasi web / GIS online)

---

## 📌 Catatan Tambahan

- Jangan menghapus kolom geometry asli (32650)
- Gunakan kolom **4326** hanya untuk kebutuhan web
- Jika data diperbarui, pastikan kolom 4326 ikut di-update

---

## 👤 Penanggung Jawab

Dokumentasi ini dibuat untuk kebutuhan internal dan pengelolaan data spasial
Kota Bontang berbasis PostgreSQL + PostGIS.

---

📄 **File ini disarankan disimpan sebagai:**
```
docs/manual-menjalankan-script-postgis.md
```

