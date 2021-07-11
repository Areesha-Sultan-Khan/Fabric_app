import 'package:fabric_app/src/index_page.dart';
import 'package:fabric_app/src/login_page.dart';
import 'package:fabric_app/src/order_display_page.dart';
import 'package:fabric_app/src/order_page.dart';
import 'package:fabric_app/src/product_page.dart';
import 'package:fabric_app/src/services/auth_service.dart';
import 'package:fabric_app/src/widgets/loading_dialog.dart';
import 'package:fabric_app/utils/picture_resolver.dart';
import 'package:flutter/material.dart';
import 'package:fabric_app/src/navigator.dart';
import 'package:fabric_app/src/sale_page.dart';
import 'package:fabric_app/src/summer_page.dart';
import 'package:fabric_app/src/winter_page.dart';
import 'package:fabric_app/src/arrival_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fabric_app/models/product_model.dart';
import 'package:fabric_app/models/sliders_model.dart';
import 'package:fabric_app/src/widgets/cart_button.dart';
import 'package:fabric_app/src/widgets/lazy_builder.dart';
import 'package:fabric_app/models/product_service.dart';
import 'package:fabric_app/src/luxury_collection_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pos = 0;
  var _showSearch = false;

  final _service = ProductService();

  LazyBuilderController<List<SliderModel>> news;
  LazyBuilderController<List<Product>> bestInBedding;
  LazyBuilderController<List<Product>> hotProducts;

  Future<List<SliderModel>> slider;
  Future<List<Product>> product;

  void initState() {
    super.initState();

    news = LazyBuilderController(() => _service.sliders());
    bestInBedding = LazyBuilderController(
      () => _service.getProductsByCategory(11),
    );
    hotProducts = LazyBuilderController(() {
      return _service.getProductsByCategory(12);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('images/logo.png', height: 110, width: 110),
        actions: [
          /**IconButton(
            icon: Icon(
              _showSearch ? Icons.clear : Icons.search,
              color: Colors.black,
            ),
            onPressed: () => setState(() => _showSearch = !_showSearch),
          ), **/
          CartButton(),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(children: [
            _DrawerTile(
              title: 'New Arrivals',
              onTap: () => navigateTo(context, ArrivalPage()),
            ),
            _DrawerTile(
              title: 'Winter Collection',
              onTap: () => navigateTo(context, WinterPage()),
            ),
            _DrawerTile(
              title: 'Summer Collection',
              onTap: () => navigateTo(context, SummerPage()),
            ),
            _DrawerTile(
              title: 'Luxury Collection',
              onTap: () => navigateTo(context, LuxuryCollection()),
            ),
            _DrawerTile(
              title: 'Sales',
              onTap: () => navigateTo(context, SalePage()),
            ),
            _DrawerTile(
              title: 'Orders',
              onTap: () => navigateTo(context, OrderDisplay()),
            ),
            if (AuthService.isSignedIn)
              _DrawerTile(
                title: 'Sign Out',
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => LoadingDialog(),
                  );
                  await AuthService.signOut();
                  setState(() {});
                  navigateTo(context, IndexPage());
                },
              )
            else
              _DrawerTile(
                title: 'Sign in',
                onTap: () async {
                  await navigateTo(context, LoginPage());
                  setState(() {});
                },
              ),
          ]),
        ),
      ),
      drawerEnableOpenDragGesture: false,
      body:
          ListView(padding: const EdgeInsets.fromLTRB(0, 0, 0, 20), children: [
        /*if (_showSearch)
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ), */
        LazyBuilder<List<SliderModel>>(
          controller: news,
          builder: (data) {
            return CarouselView<SliderModel>(
              onTap: (_) {
                navigateTo(context, SalePage());
              },
              data: data,
              parse: (_) => _.image_url,
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Best In Bedding',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        LazyBuilder<List<Product>>(
          controller: bestInBedding,
          builder: (data) {
            return CarouselView<Product>(
              data: data,
              parse: (_) => _.photo,
              onTap: (_) {
                navigateTo(context, ProductPage(_));
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Hot Products',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        LazyBuilder<List<Product>>(
          controller: hotProducts,
          builder: (data) {
            return SizedBox(
              height: 250,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final product = data[index];
                  return Card(
                    child: GestureDetector(
                      onTap: () => navigateTo(context, ProductPage(product)),
                      child: Column(
                        children: [
                          Image.network(
                            resolveImageUrl(product.photo),
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text('Rs.' + product.price.toString()),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              ),
            );
          },
        ),
      ]),
    );
  }
}

class CarouselView<T> extends StatefulWidget {
  final List<T> data;
  final String Function(T) parse;
  final Function(T) onTap;

  const CarouselView({Key key, this.data, this.parse, this.onTap})
      : super(key: key);

  @override
  _CarouselViewState<T> createState() => _CarouselViewState<T>();
}

class _CarouselViewState<T> extends State<CarouselView<T>> {
  var _position = 0;
  final _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider.builder(
        carouselController: _controller,
        itemCount: widget.data.length,
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          pageSnapping: true,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            _position = index;
            setState(() {});
          },
        ),
        itemBuilder: (context, index, i) {
          return GestureDetector(
            onTap: () => widget.onTap(widget.data[index]),
            child: Container(
              margin: const EdgeInsets.all(8),
              constraints: BoxConstraints.expand(),
              child: Image.network(
                resolveImageUrl(widget.parse(widget.data[index])),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.data.map((url) {
          int index = widget.data.indexOf(url);
          return GestureDetector(
            onTap: () {
              _controller.animateToPage(
                index,
                curve: Curves.ease,
                duration: Duration(milliseconds: 500),
              );
            },
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _position == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

class _DrawerTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerTile({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
