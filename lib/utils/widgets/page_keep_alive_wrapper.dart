import 'package:flutter/material.dart';

class PageKeepAliveWrapper extends StatefulWidget {
  const PageKeepAliveWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<PageKeepAliveWrapper> createState() => _PageKeepAliveWrapperState();
}

class _PageKeepAliveWrapperState extends State<PageKeepAliveWrapper>
    with AutomaticKeepAliveClientMixin<PageKeepAliveWrapper> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
