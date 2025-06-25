import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AjukanPemesanan extends StatefulWidget {
  final String imageUrl;
  final String namaJasa;
  final String harga;

  const AjukanPemesanan({
    super.key,
    required this.imageUrl,
    required this.namaJasa,
    required this.harga,
  });

  static const routeName = '/ajukanpemesanan';

  @override
  _AjukanPemesananState createState() => _AjukanPemesananState();
}

class _AjukanPemesananState extends State<AjukanPemesanan>
    with TickerProviderStateMixin {
  String selectedPayment = 'QRIS';
  bool hasPromoCode = false;
  String promoCode = '';
  double discount = 0.0;
  bool isProcessing = false;

  late AnimationController _slideController;
  late AnimationController _bounceController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _bounceAnimation;

  final TextEditingController _promoController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _bounceController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _bounceController.dispose();
    _promoController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  double get originalPrice {
    String priceStr =
        widget.harga.replaceAll('Rp', '').replaceAll('.', '').trim();
    return double.tryParse(priceStr) ?? 0;
  }

  double get finalPrice {
    return originalPrice - discount;
  }

  void _applyPromoCode() {
    String code = _promoController.text.trim().toUpperCase();
    setState(() {
      if (code == 'DISKON10') {
        discount = originalPrice * 0.1;
        hasPromoCode = true;
        promoCode = code;
        _showSnackBar(
          'Kode promo berhasil diterapkan! Diskon 10%',
          Colors.green,
        );
      } else if (code == 'NEWUSER') {
        discount = originalPrice * 0.15;
        hasPromoCode = true;
        promoCode = code;
        _showSnackBar(
          'Selamat datang! Diskon 15% untuk pengguna baru',
          Colors.green,
        );
      } else if (code.isEmpty) {
        _showSnackBar('Masukkan kode promo terlebih dahulu', Colors.orange);
      } else {
        _showSnackBar('Kode promo tidak valid', Colors.red);
      }
    });
  }

  void _removePromoCode() {
    setState(() {
      hasPromoCode = false;
      promoCode = '';
      discount = 0.0;
      _promoController.clear();
    });
    _showSnackBar('Kode promo dihapus', Colors.grey);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  Future<void> _processPayment() async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showSnackBar('Anda harus login terlebih dahulu', Colors.red);
        return;
      }

      // Simulate payment processing
      await Future.delayed(Duration(seconds: 2));

      // Save order to Firestore
      await FirebaseFirestore.instance.collection('orders').add({
        'userId': user.uid,
        'jasaName': widget.namaJasa,
        'originalPrice': originalPrice,
        'discount': discount,
        'finalPrice': finalPrice,
        'paymentMethod': selectedPayment,
        'promoCode': hasPromoCode ? promoCode : null,
        'notes': _notesController.text.trim(),
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      _showPaymentSuccessDialog();
    } catch (e) {
      _showSnackBar('Terjadi kesalahan: ${e.toString()}', Colors.red);
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 40),
                ),
                SizedBox(height: 20),
                Text(
                  'Pembayaran Berhasil!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Pesanan Anda sedang diproses',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('OK', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildPaymentOption(
    String title,
    String subtitle,
    IconData icon,
    String value,
    Color color,
  ) {
    bool isSelected = selectedPayment == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? color : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? color : Colors.transparent,
              ),
              child:
                  isSelected
                      ? Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color:
                  isDiscount
                      ? Colors.green
                      : (isTotal ? Colors.deepPurple : Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Konfirmasi Pemesanan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Card
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[600],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.namaJasa,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '✓ Tersedia',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Payment Methods
                    Text(
                      'Metode Pembayaran',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),

                    _buildPaymentOption(
                      'QRIS',
                      'Bayar dengan scan QR code',
                      Icons.qr_code,
                      'QRIS',
                      Colors.blue,
                    ),
                    SizedBox(height: 12),
                    _buildPaymentOption(
                      'Transfer Bank',
                      'Transfer ke rekening tujuan',
                      Icons.account_balance,
                      'BANK',
                      Colors.green,
                    ),
                    SizedBox(height: 12),
                    _buildPaymentOption(
                      'E-Wallet',
                      'GoPay, OVO, DANA, ShopeePay',
                      Icons.account_balance_wallet,
                      'EWALLET',
                      Colors.orange,
                    ),

                    SizedBox(height: 24),

                    // Promo Code Section
                    Text(
                      'Kode Promo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          if (!hasPromoCode) ...[
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _promoController,
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan kode promo',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey[300]!,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: _applyPromoCode,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF9110DC),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('Terapkan'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Coba: DISKON10 atau NEWUSER',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ] else ...[
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.green[200]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_offer,
                                    color: Colors.green[700],
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Kode $promoCode diterapkan',
                                      style: TextStyle(
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _removePromoCode,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.green[700],
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Additional Notes
                    Text(
                      'Catatan Tambahan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText:
                              'Tambahkan catatan khusus untuk penyedia jasa...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Summary Section
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF9110DC), Color(0xFF9110DC)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Harga Jasa',
                          'Rp ${originalPrice.toStringAsFixed(0)}',
                        ),
                        if (hasPromoCode)
                          _buildSummaryRow(
                            'Diskon',
                            '- Rp ${discount.toStringAsFixed(0)}',
                            isDiscount: true,
                          ),
                        Divider(color: Colors.white.withOpacity(0.3)),
                        _buildSummaryRow(
                          'Total Pembayaran',
                          'Rp ${finalPrice.toStringAsFixed(0)}',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ScaleTransition(
                    scale: _bounceAnimation,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isProcessing ? null : _processPayment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFC107),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child:
                            isProcessing
                                ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.black,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'Memproses...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.payment, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Bayar Sekarang',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
