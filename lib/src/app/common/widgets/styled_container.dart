import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyledContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final bool clickable;

  final void Function()? onTap;

  const StyledContainer({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.width,
    this.height,
    this.clickable = false,
    this.onTap,
  });

  @override
  State<StyledContainer> createState() => _StyledContainerState();
}

class _StyledContainerState extends State<StyledContainer> {
  bool isElevated = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => widget.clickable
          ? {
              setState(() {
                isElevated = !isElevated;
              }),
              widget.onTap
            }
          : null,
      onTapUp: (details) => widget.clickable
          ? setState(() {
              isElevated = !isElevated;
            })
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.bounceInOut,
        width: widget.width ?? 130.w,
        height: widget.height ?? 50.h,
        padding: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 4.w,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.black,
            width: 1.6,
          ),
          boxShadow: [
            isElevated
                ? BoxShadow(
                    color: Colors.black,
                    blurRadius: 0,
                    spreadRadius: 1.8.r,
                    offset: Offset(1.8.w, 1.8.h),
                  )
                : const BoxShadow(),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
