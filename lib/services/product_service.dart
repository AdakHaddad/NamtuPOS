import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final CollectionReference _productsCollection = FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(Product product) async {
    await _productsCollection.add(product.toMap());
  }

  Stream<List<Product>> getProducts() {
    return _productsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  Future<void> updateProduct(String id, Product product) async {
    await _productsCollection.doc(id).update(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _productsCollection.doc(id).delete();
  }
}