import 'package:app_assesment/features/product/data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: product.thumbnail,
        width: 30.w,
        height: 35.h,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Container(width: 30.w, height: 35.h, color: Colors.grey),
        errorWidget: (context, url, error) =>
            Container(width: 30.w, height: 35.h, color: Colors.grey),
      ),

      title: Expanded(
        child: Column(
          children: [
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
      ),
      subtitle: Text(
        '\$${product.price}',
        style: TextStyle(fontSize: 13.sp, color: Colors.green),
      ),
    );
  }
}
