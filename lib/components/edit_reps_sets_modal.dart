import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';

class ModalSheetContent extends StatefulWidget {
  final int initialSetCount;
  final Function(int) onSetCountChanged;
  final int initialRepsCount;
  final Function(int) onRepsCountChanged;

  const ModalSheetContent(
      {super.key,
      required this.initialSetCount,
      required this.onSetCountChanged,
      required this.initialRepsCount,
      required this.onRepsCountChanged});

  @override
  // ignore: library_private_types_in_public_api
  _ModalSheetContentState createState() => _ModalSheetContentState();
}

class _ModalSheetContentState extends State<ModalSheetContent> {
  late int setCount;
  late int repCount;

  @override
  void initState() {
    super.initState();
    setCount = widget.initialSetCount;
    repCount = widget.initialRepsCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              repCount > 0
                  ? BlurryButton(
                      color: Colors.deepPurple,
                      width: 50,
                      height: 50,
                      onPressed: () {
                        setState(() {
                          // Decrease repCount by 1
                          repCount--;
                          widget.onRepsCountChanged(repCount);
                        });
                      },
                      child: const Icon(
                        CupertinoIcons.minus,
                        color: Colors.white,
                      ),
                    )
                  : BlurryButton(
                      color: Colors.grey[900],
                      width: 50,
                      height: 50,
                      onPressed: () {},
                      child: const Icon(
                        CupertinoIcons.minus,
                        color: Colors.white,
                      ),
                    ),
              Text(
                "$repCount reps",
                style: Font(),
              ),
              BlurryButton(
                color: Colors.deepPurple,
                width: 50,
                height: 50,
                onPressed: () {
                  setState(() {
                    // Increase repCount by 1
                    repCount++;
                    widget.onRepsCountChanged(repCount);
                  });
                },
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              setCount > 0
                  ? BlurryButton(
                      color: Colors.deepPurple,
                      width: 50,
                      height: 50,
                      onPressed: () {
                        setState(() {
                          // Decrease setCount by 1
                          setCount--;
                          widget.onSetCountChanged(setCount);
                        });
                      },
                      child: const Icon(
                        CupertinoIcons.minus,
                        color: Colors.white,
                      ),
                    )
                  : BlurryButton(
                      color: Colors.grey[900],
                      width: 50,
                      height: 50,
                      onPressed: () {},
                      child: const Icon(
                        CupertinoIcons.minus,
                        color: Colors.white,
                      ),
                    ),
              Text(
                "$setCount sets",
                style: Font(),
              ),
              BlurryButton(
                color: Colors.deepPurple,
                width: 50,
                height: 50,
                onPressed: () {
                  setState(() {
                    // Increase setCount by 1
                    setCount++;
                    widget.onSetCountChanged(setCount);
                  });
                },
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
