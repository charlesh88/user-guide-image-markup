#!/bin/bash

# SASS Watch Script for user-guide-image-markup
# This script will continuously watch for changes and recompile SASS

set -e  # Exit on error

SOURCE_FILE="styles.scss"
OUTPUT_FILE="styles.css"
STYLE="expanded"  # Can be: nested, expanded, compact, compressed

echo "👀 Starting SASS watch mode..."
echo "Source: $SOURCE_FILE"
echo "Output: $OUTPUT_FILE"
echo "Style: $STYLE"
echo ""
echo "Press Ctrl+C to stop watching"
echo ""

# Function to compile and watch with Dart Sass (npm)
watch_with_dart_sass() {
    if command -v npx &> /dev/null && npx sass --version &> /dev/null; then
        echo "✅ Using Dart Sass (npm) in watch mode"
        npx sass --watch "$SOURCE_FILE":"$OUTPUT_FILE" --style="$STYLE"
        return 0
    fi
    return 1
}

# Function to compile and watch with global sass command
watch_with_global_sass() {
    if command -v sass &> /dev/null; then
        echo "✅ Using global sass command in watch mode"
        sass --watch "$SOURCE_FILE":"$OUTPUT_FILE" --style="$STYLE"
        return 0
    fi
    return 1
}

# Function to manually watch with basic tools (fallback)
watch_with_basic_tools() {
    echo "⚠️  Using basic file watching (less efficient)"
    echo "Installing fswatch might improve performance..."
    echo ""
    
    # Compile once initially
    if ! ./build.sh; then
        echo "❌ Initial compilation failed"
        exit 1
    fi
    
    # Get initial modification time
    LAST_MOD=""
    if [[ -f "$SOURCE_FILE" ]]; then
        LAST_MOD=$(stat -f%m "$SOURCE_FILE" 2>/dev/null || stat -c%Y "$SOURCE_FILE" 2>/dev/null || echo "0")
    fi
    
    echo "Watching for changes to $SOURCE_FILE..."
    while true; do
        if [[ -f "$SOURCE_FILE" ]]; then
            CURRENT_MOD=$(stat -f%m "$SOURCE_FILE" 2>/dev/null || stat -c%Y "$SOURCE_FILE" 2>/dev/null || echo "0")
            if [[ "$CURRENT_MOD" != "$LAST_MOD" ]]; then
                echo ""
                echo "🔄 Change detected in $SOURCE_FILE"
                if ./build.sh; then
                    echo "✅ Recompiled successfully at $(date '+%H:%M:%S')"
                else
                    echo "❌ Compilation failed at $(date '+%H:%M:%S')"
                fi
                echo "Continuing to watch..."
                LAST_MOD="$CURRENT_MOD"
            fi
        fi
        sleep 1
    done
}

# Function to watch with fswatch (if available)
watch_with_fswatch() {
    if command -v fswatch &> /dev/null; then
        echo "✅ Using fswatch for file monitoring"
        
        # Compile once initially
        if ! ./build.sh; then
            echo "❌ Initial compilation failed"
            exit 1
        fi
        
        echo "Watching for changes to $SOURCE_FILE..."
        fswatch -o "$SOURCE_FILE" | while read f; do
            echo ""
            echo "🔄 Change detected in $SOURCE_FILE"
            if ./build.sh; then
                echo "✅ Recompiled successfully at $(date '+%H:%M:%S')"
            else
                echo "❌ Compilation failed at $(date '+%H:%M:%S')"
            fi
            echo "Continuing to watch..."
        done
        return 0
    fi
    return 1
}

# Try watch methods in order of preference
if ! (watch_with_dart_sass || watch_with_global_sass || watch_with_fswatch); then
    echo "ℹ️  Advanced watch modes not available, falling back to basic monitoring"
    echo "   For better performance, install one of:"
    echo "   - Node.js + sass: npm install"
    echo "   - fswatch: brew install fswatch"
    echo ""
    watch_with_basic_tools
fi