import 'package:flutter/material.dart';
import 'package:flutter_frontend/components/app_bar.dart';
import 'package:flutter_frontend/components/button.dart';
import 'package:flutter_frontend/pages/product_item.dart';
import 'package:flutter_frontend/services/api_service.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../model/product_model.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel> products = List<ProductModel>.empty(growable: true);
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadProducts(),
      ),
    );
  }

  Widget loadProducts() {
    return FutureBuilder(
      future: APIService.getProducts(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ProductModel>?> model,
      ) {
        if (model.hasData) {
          return productList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productList(products) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    model: products[index],
                    onDelete: () {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIService.deleteProduct(products[index].id).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
              const ButtonWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
