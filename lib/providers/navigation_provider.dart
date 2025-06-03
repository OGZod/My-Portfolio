
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  List<GlobalKey>? _sectionKeys;


  int get selectedIndex => _selectedIndex;
  List<GlobalKey>? get sectionKeys => _sectionKeys;

  // Initialize with section keys
  void initializeKeys(List<GlobalKey> keys) {
    _sectionKeys = keys;
  }
  
  // Set selected index with automatic scrolling
  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      _scrollToSection(index);
      notifyListeners();
    }
  }
  
  // Scroll to specific section
  void _scrollToSection(int index) {
    if (_sectionKeys != null && 
        index < _sectionKeys!.length && 
        _sectionKeys![index].currentContext != null) {
      Scrollable.ensureVisible(
        _sectionKeys![index].currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }
  
  // Convenience navigation methods
  void navigateToHome() => setSelectedIndex(0);
  void navigateToAbout() => setSelectedIndex(1);
  void navigateToSkills() => setSelectedIndex(2);
  void navigateToProjects() => setSelectedIndex(3);
  void navigateToExperience() => setSelectedIndex(4);
  void navigateToContact() => setSelectedIndex(5);
  
  // Get section name by index
  String getSectionName(int index) {
    const sectionNames = ['Home', 'About', 'Skills', 'Projects', 'Experience', 'Contact'];
    return index < sectionNames.length ? sectionNames[index] : 'Unknown';
  }
}