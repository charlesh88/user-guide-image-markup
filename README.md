# User Guide Image Markup

A WYSIWYG callout editor for creating annotated images with interactive callouts.

## SASS Compilation Setup

This project uses SASS/SCSS for styling. The main stylesheet is `styles.scss` which compiles to `styles.css`.

### Prerequisites

You'll need to install a SASS compiler. Choose one of the following options:

#### Option 1: Node.js + Dart Sass (Recommended)

1. **Install Node.js** (if not already installed):
   ```bash
   # Download and install Node.js from https://nodejs.org/
   # Or use the portable version:
   curl -fsSL https://nodejs.org/dist/v20.10.0/node-v20.10.0-darwin-x64.tar.gz | tar -xz
   export PATH="$PWD/node-v20.10.0-darwin-x64/bin:$PATH"
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

#### Option 2: Homebrew + Dart Sass

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Dart Sass**:
   ```bash
   brew install sass/sass/sass
   ```

#### Option 3: Direct Dart Sass Download

```bash
curl -LO https://github.com/sass/dart-sass/releases/download/1.69.5/dart-sass-1.69.5-macos-x64.tar.gz
tar -xf dart-sass-1.69.5-macos-x64.tar.gz
export PATH="$PWD/dart-sass:$PATH"
```

### Usage

#### One-time Compilation

```bash
# Using the universal build script (tries multiple compilers)
./build.sh

# Using npm scripts (requires Node.js)
npm run build        # Compressed output
npm run sass:build   # Same as above
npm run sass:watch   # Watch mode with expanded output
```

#### Watch Mode (Auto-compilation on changes)

```bash
# Using the universal watch script
./watch.sh

# Using npm scripts (requires Node.js)
npm run dev         # Watch mode with source maps
npm start           # Same as above
npm run sass:watch  # Watch mode, expanded output
```

#### Manual Compilation Commands

If you have sass installed globally:

```bash
# Basic compilation
sass styles.scss styles.css

# With specific output style
sass styles.scss styles.css --style compressed

# Watch mode
sass --watch styles.scss:styles.css
```

### Available Scripts

| Script | Command | Description |
|--------|---------|-------------|
| `./build.sh` | Universal build script | One-time compilation, tries multiple compilers |
| `./watch.sh` | Universal watch script | Continuous compilation on file changes |
| `npm run build` | `sass styles.scss styles.css --style compressed` | Production build (compressed) |
| `npm run dev` | `sass --watch styles.scss:styles.css --style expanded --source-map` | Development with watch and source maps |
| `npm start` | Same as `npm run dev` | Development mode |
| `npm run sass:build` | `sass styles.scss styles.css --style compressed` | Production build |
| `npm run sass:watch` | `sass --watch styles.scss:styles.css --style expanded` | Watch mode |

### Output Styles

- **expanded**: Readable CSS with proper indentation (default for development)
- **compressed**: Minified CSS for production
- **nested**: CSS nested similar to the SCSS structure
- **compact**: Compact but readable format

### File Structure

```
user-guide-image-markup/
├── styles.scss        # Source SASS/SCSS file (edit this)
├── styles.css         # Compiled CSS file (auto-generated)
├── build.sh           # Universal build script
├── watch.sh           # Universal watch script
├── package.json       # npm configuration and scripts
└── index.html         # Main HTML file
```

### Troubleshooting

1. **"No SASS compiler found" error**: Install one of the compilers listed above
2. **"Command not found" error**: Make sure the compiler is in your PATH
3. **Permission denied**: Run `chmod +x build.sh watch.sh` to make scripts executable
4. **Node.js not found**: Install Node.js or use one of the alternative installation methods

### Development Workflow

1. Edit `styles.scss` with your changes
2. Run `./watch.sh` or `npm run dev` to start watch mode
3. Your changes will automatically compile to `styles.css`
4. Refresh your browser to see the changes

For production, run `./build.sh` or `npm run build` to generate a compressed CSS file.

## Project Features

- Interactive callout placement and editing
- Drag and drop functionality
- Multiple callout types (left, right, up, down)
- Resizable callouts
- Grid snapping
- Export functionality
- Responsive design

## Browser Support

This project uses modern CSS features and should work in all current browsers that support CSS Grid and Flexbox.