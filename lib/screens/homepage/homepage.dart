import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F3FD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BAR
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage("assets/logo.png"),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Hello,",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            "Sasha",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const Icon(Icons.search, size: 28),
                ],
              ),

              const SizedBox(height: 25),

              // BANNER
              Container(
                height: 120,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffFCD8B6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Tidak Puas dengan Sesi Tutormu?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Lakukan Refund!",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Cek Sekarang",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/logo.png",
                      width: 80,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // KATEGORI HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Kategori",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                "Pilih Kategori Bidang yang Kamu Inginkan",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // KATEGORI CARDS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  categoryCard("Sistem Basis Data", Colors.orange),
                  categoryCard("Data Lakehouse", Colors.blue),
                  categoryCard("Pemrograman Dasar", Colors.pink),
                ],
              ),

              const SizedBox(height: 30),

              // REKOMENDASI HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Rekomendasi Tutor",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                "Cari Tutor Yang Cocok Untukmu",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // LIST TUTOR
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    tutorCard("Khalila", "Rp50.000/Sesi", Colors.orange),
                    tutorCard("Sasha", "Rp50.000/Sesi", Colors.pink),
                    tutorCard("Haryadi", "Rp1.000/Sesi", Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAV
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          // nanti tinggal arahkan ke page lain
        },
      ),
    );
  }

  // Widget kategori
  Widget categoryCard(String title, Color color) {
    return Container(
      width: 100,
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.book, size: 35, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  // Widget rekomendasi tutor
  Widget tutorCard(String name, String price, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 25,
            child: const Icon(Icons.person),
          ),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
