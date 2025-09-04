import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pmis_flutter/data/models/district_list_response.dart';
import 'package:pmis_flutter/utils/colors.dart';

class DistrictWiseTypeahead extends StatelessWidget {
  final TextEditingController controller;
  final Function(DistrictListResponse) onSelected;
  final Future<List<DistrictListResponse>> Function(String) onSearch;

  const DistrictWiseTypeahead({
    Key? key,
    required this.controller,
    required this.onSelected,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TypeAheadField<DistrictListResponse>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          autofocus: false,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF2D3142),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: cardColor,
            hintText: "Search district...",
            hintStyle: const TextStyle(
              color: Color(0xFF9EA3B8),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF9EA3B8),
              size: 20,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: accentBlue, width: 1.5),
            ),
          ),
        ),
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(12),
          elevation: 8,  // Increased elevation
          shadowColor: Colors.black.withOpacity(0.05),  // Subtle shadow color
          color: cardColor,
          constraints: const BoxConstraints(maxHeight: 300),
        ),
        suggestionsCallback: onSearch,
        itemBuilder: (context, suggestion) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              suggestion.name ?? "",
              style: const TextStyle(
                color: Color(0xFF2D3142),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        },
        onSuggestionSelected: onSelected,
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        animationDuration: Duration.zero,
      ),
    );
  }
}