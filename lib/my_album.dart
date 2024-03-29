import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

import 'model/product.dart';

class MyAlbum extends StatelessWidget {
  const MyAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách sản phẩm"),
      ),
      body: FutureBuilder<List<Product>>(
        future: Product.fetchData(),
        builder: (BuildContext, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            // Show danh sách
            var data = snapshot.data;
            return MyProduct(lstProduct: data!);
            // NUll safe dart 3.0
          } else {
            // Xoay vòng
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MyProduct extends StatelessWidget {
  MyProduct({super.key, required this.lstProduct});

  List<Product> lstProduct;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2 // 2 cột mỗi dòng
        ),
        itemCount: lstProduct?.length,
        // itemCount: 2,
        itemBuilder: (context, index) {
          var product = lstProduct[index];
          // return Column(
          //   children: [
          //     Expanded(child: Image.network(product.image)),
          //     Text(product.title),
          //
          //   ],
          // );
          return CachedNetworkImage(
              imageUrl: product?.image??"",
              imageBuilder: (context, imageProvider) {
                return Column(
                      children: [
                        Expanded(child: Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          height: 60,
                        )),
                        Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                        ),

                      ],
                    );
              },
              placeholder: (context, url) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
          );
          // return CachedNetworkImage(
          //   imageUrl: product?.image??"",
          //   imageBuilder: (context, imageProvider) {
          //     return Container(
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: imageProvider,
          //             fit: BoxFit.cover,
          //           )
          //       ),
          //       //child: Text(product.title),
          //     );
          //   },
          //   placeholder: (context, url) {
          //     return Container(
          //       child: Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //     );
          //   }
          // );
        },
    );
  }
}


// class MyAlbum extends StatelessWidget {
//   const MyAlbum({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Danh sách hình ảnh"),
//       ),
//       body: FutureBuilder<List<Photo>>(
//         future: Photo.fetchData(),
//         builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot){
//           if(snapshot.hasData){
//             var data = snapshot.data;
//             return My_Photo(lsPhoto: data!);
//           }
//           else{
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
//
// class My_Photo extends StatelessWidget {
//   My_Photo({super.key, required this.lsPhoto});
//
//   List<Photo> lsPhoto;
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2
//         ),
//         //itemCount: lsPhoto.length,// chay het tat ca cac hinh
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           var photo = lsPhoto[index];
//           return Column(
//             children: [
//               Text(photo.title),
//               Expanded(child: Image.network(photo.thumbnailUrl)),
//             ],
//           );
//         }
//     );
//   }
// }