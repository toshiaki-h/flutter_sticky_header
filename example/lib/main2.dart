import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sticky Header example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  var topKey = ValueKey('top');

  @override
  Widget build(BuildContext context) {
    return new SimpleScaffold(
      title: 'Flutter Sticky Header example',
      child: new Builder(builder: (BuildContext context) {
        return new CustomScrollView(
          center: topKey,
          slivers: _buildSlivers(context),
        );
      }),
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = <Widget>[];

    slivers.addAll(List.generate(9, (index) {
      return SliverStickyHeaderBuilder(
        reverse: true,
        builder: (context, state) {
          return Container(
            child: Text("Header $index"),
            color: Colors.red,
          );
        },
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                title: Text("Child $index"),
              );
            },
            childCount: 10,
          ),
        ),
      );
    }));

    slivers.add(SliverStickyHeaderBuilder(
      key: topKey,
      builder: (context, state) {
        return Container(
          child: Text("Header 9"),
          color: Colors.blue,
        );
      },
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            title: Text("Child $index"),
          );
        }, childCount: 10),
      ),
    ));

    slivers.addAll(List.generate(10, (index) {
      return SliverStickyHeaderBuilder(
        builder: (context, state) {
          return Container(
            child: Text("Header ${index + 10}"),
            color: Colors.red,
          );
        },
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return ListTile(
              title: Text("Child $index"),
            );
          }, childCount: 10),
        ),
      );
    }));

    return slivers;
  }
}

class SimpleScaffold extends StatelessWidget {
  const SimpleScaffold({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: child,
    );
  }
}
