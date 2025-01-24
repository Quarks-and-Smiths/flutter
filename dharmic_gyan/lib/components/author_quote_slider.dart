import 'package:dharmic_gyan/components/custom_page_indicator.dart';
import 'package:dharmic_gyan/components/floating_buttons.dart';
import 'package:dharmic_gyan/models/author.dart';
import 'package:dharmic_gyan/models/quote.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthorQuoteSlider extends StatefulWidget {
  final List<Quote> quotes;
  final Author author;
  final int initialIndex;

  const AuthorQuoteSlider({
    super.key,
    required this.quotes,
    required this.author,
    required this.initialIndex,
  });

  @override
  State<AuthorQuoteSlider> createState() => _AuthorQuoteSliderState();
}

class _AuthorQuoteSliderState extends State<AuthorQuoteSlider> {
  late PageController _pageController;
  late FlutterTts flutterTts;
  int _currentPage = 0;
  final Map<int, double> _authorOpacities = {};
  final Map<int, double> _quoteOpacities = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    flutterTts = FlutterTts();
    _resetOpacityForPage(widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  void _resetOpacityForPage(int pageIndex) {
    setState(() {
      _authorOpacities[pageIndex] = 0.0;
      _quoteOpacities[pageIndex] = 0.0;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _authorOpacities[pageIndex] = 1.0;
          _quoteOpacities[pageIndex] = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF282828),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.author.name,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            pageSnapping: true,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              _resetOpacityForPage(index);
            },
            itemCount: widget.quotes.length,
            itemBuilder: (context, index) {
              return _buildQuoteCard(widget.quotes[index], index);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: CustomPageIndicator(
              totalPages: widget.quotes.length,
              currentPage: _currentPage,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingButtons(
        quote: widget.quotes[_currentPage],
        quotes: widget.quotes,
        currentIndex: _currentPage,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  Widget _buildQuoteCard(Quote quote, int index) {
    // Initialize opacities for new pages
    _authorOpacities.putIfAbsent(index, () => 0.0);
    _quoteOpacities.putIfAbsent(index, () => 0.0);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author section
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _authorOpacities[index] ?? 0.0,
            curve: Curves.easeIn,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80.0),
                  child: Image.asset(
                    quote.author.value?.image ?? 'assets/images/buddha.png',
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quote.author.value?.name ?? 'Unknown',
                      style: GoogleFonts.notoSansJp(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Spiritual Leader',
                      style: GoogleFonts.notoSansJp(
                        fontSize: 13.0,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 2.0,
                      ),
                      width: 200.0,
                      child: Divider(
                        color: Colors.grey.shade800,
                        thickness: 2.0,
                        height: 2.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // Quote section
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _quoteOpacities[index] ?? 0.0,
              curve: Curves.easeIn,
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 25, top: 10),
                child: SingleChildScrollView(
                  child: Text(
                    "\u201C${quote.quote}\u201D",
                    style: GoogleFonts.notoSerif(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
