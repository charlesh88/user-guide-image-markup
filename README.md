# Open MCT User's Guide Image Annotation Tool
## v1.0

![Callout Editor](https://img.shields.io/badge/Status-Active-success)
![HTML5](https://img.shields.io/badge/HTML5-orange)
![CSS3](https://img.shields.io/badge/CSS3-blue)
![JavaScript](https://img.shields.io/badge/JavaScript-yellow)

## Overview

A WYSIWYG callout editor for creating annotated images with numbered callouts for the Open MCT User's Guide in Docusaurus.
- Load images and add numbered callouts in four directions (left, right, up, down)
- Position callouts with grid snapping
- Export annotated images as JSON with images embedded as image data
- Load and edit existing annotated images

## Getting Started

### Quick Start

1. Open `index.html` in a modern web browser
2. Click **"Load Image..."** to upload an image
3. Click **"+ Add"** to create callouts on your image
4. Drag callouts to position them
5. Click **"Save"** to export as JSON

### Requirements

- Modern web browser (Chrome, Firefox, Safari, Edge)
- No server required - runs entirely in the browser
- No build process needed - just open the HTML file

## Features

### Callout Types

Four directional callout styles:
- **To Right (`--to-r`)**: Callout extends to the right with number on the left
- **To Left (`--to-l`)**: Callout extends to the left with number on the right
- **Up (`--up`)**: Vertical callout pointing upward
- **Down (`--down`)**: Vertical callout pointing downward

### Editing Capabilities

- **Drag & Drop**: Click and drag callouts to reposition them
- **Alt+Drag Duplication**: Hold Alt/Option while dragging to duplicate callouts
- **Resize**: Click and drag the resize handle on selected callouts
- **Grid Snapping**: Enable "Snap to Grid" for precise 5px alignment
- **Multi-Selection**: Drag a marquee box to select multiple callouts
- **Inline Editing**: Click callout numbers to edit them directly
- **Bracket Toggle**: Show/hide the bracket indicator per callout

### Keyboard Shortcuts

- **Escape**: Deselect all callouts
- **Alt/Option + Drag**: Duplicate a callout while dragging

### Properties Panel

When a callout is selected, edit:
- **Number**: The callout label (1-99)
- **X Position**: Horizontal position as percentage
- **Y Position**: Vertical position as percentage
- **Width**: Callout width as percentage
- **Height**: Callout height as percentage

### JSON Export/Import

**Export** creates a JSON file containing:
- Image as base64 data URI
- All callout configurations (position, size, type, number)
- Bracket visibility settings

**Import** loads previously saved configurations for editing.

## Usage Guide

### Creating Callouts

1. **Load an image**: Click "Load Image..." and select your screenshot or diagram
2. **Add callouts**: Click "+ Add" to create a new callout
3. **Position**: Drag callouts to the desired location
4. **Resize**: Drag the resize handle (appears when selected)
5. **Edit number**: Click the number to type a new value
6. **Change type**: Select a different direction from the "Callout Type" dropdown

### Multi-Callout Operations

1. **Select multiple**: Click on canvas and drag to create a selection box
2. **Bulk type change**: Change the type for all selected callouts at once
3. **Bulk bracket toggle**: Show/hide brackets for all selected callouts
4. **Drag group**: Drag any selected callout to move all together

### Duplicating Callouts

1. Hold **Alt/Option** key
2. Click and drag an existing callout
3. Release to create a duplicate at the new position

### Saving & Loading

**Save workflow:**
1. Enter a filename (optional, defaults to "Unnamed")
2. Click **"Save"** to download JSON file
3. JSON includes embedded image data - no external files needed

**Load workflow:**
1. Click **"Load JSON..."**
2. Select a previously saved `.json` file
3. Edit and re-save as needed

### Starting a New Project

Click **"+ New"** to clear the workspace. You'll be prompted to confirm if you have unsaved work.

## Project Structure

```
user-guide-image-markup/
├── index.html          # Main application (all-in-one file)
├── styles.scss         # Source SCSS styles
├── styles.css          # Compiled CSS (generated)
└── README.md           # This file
```

## Technical Details

### Architecture

- **Vanilla JavaScript**: No frameworks or dependencies
- **Single-page application**: All code in `index.html`
- **Percentage-based positioning**: Callouts scale with image size
- **Data URI images**: Embedded base64 encoding for portability

### Browser Support

Requires modern browser features:
- CSS Grid and Flexbox
- ES6 JavaScript (arrow functions, classes, const/let)
- FileReader API
- contentEditable

Tested on:
- Chrome 90+
- Firefox 88+
- Safari 14+
- Edge 90+

## JSON Format

Example output structure:

```json
{
  "image": "data:image/png;base64,iVBORw0KG...",
  "alt": "Image with callouts",
  "callouts": [
    {
      "content": "1",
      "width": "10%",
      "height": "6.2%",
      "top": "10%",
      "right": "50%",
      "type": "--to-r",
      "showBracket": true
    }
  ]
}
```

## Tips & Best Practices

1. **Use grid snapping** for consistent alignment across callouts
2. **Save frequently** to avoid losing work
3. **Name your files descriptively** for easy organization
4. **Duplicate similar callouts** (Alt+Drag) to save time
5. **Use multi-select** to quickly change types or bracket visibility
6. **Keep callout numbers sequential** for better readability in documentation

## Troubleshooting

**Callout won't move**: Make sure you're not clicking on the number (which is editable)

**Can't select callout**: Click directly on the callout element, not the canvas

**Properties panel is empty**: Select a callout by clicking on it

**Duplicate not staying selected**: This is working as intended after the latest update

**Save button doesn't work**: Make sure you've loaded an image first

## License

This project is open source and available for use in documentation workflows.