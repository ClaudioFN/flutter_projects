import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  //bool _isLoading = true;
//
  //@override
  //void initState() {
  //  super.initState();
  //  Provider.of<OrderList>(context, listen: false).loadOrders().then((value) {
  //    setState(() => _isLoading = false);
  //  });
  //}

  @override
  Widget build(BuildContext context) {
    //final OrderList orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderList>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Erro ao listar pedido: ${snapshot.error}'),
            );
          } else {
            return Consumer<OrderList>(
              builder:(context, value, child) => ListView.builder(
                itemCount: value.itemsCount,
                itemBuilder: (ctx, i) => OrderWidget(
                  order: value.items[i],
                ),
              ),
            );
          }
        },
      ),
      //body: _isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
      //  itemCount: orders.itemsCount,
      //  itemBuilder: (ctx, i) => OrderWidget(
      //    order: orders.items[i],
      //  ),
      //),
    );
  }
}
