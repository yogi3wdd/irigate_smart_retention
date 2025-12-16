import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/color.dart';
import '../../widget/circle.dart';

class Notif extends StatefulWidget {
  const Notif({super.key});

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  Timestamp? userCreatedAt;

  @override
  void initState() {
    super.initState();
    loadUserCreatedAt();
  }

  Future<void> loadUserCreatedAt() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    setState(() {
      userCreatedAt =
          doc.data()?['createdAt'] ?? Timestamp.fromMillisecondsSinceEpoch(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userCreatedAt == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Pusat Notifikasi",
          style: GoogleFonts.ruda(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.text),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -224,
            left: -44,
            child: Circle(size: 500, color: AppColors.secondaryOpacity),
          ),
          Positioned(
            top: 574,
            left: -44,
            child: Circle(size: 500, color: AppColors.primaryOpacity),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notif')
                .where('time', isGreaterThanOrEqualTo: userCreatedAt)
                .orderBy('time', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("Belum ada notifikasi"));
              }
              return ListView(
                padding: EdgeInsets.fromLTRB(
                  16,
                  kToolbarHeight + 18,
                  16,
                  16,
                ),
                children: snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final String level = (data['level'] ?? '')
                      .toString()
                      .toLowerCase();
                  final String title = (data['title'] ?? 'Notifikasi')
                      .toString();
                  final String message = (data['message'] ?? '').toString();
                  if (level.isEmpty) return const SizedBox();

                  IconData icon;
                  Color color;

                  if (level == 'bahaya') {
                    icon = Icons.warning_amber_rounded;
                    color = Colors.redAccent;
                  } else if (level == 'siaga') {
                    icon = Icons.error_outline_rounded;
                    color = Colors.orangeAccent;
                  } else {
                    return const SizedBox();
                  }

                  return Card(
                    child: ListTile(
                      leading: Icon(icon, color: color),
                      title: Text(
                        title,
                        style: GoogleFonts.ruda(
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      subtitle: Text(
                        message,
                        style: GoogleFonts.ruda(color: AppColors.text),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
