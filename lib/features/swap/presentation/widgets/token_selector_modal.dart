import 'package:flutter/material.dart';
import '../../domain/entities/token.dart';
import '../../../../core/utils/responsive.dart';
import 'token_list_item.dart';

class TokenSelectorModal extends StatelessWidget {
  final List<Token> tokens;
  final Function(Token) onTokenSelected;
  
  const TokenSelectorModal({
    Key? key,
    required this.tokens,
    required this.onTokenSelected,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: isTablet ? screenWidth : null,
            child: DraggableScrollableSheet(
              initialChildSize: isTablet ? 0.7 : 0.65,
              minChildSize: isTablet ? 0.6 : 0.5,
              maxChildSize: isTablet ? 0.9 : 0.65,
              builder: (context, scrollController) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(isTablet ? 24 : 20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: isTablet ? 16 : 12),
                          width: isTablet ? 60 : 40,
                          height: isTablet ? 6 : 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 48 : 20,
                          ),
                          child: Text(
                            'Select Token',
                            style: TextStyle(
                              color: Color(0xFFDDE1E1),
                              fontSize: isTablet ? 48 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: isTablet ? 32 : 16),
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: tokens.length,
                            itemBuilder: (context, index) {
                              return TokenListItem(
                                token: tokens[index],
                                onTap: () {
                                  onTokenSelected(tokens[index]);
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}