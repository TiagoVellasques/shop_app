import 'dart:convert';
import 'dart:core';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controllers/product_controller.dart';
import 'package:shop_app/controllers/cart_controller.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/views/cart/cart_view.dart';
import 'package:shop_app/views/products/componentes/product_assessment_view.dart';
import 'package:shop_app/views/products/componentes/product_description_widget.dart';
import 'package:shop_app/views/products/componentes/product_list_view.dart';
import 'package:shop_app/views/products/componentes/size_widget.dart';

import '../../helpers/easy_mask.dart';

class ProductDetailView extends StatefulWidget {
  static var routeName = '/product_detail';

  const ProductDetailView(this.product);

  final ProductModel product;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _current = 0;
  bool _isLoading = false;
  bool _showMessageErrorSize = false;

  List<ProductModel> filteredProducts = [];

  ProductController _productController = ProductController();
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      getProducts();
    });
  }

  void getProducts() async {
    var list = await (_productController.getAll());
    print("getProducts");
    print(list);

    filteredProducts.addAll(list);
  }

  @override
  Widget build(BuildContext context) {

    print("sizes ${widget.product.sizes}");

    final primaryColor = Colors.grey.shade700;

    final CarouselController carouselController = CarouselController();
    final TextEditingController _cepContoller = TextEditingController();

    const IconData icon_share = IconData(0xe593, fontFamily: 'MaterialIcons');
    const IconData icon_shopping_cart =
        IconData(0xe59c, fontFamily: 'MaterialIcons');

    return ChangeNotifierProvider.value(
      value: widget.product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButton(
            color: Colors.red,
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(
                icon_share,
                color: Colors.red,
                size: 30.0,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Icon(
                icon_shopping_cart,
                color: Colors.red,
                size: 30.0,
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Consumer<ProductModel>(builder: (_, product, __) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: ListView(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Container(
                    //color: Colors.black,
                    child: CarouselSlider(
                      items: product.images.map((i) {
                        int index = widget.product.images.indexOf(i);
                        return Image.network(
                          widget.product.images[index],
                          fit: BoxFit.fill,
                        );
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   margin: EdgeInsets.symmetric(horizontal: 5.0),
                        //   decoration: BoxDecoration(color: Colors.transparent),
                        //   child: Image.network(widget.product.images[index], height: 400, fit: BoxFit.fill,),
                        // );
                      }).toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        reverse: false,
                        viewportFraction: 0.8,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            onChanged(index);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                DotWidget(widget: widget, current: this._current),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        verticalDirection: VerticalDirection.up,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Ref.:' + '968541',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 13),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber.shade400,
                            size: 18,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber.shade400,
                            size: 18,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber.shade400,
                            size: 18,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '(37)',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 13),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'R\$ 39,99',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 122, 118, 118),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'R\$ 19,99',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Icon(
                            Icons.discount,
                            color: Color.fromARGB(255, 9, 243, 67),
                            size: 12,
                          ),
                          Text(
                            '26%',
                            style: TextStyle(
                              color: Color.fromARGB(255, 9, 243, 67),
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'Até em 4x de R\$ 75,00 sem juros',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 122, 118, 118)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: Text('Tamanho do produto',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 13)),
                      ),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.product.sizes
                            .where((element) => element.hasStock)
                            .map((e) {
                          return SizeWidget(size: e);
                        }).toList(),
                      ),
                      if (this._showMessageErrorSize &&
                          product.selectedSize == null)
                        SizedBox(
                          height: 35.0,
                          child: Wrap(
                            runAlignment: WrapAlignment.start,
                            runSpacing: 12.0,
                            spacing: 5.0,
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceEvenly,
                            verticalDirection: VerticalDirection.up,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                color: Colors.red,
                              ),
                              Text(
                                'selecione o tamanho antes de prosseguir.',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey
                              .shade50, //Color.fromARGB(255, 243, 243, 243),
                          border: Border(
                            bottom: BorderSide(
                              //                   <--- left side
                              color: Colors.grey.shade200,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Calcular frete',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                              TextField(
                                //initialValue: _cepContoller.text.isEmpty ? "Cep" : null,
                                onChanged: (value) {                                  
                                  if (value.length > 7) {
                                    final int _cep =
                                        int.parse(value.replaceAll("-", ""));
                                    onSubmitCep(_cep);
                                  }
                                },
                                //controller: _cepContoller,
                                autofocus: false,
                                keyboardType: TextInputType.number,
                                //controller: _phoneContoller,
                                inputFormatters: [
                                  TextInputMask(mask: '99999-999'),
                                ],
                                decoration: InputDecoration(
                                  //hintText: 'CEP',
                                  suffix: this._isLoading
                                      ? SizedBox(
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            strokeWidth: 3.0,
                                          )),
                                          height: 15.0,
                                          width: 15.0,
                                        )
                                      : null,
                                  labelText: 'CEP',
                                  hintStyle: TextStyle(fontSize: 16),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 32, 212)),
                                  ),
                                  // focusedBorder: UnderlineInputBorder(
                                  //         borderSide: BorderSide(color:Color.fromARGB(255, 0, 32, 212)),
                                  //     ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                //margin: EdgeInsets.symmetric(vertical: 15.0),
                                //width: MediaQuery.of(context).size.width,
                                child: Wrap(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing:
                                      15, // to apply margin in the main axis of the wrap
                                  runSpacing: 10,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Wrap(
                                            spacing:
                                                10, // to apply margin in the main axis of the wrap
                                            runSpacing: 20,
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.start,
                                            children: [
                                              Icon(Icons.local_shipping),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Receba em até 5 dias úteis',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Text(
                                                    'Receba em até 5 dias úteis',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 0,
                                          child: Text(
                                            'Frete Grátis',
                                            style: TextStyle(
                                                color: Colors.green[600],
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              //                   <--- left side
                                              color: Colors.grey.shade200,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Wrap(
                                            spacing:
                                                10, // to apply margin in the main axis of the wrap
                                            runSpacing: 20,
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.start,
                                            children: [
                                              Icon(Icons.local_shipping),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Receba em até 5 dias úteis',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Text(
                                                    'Receba em até 5 dias úteis',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 0,
                                          child: Text(
                                            'Frete Grátis',
                                            style: TextStyle(
                                                color: Colors.green[600],
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      Column(
                        children: [
                          Container(
                            //color: Colors.black,
                            //decoration: BoxDecoration(color: Colors.yellow.shade800),
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            height: 44,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 253, 190, 2)),
                              ),
                              //color: Theme.of(context).primaryColor,
                              //disabledColor: Theme.of(context).primaryColor
                              //.withAlpha(100),
                              //textColor: Colors.white,
                              onPressed: () {
                                //print(product.selectedSize);

                                if (product.selectedSize != null) {
                                  onSubmitAddCart(product);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'selecione o tamanho antes de prosseguir.'),
                                    ),
                                  );

                                  setState(() {
                                    this._showMessageErrorSize = true;
                                  });
                                }

                                //onAddCart(product.selectedSize == null ? false : true);

                                //ProducDescriptionWidget(context, widget.product);
                              },
                              child: const Text(
                                'adicionar ao carrinho',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 2.0),
                            height: 44,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              //color: Theme.of(context).primaryColor,
                              //disabledColor: Theme.of(context).primaryColor
                              //.withAlpha(100),
                              //textColor: Colors.white,
                              onPressed: () {
                                print("sair da conta");
                                // Navigator.of(context)
                                //     .pushReplacementNamed(HomeView().routeName);
                              },
                              child: const Text(
                                'comprar agora',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              //                   <--- left side
                              color: Colors.grey.shade200,
                              width: 1.0,
                            ),
                            top: BorderSide(
                              //                    <--- top side
                              color: Colors.grey.shade200,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            ProducDescriptionWidget(context, widget.product);
                          },
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text('Informações do produto',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 16))),
                                Expanded(
                                  flex: 0,
                                  child: Text('+',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 16)),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          //ProducAssessmetView(widget.product.id.toString());
                          Navigator.of(context).pushNamed(
                              ProducAssessmetView.routeName.toString(),
                              arguments: widget.product.id.toString());
                        },
                        child: Wrap(
                          runSpacing: 8,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 0,
                                    child: Text(
                                        'Avaliações dos clientes ' + '(1733)',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold))),
                                Expanded(
                                  flex: 0,
                                  child: Icon(Icons.arrow_forward_ios_sharp,
                                      color: Colors.grey[700], size: 16),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 40,
                                    alignment: Alignment.bottomLeft,
                                    child: Text('4.4',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30))),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber.shade400,
                                            size: 18,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber.shade400,
                                            size: 18,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber.shade400,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Opiniões dos compradores",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                //                   <--- left side
                                color: Colors.grey.shade200,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Produtos que baixaram de preço',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      _productsOnOffer()
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  onChanged(int index) {
    setState(() {
      this._current = index;
    });
  }

  onSubmitAddCart(ProductModel product) {
    context.read<CartController>().addToCart(product);
    Navigator.of(context).pushNamed(CartView.routeName.toString());
  }

  onSubmitCep(int cep) {
    setState(() {
      print(cep);
      if (cep.toString().length == 8) {
        this._isLoading = true;
      } else {
        this._isLoading = false;
      }
    });
  }

  Widget _productsOnOffer() => StreamBuilder<List<ProductModel>>(
        stream: _productController.streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                controller: _scroll,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //physics: AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisExtent: 250),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ProducListView(product: product),
                  );
                });
          }

          return const Center(child: CircularProgressIndicator());
        },
      );
}

// child: Wrap(
//                             //crossAxisAlignment: CrossAxisAlignment.start,
//                             spacing: 20, // to apply margin in the main axis of the wrap
//                             runSpacing: 20,
//                             children: [
//                               Text(
//                                 product.name,
//                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
//                               ),
//                               Text(
//                                 product.description +
//                                     " - " +
//                                     product.description +
//                                     " - " +
//                                     product.description +
//                                     " - " +
//                                     product.description,
//                               ),
//                             ],
//                           ),

class DotWidget extends StatelessWidget {
  const DotWidget({
    Key? key,
    required this.widget,
    required int current,
  })  : _current = current,
        super(key: key);

  final ProductDetailView widget;
  final int _current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.product.images.map((entry) {
        print("img" + _current.toString());

        int index = widget.product.images.indexOf(entry);

        print("index v" + index.toString());

        return Container(
          width: 12.0,
          height: 12.0,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (_current == index ? Colors.red : Colors.black)
                  .withOpacity(_current == index ? 0.9 : 0.4)),
        );
      }).toList(),
    );
  }
}
