import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/components/app_bar.dart';
import 'package:flutter_frontend/config.dart';
import 'package:flutter_frontend/services/api_service.dart';
import 'package:flutter_frontend/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../model/product_model.dart';

class ProductAddEdit extends StatefulWidget {
  const ProductAddEdit({Key? key}) : super(key: key);

  @override
  State<ProductAddEdit> createState() => _ProductAddEditState();
}

class _ProductAddEditState extends State<ProductAddEdit> {
  ProductModel? productModel;
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarComponent(context),
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalKey,
            child: productForm(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    productModel = ProductModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

        productModel = arguments["model"];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget productForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "ProductName",
              "Nome do filme",
              prefixIcon: const Icon(Icons.person),
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'ProductName can\'t be empty.';
                }
                return null;
              },
              (onSavedVal) => {
                productModel!.productName = onSavedVal,
              },
              initialValue: productModel!.productName ?? "",
              contentPadding: 17,
              obscureText: false,
              borderWidth: 0,
              borderColor: Colors.transparent,
              borderFocusColor: AppColors.primaryColor,
              textColor: AppColors.textInput,
              backgroundColor: AppColors.card,
              hintColor: AppColors.textInput.withOpacity(0.8),
              borderRadius: 10,
              paddingTop: 20,
              showPrefixIcon: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "ProductPrice",
              "Valor",
              prefixIcon: const Icon(Icons.ac_unit),
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Product Price can t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                productModel!.productPrice = int.parse(onSavedVal),
              },
              initialValue: productModel!.productPrice == null
                  ? ""
                  : productModel!.productPrice.toString(),
              contentPadding: 17,
              obscureText: false,
              // borderWidth: 0,
              borderColor: Colors.transparent,
              borderFocusColor: AppColors.primaryColor,
              textColor: AppColors.textInput,
              backgroundColor: AppColors.card,
              hintColor: AppColors.textInput.withOpacity(0.8),

              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.monetization_on),
            ),
          ),
          picPicker(isImageSelected, productModel!.productImage ?? "", (file) {
            productModel!.productImage = file.path;
            isImageSelected = true;
          }),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "SAVE",
              () {
                if (validateAndSave()) {
                  //API Service
                  setState(() {
                    isApiCallProcess = true;
                  });

                  APIService.saveProduct(
                          productModel!, isEditMode, isImageSelected)
                      .then((response) {
                    setState(() {
                      isApiCallProcess = false;
                    });

                    if (response) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Error Occure",
                        "Ok",
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  });
                }
              },
              btnColor: AppColors.primaryColor,
              borderColor: AppColors.white,
              borderRadius: 10,
              width: 200,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  static Widget picPicker(
    bool isFileSelected,
    String fileName,
    Function onFilePicked,
  ) {
    Future<XFile?> imageFile;
    ImagePicker picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isFileSelected
                ? Image.file(
                    File(fileName),
                    height: 200,
                    width: 200,
                  )
                : SizedBox(
                    child: Image.network(
                      fileName,
                      width: 200,
                      height: 200,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/0/0a/No-image-available.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.scaleDown,
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.image,
                  size: 35,
                ),
                onPressed: () {
                  imageFile = picker.pickImage(source: ImageSource.gallery);
                  imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.camera,
                  size: 35,
                ),
                onPressed: () {
                  imageFile = picker.pickImage(source: ImageSource.camera);
                  imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
