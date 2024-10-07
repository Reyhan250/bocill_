program WarungABC;

uses crt;

type
  BelanjaRecord = record
    NamaBarang: string;
    Jumlah: integer;
    Harga: real;
    Total: real;
  end;

var
  pilihan: integer;
  history: array[1..100] of BelanjaRecord;
  jumlahTransaksi: integer;
  jumlahData: integer;

const
  HargaMinyakGoreng = 32000.20;
  HargaDetergen = 30000.0;
  HargaBeras = 300000.0;
  HargaTelor = 31000.0;

procedure TampilMenu;
begin
  writeln('Warung ABC');
  writeln('1. Belanja');
  writeln('2. History Belanja');
  writeln('3. Keluar');
  write('Pilih menu: ');
end;

procedure TampilDaftarBarang;
begin
  writeln('--- Daftar Barang dan Harga ---');
  writeln('a. Minyak Goreng  - Rp ', HargaMinyakGoreng:0:0);
  writeln('b. Detergen       - Rp ', HargaDetergen:0:0);
  writeln('c. Beras          - Rp ', HargaBeras:0:0);
  writeln('d. Telor          - Rp ', HargaTelor:0:0);
end;

procedure PilihBarang(var barang: BelanjaRecord);
var
  pilihanBarang: char;
  hargaBarang: real;
begin
  TampilDaftarBarang;
  writeln;
  write('Pilihan barang: ');
  readln(pilihanBarang);
  
  case pilihanBarang of
    'a': begin
           barang.NamaBarang := 'Minyak Goreng';
           hargaBarang := HargaMinyakGoreng;
         end;
    'b': begin
           barang.NamaBarang := 'Detergen';
           hargaBarang := HargaDetergen;
         end;
    'c': begin
           barang.NamaBarang := 'Beras';
           hargaBarang := HargaBeras;
         end;
    'd': begin
           barang.NamaBarang := 'Telor';
           hargaBarang := HargaTelor;
         end;
  else
    writeln('Pilihan tidak valid.');
    exit;
  end;

  write('Jumlah: ');
  readln(barang.Jumlah);
  barang.Harga := hargaBarang;

  // Hitung total tanpa diskon
  barang.Total := barang.Harga * barang.Jumlah;

  // Terapkan diskon
  if barang.Total > 100000 then
  begin
    writeln('Anda mendapatkan diskon 10%!');
    barang.Total := barang.Total * 0.9;
  end;
end;

procedure Belanja;
var
  i: integer;
  barang: BelanjaRecord;
begin
  writeln('--- Belanja ---');
  write('Masukkan jumlah data belanja: ');
  readln(jumlahData);
  
  for i := 1 to jumlahData do
  begin
    PilihBarang(barang);
    inc(jumlahTransaksi);
    history[jumlahTransaksi] := barang;
    writeln('Barang ', i, ' berhasil ditambahkan dengan total Rp ', barang.Total:0:0);
  end;
end;

procedure TampilHistory;
var
  i: integer;
begin
  writeln('--- History Belanja ---');
  if jumlahTransaksi = 0 then
    writeln('Belum ada transaksi.')
  else
  begin
    for i := 1 to jumlahTransaksi do
    begin
      writeln(i, '. ', history[i].NamaBarang, ' - Jumlah: ', history[i].Jumlah, ' - Total: Rp ', history[i].Total:0:0);
    end;
  end;
end;

begin
  jumlahTransaksi := 0;
  repeat
    clrscr;
    TampilMenu;
    readln(pilihan);
    case pilihan of
      1: Belanja;
      2: TampilHistory;
    end;
    if pilihan <> 3 then
    begin
      writeln;
      writeln('Tekan enter untuk kembali ke menu.');
      readln;
    end;
  until pilihan = 3;
end.
