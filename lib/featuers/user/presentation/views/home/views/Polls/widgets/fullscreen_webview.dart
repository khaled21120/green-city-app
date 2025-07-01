import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullScreenWebView extends StatefulWidget {
  const FullScreenWebView({
    super.key,
    required this.url,
    this.title = 'Loading...',
  });

  final String url;
  final String? title;

  @override
  State<FullScreenWebView> createState() => _FullScreenWebViewState();
}

class _FullScreenWebViewState extends State<FullScreenWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  late String _title;

  @override
  void initState() {
    super.initState();
    _title = widget.title ?? 'Loading...';

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) => _setLoading(true),
              onPageFinished: (_) async {
                _setLoading(false);
                final t = await _controller.getTitle();
                if (t != null && t.isNotEmpty) setState(() => _title = t);
              },
              onWebResourceError: (_) => _setError(),
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  void _setLoading(bool value) => setState(() => _isLoading = value);

  void _setError() {
    _setLoading(false);
    setState(() => _title = 'Error Loading Page');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) async {
        if (!didPop && await _controller.canGoBack()) {
          await _controller.goBack();
        } else if (!didPop) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title, overflow: TextOverflow.ellipsis),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  _isLoading
                      ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : IconButton(
                        key: const ValueKey('refresh'),
                        icon: const Icon(Icons.refresh),
                        onPressed: () => _controller.reload(),
                      ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async => _controller.reload(),
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_isLoading) const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
