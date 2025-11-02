import 'package:app_assesment/features/product/presentation/bloc/product_event.dart';
import 'package:app_assesment/features/product/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController scrollController = ScrollController();

  Future<void> _onRefresh() async {
    context.read<ProductsBloc>().add(ProductsRefreshed());
  }

  void _onScroll() {
    if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        scrollController.position.atEdge) {
      context.read<ProductsBloc>().add(ProductsNextPage());
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(ProductInitial());
    scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: Text('Products', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is RedirectToLogin) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          } else if (state is ProductsError) {
            return Center(child: Text(state.message));
          } else if (state is ProductsLoaded) {
            return loadedData(state);
          } else if (state is ProductsEmpty) {
            return const Center(child: Text('No data'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget loadedData(ProductsLoaded state) {
    return Column(
      children: [
        if (!state.isOnline)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              color: Colors.amber,
              width: double.infinity,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(8),
              child: const Text('Offline Mode'),
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: Stack(
              children: [
                GridView.builder(
                  padding: EdgeInsets.all(10.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 160.w / 200.h,
                  ),
                  controller: scrollController,
                  itemCount: state.products.length,

                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductItem(product: product);
                  },
                ),
                state.isLoadingMore
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
