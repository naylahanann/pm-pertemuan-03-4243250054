# Tugas Rutin 3 - Kalkulator IP
## Identitas
- Nama  : Nayla Luthfiah Hanan
- NIM   : 4243250054
- Kelas : Ilmu Komputer D 2024

## Tangkapan layar
<img width="315" height="287" alt="image" src="https://github.com/user-attachments/assets/03542267-c262-4ff3-b9e1-733472e5d148" />

## Penjelasan
Dalam program Kalkulator IP Plus/Minus ini, higher-order function digunakan pada beberapa bagian kode. Contohnya adalah fungsi fold() pada fungsi hitungIp() untuk menjumlahkan total poin dan SKS dari seluruh mata kuliah. Selain itu, terdapat map() untuk mengubah data skala nilai menjadi bentuk teks dan mengambil nama mata kuliah yang perlu diperbaiki. Fungsi where() juga digunakan untuk menyaring mata kuliah yang memiliki bobot nilai di bawah batas perbaikan. Sementara itu, sort() digunakan untuk mengurutkan daftar mata kuliah berdasarkan nilai tertinggi melalui fungsi urutNilaiTertinggi().
Error handling digunakan untuk menangani kesalahan saat pengguna memasukkan data. Contohnya terdapat pada fungsi periksaSks() dan periksaNilai() yang melakukan pengecekan terhadap input SKS dan nilai. Jika data tidak sesuai, program akan menghasilkan exception. Kesalahan tersebut kemudian ditangani menggunakan try-catch pada bagian main(), yaitu on FormatException catch dan on Exception catch. Dengan begitu, program tidak langsung berhenti ketika pengguna memasukkan data yang salah, tetapi menampilkan pesan kesalahan dan melanjutkan proses.

## Penggunaan AI
Penggunaan AI pada tugas rutin 3 ini adalah untuk membantu saya dalam memahami apa yang dikerjakan.
