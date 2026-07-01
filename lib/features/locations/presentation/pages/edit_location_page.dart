import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_text_field.dart';
import '../../../../core/common/widgets/mock_map.dart';
import '../../../../core/constant/app_color.dart';
import '../../domain/entities/location.dart';
import '../bloc/locations_bloc.dart';
class EditLocationPage extends StatefulWidget {
  final Location location;
  const EditLocationPage({
    super.key,
    required this.location,
  });
  @override
  State<EditLocationPage> createState() => _EditLocationPageState();
}
class _EditLocationPageState extends State<EditLocationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _latController;
  late TextEditingController _lngController;
  late double _radius;
  late bool _isActive;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.location.locationName);
    _latController = TextEditingController(text: widget.location.latitude.toString());
    _lngController = TextEditingController(text: widget.location.longitude.toString());
    _radius = widget.location.radiusM;
    _isActive = widget.location.isActive;
  }
  @override
  void dispose() {
    _nameController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColor.primaryDark : AppColor.primaryLight;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => context.pop(),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColor.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? AppColor.borderDark : AppColor.borderLight,
                ),
              ),
              child: Icon(
                Icons.chevron_left,
                color: isDark ? Colors.white : AppColor.textPrimaryLight,
              ),
            ),
          ),
        ),
        title: const Text('Edit location'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Map Widget
                MockMap(radius: _radius),
                const SizedBox(height: 24),
                // Name field
                CustomTextField(
                  controller: _nameController,
                  labelText: 'Location name',
                  hintText: 'e.g. Downtown Branch',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Location name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Lat / Lng row
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _latController,
                        labelText: 'Latitude',
                        hintText: 'e.g. 25.2048',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomTextField(
                        controller: _lngController,
                        labelText: 'Longitude',
                        hintText: 'e.g. 55.2708',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Geofence slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Geofence radius',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_radius.toInt()} m',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: _radius,
                  min: 50,
                  max: 500,
                  divisions: 45,
                  onChanged: (val) {
                    setState(() {
                      _radius = val;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Active Switch Card
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Active',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Workers can check in here',
                          style: TextStyle(
                            color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: _isActive,
                      onChanged: (val) {
                        setState(() {
                          _isActive = val;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                // Update button
                CustomButton(
                  text: 'Update location',
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   final updatedLoc = widget.location.copyWith(
                    //     name: _nameController.text.trim(),
                    //     latitude: double.parse(_latController.text.trim()),
                    //     longitude: double.parse(_lngController.text.trim()),
                    //     radius: _radius,
                    //     isActive: _isActive,
                    //   );
                    //   context.read<LocationsBloc>().add(UpdateLocation(updatedLoc));
                    //   context.pop();
                    // }
                  },
                ),
                const SizedBox(height: 16),
                // Delete button
                CustomButton(
                  text: 'Delete location',
                  style: CustomButtonStyle.danger,
                  icon: Icons.delete_outline,
                  onPressed: () {
                    context.read<LocationsBloc>().add(DeleteLocation(widget.location.id));
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
