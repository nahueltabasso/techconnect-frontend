import 'package:flutter/material.dart';

class ContextService {

  static final ContextService _instance = ContextService._internal();
  BuildContext? _context;


  factory ContextService() {
    return _instance;
  }

    ContextService._internal();

  void setContext(BuildContext context) {
    _context = context;
  }

  BuildContext? get context => _context;

}