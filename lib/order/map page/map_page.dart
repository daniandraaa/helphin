import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.red,
            child: Column(
              children: [
                Image.asset('assets/images/mapss.jpg'),
                const Text("halo"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(
                        0, 255, 255, 255), // Warna transparan di bagian atas
                    Color(0xFFF9FBFE), // Warna putih di bagian bawah
                  ],
                  stops: [
                    0.04, // Menentukan posisi transparan pada 5% dari tinggi kontainer (sekitar 30px pada layar standar)
                    0.17, // Posisi berakhir di bagian bawah gradien
                  ],
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/fotoaja.jpg'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lestari Indah",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "082235295739",
                                style: TextStyle(
                                    color: Color(0xFF0455BF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Color(0xFF3983F3),
                          size: 24,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Perkiraan Helper Sampai",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF3983F3)),
                              ),
                              Text(
                                "15 Menit",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xFF3983F3),
                          size: 24,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lokasimu",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF3983F3)),
                              ),
                              Text(
                                "Jl. Sukabirus no.187, Bojongsoang",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
