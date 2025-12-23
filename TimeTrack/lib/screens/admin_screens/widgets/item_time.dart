import 'package:flutter/material.dart';

import '../../../models/firebase/fb_thoi_gian_lam_viec_model.dart';

class ItemTime extends StatelessWidget {
  final FbThoiGianLamViecModel model;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ItemTime({super.key, required this.model, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.tenCa,
                      style: const TextStyle(
                        fontFamily: 'balooPaaji',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${model.gioBatDau} - ${model.gioKetThuc}',
                      style: const TextStyle(
                        fontFamily: 'balooPaaji',
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
