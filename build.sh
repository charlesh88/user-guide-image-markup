#!/bin/bash

# Universal SASS Build Script for user-guide-image-markup
# This script will try different SASS compilers in order of preference

set -e  # Exit on error

SOURCE_FILE="styles.scss"
OUTPUT_FILE="styles.css"
STYLE="expanded"  # Can be: nested, expanded, compact, compressed

echo "🎨 Starting SASS compilation..."
echo "Source: $SOURCE_FILE"
echo "Output: $OUTPUT_FILE"
echo "Style: $STYLE"
echo ""

# Function to compile with Dart Sass (npm)
compile_with_dart_sass() {
    if command -v npx &> /dev/null && npx sass --version &> /dev/null; then
        echo "✅ Using Dart Sass (npm)"
        npx sass "$SOURCE_FILE" "$OUTPUT_FILE" --style="$STYLE"
        return 0
    fi
    return 1
}

# Function to compile with global sass command
compile_with_global_sass() {
    if command -v sass &> /dev/null; then
        echo "✅ Using global sass command"
        sass "$SOURCE_FILE" "$OUTPUT_FILE" --style="$STYLE"
        return 0
    fi
    return 1
}

# Function to compile with Ruby Sass (legacy)
compile_with_ruby_sass() {
    if command -v sass &> /dev/null && sass --version 2>&1 | grep -q "Ruby Sass"; then
        echo "✅ Using Ruby Sass (legacy)"
        sass --style "$STYLE" "$SOURCE_FILE" "$OUTPUT_FILE"
        return 0
    fi
    return 1
}

# Function to compile with sassc (C++ implementation)
compile_with_sassc() {
    if command -v sassc &> /dev/null; then
        echo "✅ Using sassc (C++)"
        case "$STYLE" in
            "nested") SASSC_STYLE="nested" ;;
            "expanded") SASSC_STYLE="expanded" ;;
            "compact") SASSC_STYLE="compact" ;;
            "compressed") SASSC_STYLE="compressed" ;;
            *) SASSC_STYLE="expanded" ;;
        esac
        sassc -t "$SASSC_STYLE" "$SOURCE_FILE" "$OUTPUT_FILE"
        return 0
    fi
    return 1
}

# Try compilation methods in order of preference
if compile_with_dart_sass || compile_with_global_sass || compile_with_sassc || compile_with_ruby_sass; then
    echo ""
    echo "✅ SASS compilation successful!"
    echo "📁 Output written to: $OUTPUT_FILE"
    
    # Show file size
    if [[ -f "$OUTPUT_FILE" ]]; then
        FILE_SIZE=$(stat -f%z "$OUTPUT_FILE" 2>/dev/null || stat -c%s "$OUTPUT_FILE" 2>/dev/null || echo "unknown")
        echo "📊 File size: ${FILE_SIZE} bytes"
    fi
else
    echo ""
    echo "❌ No SASS compiler found!"
    echo ""
    echo "Please install one of the following:"
    echo ""
    echo "1. Node.js + Dart Sass (Recommended):"
    echo "   curl -fsSL https://nodejs.org/dist/v20.10.0/node-v20.10.0-darwin-x64.tar.gz | tar -xz"
    echo "   export PATH=\"\$PWD/node-v20.10.0-darwin-x64/bin:\$PATH\""
    echo "   npm install"
    echo ""
    echo "2. Homebrew + Dart Sass:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo "   brew install sass/sass/sass"
    echo ""
    echo "3. Direct Dart Sass download:"
    echo "   curl -LO https://github.com/sass/dart-sass/releases/download/1.69.5/dart-sass-1.69.5-macos-x64.tar.gz"
    echo "   tar -xf dart-sass-1.69.5-macos-x64.tar.gz"
    echo "   export PATH=\"\$PWD/dart-sass:\$PATH\""
    echo ""
    echo "4. sassc (C++ implementation):"
    echo "   # Available through most package managers"
    echo ""
    exit 1
fi