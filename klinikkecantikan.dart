import 'dart:io';

class Queue {
  List<String> _data = [];
  int _head = 0;
  int _tail = 0;

  void enqueue(String item) {
    _data.add(item);
    _tail++;
  }

  String? dequeue() {
    if (_head == _tail) {
      return null; // Queue is empty
    }

    String item = _data[_head];
    _head++;

    return item;
  }

  bool isEmpty() {
    return _head == _tail;
  }

  List<String> toList() {
    return _data.sublist(_head, _tail);
  }
}

class Stack {
  List<String> _data = [];

  void push(String item) {
    _data.add(item);
  }

  String? pop() {
    if (_data.isEmpty) {
      return null; // Stack is empty
    }

    return _data.removeLast();
  }

  bool isEmpty() {
    return _data.isEmpty;
  }

  List<String> toList() {
    return _data.reversed.toList();
  }
}

class AntrianKlinikKecantikan {
  Queue facialQueue = Queue();
  Queue botoxQueue = Queue();
  Queue acneTreatmentQueue = Queue();

  List<String> dipanggil = [];
  List<String> dilayani = [];
  Map<String, int> pembayaran = {};
  Stack historyStack = Stack(); // Stack untuk menyimpan sejarah layanan

  void tambahAntrian(String namaPelanggan, String layanan) {
    switch (layanan) {
      case 'Facial':
        facialQueue.enqueue(namaPelanggan);
        break;
      case 'Botox':
        botoxQueue.enqueue(namaPelanggan);
        break;
      case 'Acne Treatment':
        acneTreatmentQueue.enqueue(namaPelanggan);
        break;
      default:
        print("Layanan tidak valid.");
        return;
    }

    print("$namaPelanggan telah ditambahkan ke dalam antrian $layanan.");
  }

  void panggilPelanggan() {
    String? pelangganYangDipanggil;

    if (!facialQueue.isEmpty()) {
      pelangganYangDipanggil = facialQueue.dequeue();
    } else if (!botoxQueue.isEmpty()) {
      pelangganYangDipanggil = botoxQueue.dequeue();
    } else if (!acneTreatmentQueue.isEmpty()) {
      pelangganYangDipanggil = acneTreatmentQueue.dequeue();
    } else {
      print("Antrian kosong.");
      return;
    }

    if (pelangganYangDipanggil != null) {
      dipanggil.add(pelangganYangDipanggil);
      print("Pelanggan yang dipanggil: $pelangganYangDipanggil");
    }
  }

  void layaniPelanggan() {
    if (dipanggil.isEmpty) {
      print("Belum ada pelanggan yang dipanggil.");
      return;
    }

    String pelangganYangDilayani = dipanggil.removeAt(0);
    dilayani.add(pelangganYangDilayani);
    historyStack.push(pelangganYangDilayani); // Tambahkan ke stack sejarah
    print("Pelanggan yang dilayani: $pelangganYangDilayani");

    stdout.write("Masukkan jumlah pembayaran untuk $pelangganYangDilayani: ");
    String? jumlahPembayaran = stdin.readLineSync();
    if (jumlahPembayaran != null && jumlahPembayaran.isNotEmpty) {
      print("Pembayaran sebesar $jumlahPembayaran diterima. Terima kasih!");
      pembayaran[pelangganYangDilayani] = int.parse(jumlahPembayaran);
    } else {
      print("Pembayaran tidak valid.");
    }
  }

  void tampilkanAntrian(Queue antrian, String jenisList) {
    print("=== $jenisList ===");
    List<String> list = antrian.toList();
    if (list.isEmpty) {
      print("$jenisList kosong.");
    } else {
      for (int i = 0; i < list.length; i++) {
        print("$jenisList ke-${i + 1}: ${list[i]}");
      }
    }
  }

  void tampilkanDaftar(List<String> daftar, String jenisList) {
    print("=== $jenisList ===");
    if (daftar.isEmpty) {
      print("$jenisList kosong.");
    } else {
      for (int i = 0; i < daftar.length; i++) {
        print("$jenisList ke-${i + 1}: ${daftar[i]}");
      }
    }
  }

  void tampilkanAntrianPembayaran() {
    print("\n=== Pembayaran ===");
    for (var entry in pembayaran.entries) {
      String namaPelanggan = entry.key;
      int jumlahPembayaran = entry.value;
      print("$namaPelanggan: $jumlahPembayaran");
    }
  }

  void tampilkanRiwayatLayanan() {
    print("\n=== Riwayat Layanan ===");
    List<String> list = historyStack.toList();
    if (list.isEmpty) {
      print("Riwayat layanan kosong.");
    } else {
      for (int i = 0; i < list.length; i++) {
        print("Layanan ke-${i + 1}: ${list[i]}");
      }
    }
  }

  void jalankanAntrian() {
    while (true) {
      print("\nMenu:");
      print("1. Tambahkan Pelanggan");
      print("2. Panggil Pelanggan");
      print("3. Layani Pelanggan");
      print("4. Tampilkan Antrian");
      print("5. Tampilkan Pembayaran");
      print("6. Tampilkan Riwayat Layanan");
      print("7. Keluar");
      stdout.write("Pilih menu (1/2/3/4/5/6/7): ");
      String? menu = stdin.readLineSync();

      switch (menu) {
        case '1':
          stdout.write("Masukkan nama pelanggan: ");
          String? namaPelanggan = stdin.readLineSync();
          if (namaPelanggan != null) {
            stdout.write("Masukkan jenis keperawatan (Facial/Botox/Acne Treatment): ");
            String? jenisKeperawatan = stdin.readLineSync();
            if (jenisKeperawatan != null) {
              tambahAntrian(namaPelanggan, jenisKeperawatan);
            }
          }
          break;
        case '2':
          panggilPelanggan();
          break;
        case '3':
          layaniPelanggan();
          break;
        case '4':
          tampilkanAntrian(facialQueue, "Antrian Facial");
          tampilkanAntrian(botoxQueue, "Antrian Botox");
          tampilkanAntrian(acneTreatmentQueue, "Antrian Penghilangan Bekas Jerawat");
          tampilkanDaftar(dipanggil, "Pelanggan yang Dipanggil");
          tampilkanDaftar(dilayani, "Pelanggan yang Dilayani");
          break;
        case '5':
          tampilkanAntrianPembayaran();
          break;
        case '6':
          tampilkanRiwayatLayanan();
          break;
        case '7':
          print("Keluar dari program.");
          return;
        default:
          print("Menu tidak valid.");
      }
    }
  }
}

void main() {
  AntrianKlinikKecantikan antrianKlinik = AntrianKlinikKecantikan();
  antrianKlinik.jalankanAntrian();
}
