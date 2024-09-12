import 'package:example_10_09/admin/controllers/upload_product_controller.dart';
import 'package:example_10_09/core/utils/components/default_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  UploadProductScreenState createState() => UploadProductScreenState();
}

class UploadProductScreenState extends State<UploadProductScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UploadProductController(),
      child: Consumer<UploadProductController>(
        builder: (context, controller, __) {
          return Scaffold(
            appBar: AppBar(title: const Text('Cadastrar produto')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.nameController,
                          decoration: const InputDecoration(labelText: 'Nome do Produto'),
                        ),
                        TextField(
                          controller: controller.descriptionController,
                          decoration: const InputDecoration(labelText: 'Descrição'),
                        ),
                        TextField(
                          controller: controller.priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Preço'),
                        ),
                        TextField(
                          controller: controller.categoryController,
                          decoration: const InputDecoration(labelText: 'Cetegoria'),
                        ),
                        TextField(
                          controller: controller.stockController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Quantidade de Estoque'),
                        ),
                        const SizedBox(height: 20),
                        controller.image != null ? Image.file(controller.image!) : const Text('Nenhuma imagem selecionada'),
                        ElevatedButton(onPressed: controller.pickImage, child: const Text('Escolher imagem')),
                        if(controller.image != null) ...{
                          ElevatedButton(
                            onPressed: () => controller.uploadProduct((bool isSucess, String msg) {
                              DefaultSnackBar.snackBarOf(text: msg, isSucess: isSucess, context: context);
                            }), 
                            child: controller.image != null ?  const Text('Enviar produto') : const SizedBox(),
                          ),
                        }
                      ],
                    ),
                  ),
                  if (controller.loading) ...{
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      color: Colors.white.withOpacity(.7),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  }
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
