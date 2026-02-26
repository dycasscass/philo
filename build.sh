#!/bin/bash
set -e

FLUTTER_VERSION="3.27.4"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

echo "Installing Flutter ${FLUTTER_VERSION}..."
curl -sL "$FLUTTER_URL" | tar xJ -C "$HOME"
export PATH="$HOME/flutter/bin:$PATH"

flutter config --no-analytics
flutter doctor -v

echo "Building Flutter web app..."
flutter build web --release
