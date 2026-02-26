import 'dart:io';

void main() async {
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  print('Serving at http://localhost:8080');

  final webDir = '${Platform.script.resolve('.').toFilePath()}build/web';

  await for (final request in server) {
    var path = request.uri.path;
    if (path == '/') path = '/index.html';

    final file = File('$webDir$path');
    if (await file.exists()) {
      final ext = path.split('.').last;
      final contentTypes = {
        'html': 'text/html',
        'js': 'application/javascript',
        'css': 'text/css',
        'json': 'application/json',
        'png': 'image/png',
        'ico': 'image/x-icon',
        'wasm': 'application/wasm',
        'ttf': 'font/ttf',
        'otf': 'font/otf',
      };
      request.response.headers.contentType =
          ContentType.parse(contentTypes[ext] ?? 'application/octet-stream');
      request.response.add(await file.readAsBytes());
    } else {
      // SPA fallback
      final index = File('$webDir/index.html');
      request.response.headers.contentType = ContentType.html;
      request.response.add(await index.readAsBytes());
    }
    await request.response.close();
  }
}
