import 'package:flutter/material.dart';

import '../io/app_style.dart';

class NeoButton extends StatefulWidget {
  NeoButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.width,
      this.height,
      this.radius,
      this.borderRadius,
      this.backgroundColor,
      this.lightShadowColor,
      this.darkShadowColor,
      this.shadowBlurRadius});

  final VoidCallback onPressed;
  final Widget child;
  double? width;
  double? height = 40;
  double? radius;
  double? borderRadius;
  Color? backgroundColor;
  Color? lightShadowColor;
  Color? darkShadowColor;
  double? shadowBlurRadius;

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool hover = false;
  bool press = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => setState(() => hover = true),
      onExit: (e) => setState(() => hover = false),
      child: GestureDetector(
        onTap: () {
          widget.onPressed();
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) {
              setState(() => press = true);
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  setState(() => press = false);
                }
              });
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.radius ?? widget.width,
          height: widget.radius ?? widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppStyle.neoBackgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            border: press
                ? Border.all(color: AppStyle.neoBorderColor, width: 3)
                : null,
            boxShadow: hover
                ? []
                : [
                    BoxShadow(
                      color: widget.lightShadowColor ??
                          AppStyle.neoLightShadowColor,
                      blurRadius: widget.shadowBlurRadius ?? 20,
                      offset: const Offset(-9, -9),
                    ),
                    BoxShadow(
                      color:
                          widget.darkShadowColor ?? AppStyle.neoDarkShadowColor,
                      blurRadius: widget.shadowBlurRadius ?? 20,
                      offset: const Offset(9, 9),
                    ),
                  ],
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
