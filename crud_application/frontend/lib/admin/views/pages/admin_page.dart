import 'package:example_10_09/admin/views/pages/upload_product_page.dart';
import 'package:example_10_09/core/utils/components/default_button.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DefaultButton(
              textButton: 'Cadastrar Produto', 
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UploadProductScreen())),
            ),
          )
        ],
      ),
    );
  }
}