// Tugas Rutin 3: Kalkulator IP
// Nama: Nayla Luthfiah Hanan  NIM: 4243250054
import 'dart:io';

typedef MataKuliah = ({String nama, int sks, String nilai});

const skala = <String, double>{
  'A': 4.0,
  'A-': 3.7,
  'B+': 3.3,
  'B': 3.0,
  'B-': 2.7,
  'C+': 2.3,
  'C': 2.0,
  'D': 1.0,
  'E': 0.0,
};
const batasPerbaikan = 2.0;

String baca(String label) {
  stdout.write('${label.padRight(8)}: ');
  return (stdin.readLineSync() ?? '').trim();
}

int periksaSks(String teks) {
  final sks = int.tryParse(teks);
  if (sks == null) throw FormatException('SKS harus berupa angka');
  if (sks < 1 || sks > 6) throw Exception('SKS harus 1-6');
  return sks;
}

String periksaNilai(String teks) {
  final nilai = teks.toUpperCase();
  if (!skala.containsKey(nilai)) {
    throw Exception('Nilai tidak dikenal (${skala.keys.join(', ')})');
  }
  return nilai;
}

double hitungIp(List<MataKuliah> d) {
  final poin = d.fold<double>(
    0.0,
    (s, m) => s + (skala[m.nilai] ?? 0.0) * m.sks,
  );
  final sks = d.fold<int>(0, (s, m) => s + m.sks);
  return sks == 0 ? 0.0 : poin / sks;
}

String predikat(
  double ip, {
  double sangat = 3.5,
  double baik = 3.0,
  double cukup = 2.0,
}) {
  if (ip >= sangat) return 'Sangat Memuaskan';
  if (ip >= baik) return 'Memuaskan';
  if (ip >= cukup) return 'Cukup';
  return 'Kurang';
}

/// Pembanding: SKS terbanyak dulu, jika sama urut nama A-Z.
int urutSksLaluNama(MataKuliah a, MataKuliah b) {
  final c = b.sks.compareTo(a.sks);
  return c != 0 ? c : a.nama.toLowerCase().compareTo(b.nama.toLowerCase());
}

/// Pembanding: bobot tertinggi dulu; jika sama, SKS terbanyak lalu nama A-Z.
int urutNilaiTertinggi(MataKuliah a, MataKuliah b) {
  final c = (skala[b.nilai] ?? 0.0).compareTo(skala[a.nilai] ?? 0.0);
  return c != 0 ? c : urutSksLaluNama(a, b);
}

void main() {
  final daftar = <MataKuliah>[];
  print('=== KALKULATOR IP PLUS/MINUS ===');
  print('Skala: ${skala.entries.map((e) => '${e.key}=${e.value}').join('  ')}');

  String nama;
  do {
    nama = baca('Nama MK');
    if (nama.isEmpty) continue; // lompat ke pengecekan while
    try {
      final sks = periksaSks(baca('SKS'));
      final nilai = periksaNilai(baca('Nilai'));
      daftar.add((nama: nama, sks: sks, nilai: nilai));
    } on FormatException catch (e) {
      // FormatException lebih spesifik, jadi ditulis lebih dulu.
      print('Data diabaikan: ${e.message}');
    } on Exception catch (e) {
      print('Data diabaikan: ${e.toString().replaceFirst('Exception: ', '')}');
    }
  } while (nama.isNotEmpty);

  if (daftar.isEmpty) {
    print('Belum ada data yang valid.');
    return;
  }

  daftar.sort(urutNilaiTertinggi);
  print('\n${'Mata Kuliah'.padRight(24)} SKS  Nilai  Bobot');
  for (final m in daftar) {
    print(
      '${m.nama.padRight(24)} ${m.sks.toString().padLeft(3)}  '
      '${m.nilai.padRight(5)}  ${skala[m.nilai]}',
    );
  }

  final ip = hitungIp(daftar);
  print('\nJumlah MK : ${daftar.length}');
  print('Total SKS : ${daftar.fold<int>(0, (s, m) => s + m.sks)}');
  print('IP        : ${ip.toStringAsFixed(2)} (${predikat(ip)})');

  final perbaikan = daftar
      .where((m) => (skala[m.nilai] ?? 0.0) < batasPerbaikan)
      .map((m) => m.nama)
      .toList();
  print(
    perbaikan.isEmpty
        ? 'Semua mata kuliah sudah lulus.'
        : 'Perlu diperbaiki: ${perbaikan.join(', ')}',
  );
}
