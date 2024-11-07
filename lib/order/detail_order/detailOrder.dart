import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helphin/controller/currenct.dart';
import 'package:helphin/order/order.dart';
import 'package:helphin/order/order_done/page.dart';
import 'package:intl/intl.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder({
    super.key,
    required this.layanan,
    required this.description,
    required this.matkul,
    required this.image,
  });
  final String layanan, description, matkul;
  final File image;

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  String? fileName;
  String? selectedOption;
  TextEditingController hargaController = TextEditingController();
  int harga = 0;

  void _showOptionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 180, vertical: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 3,
                          color: const Color(0xFFD8D8D8),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tawaran harga',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: TextField(
                            controller: hargaController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyConverter(),
                            ],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                color: Color(0xFF2D78DB),
                                fontSize: 30,
                              ),
                              hintText: 'Rp',
                              filled: true,
                              fillColor:
                                  const Color(0xFFCEE3FF).withOpacity(0.3),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF2D78DB),
                                  width: 0.3,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF2D78DB),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          )),
                      const SizedBox(height: 5),
                      const Text(
                        "Atur budgetmu dan buat helper senang!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 121, 121, 121)),
                      ),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: const [
                            // Additional ListView content
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom +
                        20, // Adjust for keyboard height
                    left: 20,
                    right: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF438EF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          harga = int.parse(hargaController.text);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Setujui Budget Sekarang",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showPaymentMethod() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          minChildSize: 0.2,
          maxChildSize: 0.6,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 180, vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 3,
                    color: const Color(0xFFD8D8D8),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Pilih Metode Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFCEE3FF).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8)),
                          child: RadioListTile<String>(
                            title: Row(
                              children: [
                                Image.asset("assets/images/cash.png"),
                                const SizedBox(
                                  width: 6,
                                ),
                                const Text(
                                  'Cash',
                                  style: TextStyle(
                                      color: Color(0xFF438EF2),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: 'Cash',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFCEE3FF).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8)),
                          child: RadioListTile<String>(
                            title: Row(
                              children: [
                                Image.asset("assets/images/bank.png"),
                                const SizedBox(
                                  width: 6,
                                ),
                                const Text(
                                  'Bank',
                                  style: TextStyle(
                                      color: Color(0xFF438EF2),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: 'Bank',
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 189, 189, 189)
                                    .withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 70,
                                offset: const Offset(0, -20),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF438EF2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: harga == 0
                                  ? const Text(
                                      "Pilih Jenis Layanan",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )
                                  : const Text(
                                      "Pilih Metode Pembayaran",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Detail Pesanan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF438EF2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  // konten lainnya
                  Container(
                    height: 2.0,
                    color: const Color(0xFF438EF2),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF74B0FF), Color(0xFF438EF2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 65,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/location_pin.png"),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Alamat 1",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Gedung 10 Asrama Telkom University ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFFFEB3B),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: const Color(0xFFCEE3FF).withOpacity(0.2),
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "MATEMATIKA",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "| ",
                                      style: TextStyle(
                                          color: Color(0xFFA5A5A5),
                                          fontSize: 20),
                                    ),
                                    Text(
                                      widget.matkul,
                                      style: const TextStyle(
                                        color: Color(0xFFA5A5A5),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF438EF2).withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Materi yang ditanyakan",
                              style: TextStyle(
                                color: Color(0xFF438EF2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // border: Border.all(color: Colors.red),
                                  ),
                                  child: Image.file(
                                    widget.image,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.description,
                              style: const TextStyle(color: Color(0xFF8E8E8E)),
                              textAlign: TextAlign.justify,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFFFDECEC),
                                      ),
                                      child: const Text(
                                        "EDIT",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF438EF2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            harga == 0
                                ? const Text(
                                    "Atur budget-mu sekarang!!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Row(
                                    children: [
                                      Image.asset("assets/images/dompet.png"),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      const Text(
                                        "Pilih Metode Pembayaran",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xFF438EF2),
                                    size: 14,
                                  ),
                                  onPressed: harga == 0
                                      ? _showOptionSheet
                                      : _showPaymentMethod,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF438EF2).withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Detail Pesanan",
                              style: TextStyle(
                                color: Color(0xFF438EF2),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            selectedOption != null
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Metode Pembayaran",
                                            style: TextStyle(
                                                color: Color(0xFF8E8E8E)),
                                          ),
                                          Text(
                                            selectedOption!,
                                            style: const TextStyle(
                                                color: Color(0xFF438EF2)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            harga != 0
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Total Harga",
                                            style: TextStyle(
                                                color: Color(0xFF8E8E8E)),
                                          ),
                                          Text(
                                            CurrencyConverter.toIDR(
                                              harga,
                                              2,
                                            ),
                                            style: const TextStyle(
                                              color: Color(0xFF438EF2),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Jenis Pesanan",
                                  style: TextStyle(color: Color(0xFF8E8E8E)),
                                ),
                                Text(
                                  widget.layanan,
                                  style:
                                      const TextStyle(color: Color(0xFF438EF2)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 189, 189, 189)
                        .withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 70,
                    offset: const Offset(0, -20),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF438EF2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderDone(),
                        ),
                      );
                    },
                    child: const Text(
                      "Hubungi Helper",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
