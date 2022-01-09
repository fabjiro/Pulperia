import 'package:flutter/material.dart';
import 'package:pulperia/LoadAnimation.dart';
import 'package:sizer/sizer.dart';

class ScreenLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 1.5.h,
          ),
          LoadAnimation(
            child: WelcomeHeader(),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          LoadAnimation(
            child: SelecCategory(),
          ),
          SizedBox(
            height: 4.h,
          ),
          LoadAnimation(
            child: PopularProductAnimation(),
          ),
          SizedBox(
            height: 2.h,
          ),
          ProductRecomended()
        ],
      ),
    );
  }
}

class ProductRecomended extends StatelessWidget {
  const ProductRecomended({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LoadAnimation(
        child: Container(
          width: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: ContainerF(
                  largo: 30.w,
                  ancho: 3.h,
                  redondo: 5,
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.separated(
                    itemCount: 7,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 15),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        width: 100.w,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                ContainerF(
                                  largo: 25.w,
                                  ancho: 12.h,
                                  redondo: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ContainerF(
                                      largo: 30.w,
                                      ancho: 2.h,
                                      redondo: 5,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ContainerF(
                                      largo: 40.w,
                                      ancho: 2.h,
                                      redondo: 5,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ContainerF(
                                      largo: 20.w,
                                      ancho: 2.h,
                                      redondo: 5,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: ContainerF(
                                largo: 15.w,
                                ancho: 3.h,
                                redondo: 5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularProductAnimation extends StatelessWidget {
  const PopularProductAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 25.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: ContainerF(
              largo: 30.w,
              ancho: 3.h,
              redondo: 5,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Expanded(
            child: Container(
              width: 100.w,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: ContainerF(
                      largo: 20.h,
                      ancho: 20.h,
                      redondo: 20,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SelecCategory extends StatelessWidget {
  const SelecCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 5.5.h,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 5,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              child: ContainerF(
                largo: 23.w,
                ancho: 6.h,
                redondo: 20,
              ),
            );
          } else {
            return Container(
              width: 23.w,
              margin: EdgeInsets.only(
                left: 5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      height: 10.h,
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerF(
                largo: 30.w,
                ancho: 2.h,
                redondo: 2,
              ),
              SizedBox(
                height: 1.h,
              ),
              ContainerF(
                largo: 20.w,
                ancho: 2.h,
                redondo: 2,
              ),
            ],
          ),
          Row(
            children: [
              ContainerF(
                largo: 6.h,
                ancho: 6.h,
                redondo: 50,
              ),
              SizedBox(
                width: 2.w,
              ),
              ContainerF(
                largo: 6.h,
                ancho: 6.h,
                redondo: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ContainerF extends StatelessWidget {
  const ContainerF({
    Key? key,
    required this.largo,
    required this.ancho,
    this.redondo = 0.0,
  }) : super(key: key);

  final double largo, ancho;
  final double redondo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: largo,
      height: ancho,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(redondo),
        color: Colors.grey,
      ),
    );
  }
}
