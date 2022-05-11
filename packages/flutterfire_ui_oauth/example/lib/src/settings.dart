import 'package:flutter/material.dart';

enum DesignLibrary {
  cupertino,
  material,
}

class SettingsChip extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool isActive;

  const SettingsChip({
    Key? key,
    required this.onTap,
    required this.label,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => onTap(),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: TextStyle(color: isActive ? Colors.white : Colors.black),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isActive ? Colors.blue : Colors.grey[200],
          ),
        ),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  final DesignLibrary library;
  final Brightness brightness;

  final Widget Function(
    BuildContext context,
    DesignLibrary library,
    Brightness brightness,
  ) builder;

  const Settings({
    Key? key,
    required this.builder,
    this.brightness = Brightness.light,
    this.library = DesignLibrary.material,
  }) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late DesignLibrary library = widget.library;
  late Brightness brightness = widget.brightness;

  VoidCallback setValue(Object value) {
    return () {
      setState(() {
        if (value is DesignLibrary) {
          library = value;
        } else if (value is Brightness) {
          brightness = value;
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SettingsChip(
                    onTap: setValue(DesignLibrary.material),
                    label: 'Material',
                    isActive: library == DesignLibrary.material,
                  ),
                  SettingsChip(
                    onTap: setValue(DesignLibrary.cupertino),
                    label: 'Cupertino',
                    isActive: library == DesignLibrary.cupertino,
                  ),
                  SettingsChip(
                    onTap: setValue(Brightness.light),
                    label: 'Light mode',
                    isActive: brightness == Brightness.light,
                  ),
                  SettingsChip(
                    onTap: setValue(Brightness.dark),
                    label: 'Dark mode',
                    isActive: brightness == Brightness.dark,
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: widget.builder(context, library, brightness)),
        ],
      ),
    );
  }
}
