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
            width: isTablet ? double.infinity : null, // 平板電腦全寬
            child: DraggableScrollableSheet(
              initialChildSize: isTablet ? 0.7 : 0.65,
              minChildSize: isTablet ? 0.6 : 0.5,
              maxChildSize: isTablet ? 0.9 : 0.65,
              builder: (context, scrollController) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(isTablet ? 24 : 20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 32 : 20,
                          ),
                          child: Text(
                            'Select Token',
                            style: TextStyle(
                              color: Color(0xFFDDE1E1),
                              fontSize: isTablet ? 32 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: isTablet ? 24 : 16),
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