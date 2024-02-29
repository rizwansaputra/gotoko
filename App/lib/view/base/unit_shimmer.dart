import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UnitShimmer extends StatelessWidget {
  const UnitShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 100.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                    ],
                  ),),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0)),

                const Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.edit,color: Colors.white),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0)),
                    Icon(Icons.delete_forever_rounded,color: Colors.white),

                  ],
                )
              ],
            ),
          ),
          itemCount: 12,
        ));
  }
}
