import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swapnojatri/core/theme/app_colors.dart';
import 'package:swapnojatri/data/models/project_model.dart';
import 'package:swapnojatri/data/state/app_state.dart';

class AddProjectScreen extends StatefulWidget {
  final AppState state;

  const AddProjectScreen({
    super.key,
    required this.state,
  });

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _totalSharesController = TextEditingController();
  final TextEditingController _sharePriceController = TextEditingController();
  final TextEditingController _minSharesController = TextEditingController(text: '1');
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _durationController = TextEditingController(text: '24 - 36 মাস');

  String _selectedCategory = 'Land Investment';
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    _totalSharesController.dispose();
    _sharePriceController.dispose();
    _minSharesController.dispose();
    _locationController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _handleCreate() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('অনুগ্রহ করে প্রজেক্টের নাম লিখুন')),
      );
      return;
    }

    setState(() => _isCreating = true);
    await Future.delayed(const Duration(milliseconds: 600));

    final shares = int.tryParse(_totalSharesController.text) ?? 100;
    final price = double.tryParse(_sharePriceController.text) ?? 25000.0;

    final newProject = ProjectModel(
      id: 'prj-${DateTime.now().millisecondsSinceEpoch}',
      code: 'LV${(widget.state.projects.length + 100)}',
      name: _nameController.text,
      nameBn: _nameController.text,
      description: 'New high-yield smart land investment opportunity under Swapnojatri Platform.',
      descriptionBn: 'স্বপ্নযাত্রী প্ল্যাটফর্মের অধীনে নতুন সম্ভাবনাময় বিনিয়োগ প্রজেক্ট।',
      totalShares: shares,
      allocatedShares: 0,
      pricePerShare: price,
      targetFund: shares * price,
      location: _locationController.text.isNotEmpty ? _locationController.text : 'Dhaka, Bangladesh',
      category: _selectedCategory,
      status: ProjectStatus.upcoming,
      startDate: DateTime.now(),
      projectCategory: ProjectCategory.realEstate,
      imageUrl: 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&auto=format&fit=crop&q=80',
    );

    widget.state.addProject(newProject);

    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('নতুন প্রজেক্ট সফলভাবে তৈরি হয়েছে!'),
        backgroundColor: Color(0xFF00C853),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final isBangla = widget.state.isBangla;

    return Scaffold(
      backgroundColor: palette.canvas,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: palette.ink),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isBangla ? 'নতুন প্রজেক্ট যোগ করুন' : 'Add New Project',
          style: GoogleFonts.hindSiliguri(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Image Upload Box
              Text(
                isBangla ? 'প্রজেক্ট ইমেজ' : 'Project Image',
                style: GoogleFonts.hindSiliguri(fontSize: 13, fontWeight: FontWeight.w600, color: palette.ink),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF0066FF).withValues(alpha: 0.4), width: 1.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0066FF).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.cloud_upload_outlined, size: 28, color: Color(0xFF0066FF)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isBangla ? 'ইমেজ আপলোড করুন' : 'Upload Project Banner',
                      style: GoogleFonts.hindSiliguri(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF0066FF)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // 2. Form Fields
              _buildFormInput('প্রজেক্টের নাম', 'LandVest 102', _nameController, palette),
              const SizedBox(height: 14),

              Text(
                'প্রজেক্ট টাইপ',
                style: GoogleFonts.hindSiliguri(fontSize: 12.5, fontWeight: FontWeight.w600, color: palette.ink),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: palette.ruleStrong, width: 1.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: ['Land Investment', 'Commercial Land', 'Residential', 'Agro Farming']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: GoogleFonts.poppins(fontSize: 13))))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedCategory = val);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(child: _buildFormInput('মোট শেয়ার', '100', _totalSharesController, palette, keyboardType: TextInputType.number)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildFormInput('শেয়ার মূল্য (প্রতি শেয়ার)', '25,500', _sharePriceController, palette, keyboardType: TextInputType.number)),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(child: _buildFormInput('সর্বনিম্ন বিনিয়োগ (শেয়ার)', '1', _minSharesController, palette, keyboardType: TextInputType.number)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildFormInput('মেয়াদ', '24 - 36 মাস', _durationController, palette)),
                ],
              ),
              const SizedBox(height: 14),

              _buildFormInput('প্রজেক্ট লোকেশন', 'Dhaka, Bangladesh', _locationController, palette),
              const SizedBox(height: 28),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isCreating ? null : _handleCreate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isCreating
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(
                          isBangla ? 'প্রজেক্ট তৈরি করুন' : 'Create Project',
                          style: GoogleFonts.hindSiliguri(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormInput(
    String label,
    String hint,
    TextEditingController controller,
    AppPalette palette, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.hindSiliguri(fontSize: 12.5, fontWeight: FontWeight.w600, color: palette.ink),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: palette.ruleStrong, width: 1.0),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.poppins(fontSize: 13.5, color: palette.ink),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(fontSize: 13, color: palette.inkTertiary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
