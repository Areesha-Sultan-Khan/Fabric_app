import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LazyBuilderController<T> extends ChangeNotifier {
  final Future<T> Function() fetcher;
  LazyBuilderController(this.fetcher);

  T _value;
  var _error;
  var _loading = false;

  Future<void> reload() async {
    _loading = true;
    notifyListeners();

    try {
      _value = await fetcher();
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

}

class LazyBuilder<T> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(T) builder;
  final LazyBuilderController controller;

  const LazyBuilder({
    Key key,
    this.future,
    this.builder,
    this.controller,
  }) : super(key: key);

  @override
  _LazyBuilderState<T> createState() => _LazyBuilderState<T>();
}

class _LazyBuilderState<T> extends State<LazyBuilder<T>> {
  void _rebuild() => setState(() {});

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_rebuild);
    widget.controller.reload();
  }

  @override
  void didUpdateWidget(covariant LazyBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_rebuild);
      widget.controller.addListener(_rebuild);
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_rebuild);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller._loading) {
      return Center(child: CupertinoActivityIndicator());
    } else if (widget.controller._error != null) {
      return Center(child: Text(widget.controller._error.toString()));
    } else {
      return widget.builder(widget.controller._value);
    }
  }
}
