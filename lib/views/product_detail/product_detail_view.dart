import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products/product_model.dart';
import 'package:shop_app/views/products/componentes/product_assessment_view.dart';
import 'package:shop_app/views/products/componentes/product_description_widget.dart';
import 'package:shop_app/views/products/componentes/size_widget.dart';

class ProductDetailView extends StatefulWidget {
  static var routeName = '/product_detail';

  const ProductDetailView(this.product);

  final ProductModel product;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    super.initState();
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.grey.shade700;

    final CarouselController carouselController = CarouselController();

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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: ListView(
            children: [
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Container(
                  //color: Colors.black,
                  child: CarouselSlider(
                    items: widget.product.images.map((i) {
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
                          onchahged(index);
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
                      widget.product.name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 13),
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
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text('Tamanho do produto',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 13)),
                    ),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.product.sizes.map((e) {
                        return SizeWidget(size: e);
                      }).toList(),
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
                              ProducDescriptionWidget(context, widget.product);
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
                                        color: Colors.grey[700], fontSize: 16)),
                              ),
                            ]),
                      ),
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
                                  flex: 0,
                                  child: Text('Informações do produto',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 16))),
                              Expanded(
                                flex: 0,
                                child: Text('+',
                                    style: TextStyle(
                                        color: Colors.grey[700], fontSize: 16)),
                              ),
                            ]),
                      ),
                    ), //
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        //ProducAssessmetView(widget.product.id.toString());
                        Navigator.of(context)
                        .pushNamed(ProducAssessmetView.routeName.toString(), arguments: widget.product.id.toString()); 
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
                    ),
                    Text(
                      widget.product.description,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 122, 118, 118),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> product_description(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.89,
          padding:
              const EdgeInsets.only(top: 5, right: 14, left: 14, bottom: 0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: InkWell(
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Scrollbar(
                  //thickness: 8, //width of scrollbar
                  radius: Radius.circular(5), //corner radius of scrollbar
                  scrollbarOrientation: ScrollbarOrientation.right,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Similar This',
                              ),
                              Text(
                                widget.product.description +
                                    " - " +
                                    widget.product.description +
                                    " - " +
                                    widget.product.description +
                                    " - " +
                                    widget.product.description,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        // SizedBox(
                        //   height: 110,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: smProducts.length,
                        //     itemBuilder: (context, index) => Container(
                        //       margin: const EdgeInsets.only(right: 6),
                        //       width: 110,
                        //       height: 110,
                        //       decoration: BoxDecoration(
                        //         color: AppColors.kSmProductBgColor,
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       child: Center(
                        //         child: Image(
                        //           height: 70,
                        //           image: AssetImage(smProducts[index].image),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  onchahged(int index) {
    setState(() {
      this._current = index;
    });
  }
}

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
