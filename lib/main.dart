import 'package:flutter/material.dart';

void main(){
  runApp(const DragLatestState());
}

class DragLatestState extends StatefulWidget {
  const DragLatestState({super.key});

  @override
  State<DragLatestState> createState() => __DragLatesStateState();
}

class __DragLatesStateState extends State<DragLatestState> {
  final List<IconData> _icons =[
  Icons.person,
  Icons.message,
  Icons.call,
  Icons.camera,
  Icons.photo,
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_icons.length,
              (index) {
                return Draggable<int>(data: index, 
                feedback: _draggableFeedback(_icons[index]),
                childWhenDragging: const SizedBox.shrink(),
                child: DragTarget<int>(
                  onAcceptWithDetails: (draggedIndex){
                    setState(() {
                      final temp = _icons[index];
                      _icons[index] = _icons[draggedIndex.data];
                      _icons[draggedIndex.data] = temp;
                    });
                  },
                  builder: (context, inDAta, outData){
                    return _buildIconContainer(_icons[index]);
                  },
                ),
                );
              },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _draggableFeedback(IconData icon){
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // ignore: deprecated_member_use
          color: Colors.primaries[icon.hashCode % Colors.primaries.length].withOpacity(0.5),
        ),
        child: Center(child: Icon(icon, color: Colors.white),),
      ),
    );
  }

  Widget _buildIconContainer(IconData icon){
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.primaries[icon.hashCode % Colors.primaries.length],
      ),
      child: Center(child: Icon(icon, color: Colors.white,),),
    );
  }
}

class Dragg<T> extends StatefulWidget{
  const Dragg({
    super.key,
    this.items = const [],
    required this.builder,

  });
  final List<T> items;
  final Widget Function(T) builder;

  @override
  State<Dragg<T>> createState() => _draggState<T>();

}
class _draggState<T> extends State<Dragg<T>>
{
  late final List<T> _dockItems = List.from(widget.items);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _dockItems.map(widget.builder).toList(),
      ),
    );
  }
}


