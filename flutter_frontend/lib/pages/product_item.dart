import 'package:flutter/material.dart';
import 'package:flutter_frontend/theme/app_colors.dart';

import '../model/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, this.model, this.onDelete}) : super(key: key);

  final ProductModel? model;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(5),
        ),
        child: productWidget(context),
      ),
    );
  }

  Widget productWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: Image.network(
            (model!.productImage == null || model!.productImage == "")
                ? 'https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png'
                : model!.productImage!,
            height: 90,
            fit: BoxFit.scaleDown,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.productName!,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "₹${model!.productPrice}",
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.black,
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('/edit-product',
                            arguments: {'model': model});
                      },
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 201, 56, 46),
                      ),
                      onTap: () {
                        onDelete!();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
