# Manual Menjalankan Script SQL PostGIS

Dokumentasi ini menjelaskan **urutan dan cara menjalankan script SQL** untuk pembuatan dan konversi data **MultiPolygon Administrasi Kota Bontang**.  

---

## 📁 Struktur Folder Repository

Berikut merupkan struktur folder:

```
repository-root/
│
├── sql_map_polygon/
│   ├── 01_create_table_multipolygon_bontang.sql
│   ├── 02_insert_polygon_kelurahan.sql
│   ├── 03_ubah_srid_32650.sql
│   ├── 04_tambah_kolom_srid_4326.sql
│   └── manual_menjalankan_script_sql_polygon_kota_botang.md
```

Folder:
- **sql_map_polygon/** → berisi seluruh script SQL dan juga manual menjalankan script sql untuk peta polygon
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
3. Membuat SRID geometry ke **EPSG:32650** (UTM Zone 50N)
4. Menambahkan kolom hasil konversi ke **EPSG:4326** (WGS84) untuk kebutuhan web

Kolom **SRID 4326** inilah yang digunakan oleh:
👉 `https://sirumah.bontangkota.go.id`

---

## ▶️ Urutan Menjalankan Script SQL

### 1️⃣ Membuat Tabel MultiPolygon

**File:**
```
01_create_table_multipolygon_bontang.sql
```

**Fungsi:**
- Membuat tabel `administrasi_ar_5k`
- Mendefinisikan kolom geometry bertipe `MultiPolygon`

---

### 2️⃣ Insert Data Polygon Kelurahan

**File:**
```
02_insert_polygon_kelurahan.sql
```

**Fungsi:**
- Memasukkan data polygon kelurahan Kota Bontang ke tabel `administrasi_ar_5k`

Verifikasi data:
```sql
SELECT * FROM administrasi_ar_5k;
```

---

### 3️⃣ Mengubah SRID Geometry ke EPSG:32650

**File:**
```
03_ubah_srid_32650.sql
```

**Fungsi:**
- Mengubah SRID geometry menjadi **EPSG:32650**
- Digunakan untuk penggambaran polygon berbasis UTM

**Catatan:**
Pastikan SRID awal data sudah diketahui sebelum konversi.

Cek SRID:
```sql
SELECT DISTINCT ST_SRID(geom) FROM administrasi_ar_5k;
```

---

### 4️⃣ Menambah Kolom Geometry SRID 4326 (Untuk Web)

**File:**
```
04_tambah_kolom_srid_4326.sql
```

**Fungsi:**
- Menambahkan kolom geometry baru
- Mengonversi geometry dari **EPSG:32650 → EPSG:4326 (WGS84)**
- Kolom ini digunakan oleh aplikasi web **sirumah.bontangkota.go.id**

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

- kolom 'geometry'  : **EPSG:32650** 
- kolom 'geom_4326' : **EPSG:4326** (yang dipakai untuk visualisasi web)

---

## 📌 Catatan Tambahan

- Jangan menghapus kolom geometry asli (32650) (incase menggunakan berbasis UTM)
- Gunakan kolom **4326** hanya untuk kebutuhan web
- Jika data diperbarui, pastikan kolom 4326 ikut di-update

---

## 👤 Penanggung Jawab

Dokumentasi ini dibuat untuk kebutuhan internal dan pengelolaan data spasial
Kota Bontang

---

