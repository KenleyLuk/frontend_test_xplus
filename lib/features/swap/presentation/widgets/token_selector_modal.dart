import 'package:flutter/material.dart';
import '../../domain/entities/token.dart';
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
    return Stack(
      children: [
        // 可以點擊的半透明背景層比popup dialog
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
        
        DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.5,
          maxChildSize: 0.65,
          builder: (context, scrollController) {
            return GestureDetector(
              onTap: () {}, 
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1F1F1F),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    // popup menu線
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Select Token',
                        style: TextStyle(color: Color(0xFFDDE1E1), fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Token list
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
      ],
    );
  }
}