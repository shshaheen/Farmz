import 'dart:io';
import 'package:farmz/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:farmz/controllers/farmer_auth_controller.dart';
import 'package:farmz/providers/farmer.dart';

class UploadProducts extends ConsumerStatefulWidget {
  const UploadProducts({super.key});

  @override
  ConsumerState<UploadProducts> createState() => _UploadProductsState();
}

class _UploadProductsState extends ConsumerState<UploadProducts> {
  final _formKey = GlobalKey<FormState>();
  final ProductController _productController = ProductController();
  bool isLoading = false;
  File? _imageFile;
  final picker = ImagePicker();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _selectedSpeciality;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _submitForm() async {
    final formerId = ref.read(farmerProvider)!.id;
    if (_formKey.currentState!.validate() && _selectedSpeciality != null) {
      // print("Product Name: ${_productNameController.text}");
      // print("Price: ${_productPriceController.text}");
      // print("Location: ${_locationController.text}");
      // print("Speciality: $_selectedSpeciality");
      // print("Image path: ${_imageFile?.path}");
      setState(() {
        isLoading = true;
      });
      await _productController
          .uploadProduct(
        productName: _productNameController.text.trim(),
        productPrice: int.parse(_productPriceController.text),
        location: _locationController.text.trim(),
        speciality: _selectedSpeciality!,
        farmerId: formerId,
        pickedImage: _imageFile,
        context: context,
      )
          .whenComplete(() {
        setState(() {
          isLoading = false;
        });
       _formKey.currentState!.reset();

      });
    } else {
      if (_selectedSpeciality == null) {
        setState(() {}); // Triggers UI update to show error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(_productNameController, "Product Name"),
                  _buildTextField(_productPriceController, "Product Price",
                      TextInputType.number),
                  _buildTextField(_locationController, "Location"),
                  _buildSpecialityRadioGroup(),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImage,
                    child: _imageFile == null
                        ? Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: const Icon(Icons.add_a_photo,
                                size: 50, color: Colors.grey),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_imageFile!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover),
                          ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _submitForm,
                    child: isLoading? const Center(child: CircularProgressIndicator(color: Colors.black,),) :
                    const Text("Submit", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildSpecialityRadioGroup() {
    final List<String> options = [
      "Organic",
      "Local",
      "Pesticide Free",
      "Community",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Speciality",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: -10,
            children:
                options.map((option) => _buildRadioOption(option)).toList(),
          ),
          if (_selectedSpeciality == null)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                "Please select a speciality",
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: _selectedSpeciality,
          onChanged: (String? newValue) {
            setState(() {
              _selectedSpeciality = newValue;
            });
          },
        ),
        Text(value),
      ],
    );
  }
}
