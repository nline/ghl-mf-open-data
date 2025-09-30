# JavaScript Components System

This project uses JavaScript ES6 modules to create reusable components for consistent header and footer across all pages.

## 🎯 How It Works

The system uses modern JavaScript modules to dynamically load header and footer components into HTML pages. This approach provides:

- ✅ **Reusable components** - Write once, use everywhere
- ✅ **Easy maintenance** - Update components in one place
- ✅ **No build step required** - Works directly in browsers
- ✅ **Modern JavaScript** - Uses ES6 modules
- ✅ **Consistent design** - All pages look the same

## 📁 Project Structure

```
mf-power-data-test/
├── components/           # JavaScript ES6 modules
│   ├── header.js        # Header component
│   └── footer.js        # Footer component
├── index.html           # Main data catalog page
├── kenya-power-data.html # Kenya dataset page
├── public/              # Static assets
│   └── gh-labs-logo.svg # Logo file
└── build/               # Build output
```


## 🔧 Customizing Components

### **Modify Header**

Edit `components/header.js`:

```javascript
export function createHeader() {
  return `
    <header class="bg-white shadow-sm border-b">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-4">
          <!-- Your custom header content -->
        </div>
      </div>
    </header>
  `;
}
```

### **Modify Footer**

Edit `components/footer.js`:

```javascript
export function createFooter() {
  return `
    <footer class="bg-white border-t mt-16">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Your custom footer content -->
      </div>
    </footer>
  `;
}
```

### **Add New Components**

Create a new component file, e.g., `components/sidebar.js`:

```javascript
export function createSidebar() {
  return `
    <aside class="bg-gray-100 p-4">
      <h3 class="font-semibold text-gray-900">Sidebar</h3>
      <p class="text-gray-600">Sidebar content</p>
    </aside>
  `;
}
```

Then use it in your HTML:

```html
<div id="sidebar"></div>

<script type="module">
    import { createSidebar } from './components/sidebar.js';
    document.getElementById('sidebar').innerHTML = createSidebar();
</script>
```

## 🎨 Styling Components

Components use Tailwind CSS classes and can be styled just like regular HTML:

```javascript
export function createHeader() {
  return `
    <header class="bg-blue-600 text-white shadow-lg">
      <!-- Header content with custom styling -->
    </header>
  `;
}
```

## 📱 Responsive Design

Components automatically inherit responsive behavior:

```javascript
export function createHeader() {
  return `
    <header class="bg-white shadow-sm border-b">
      <nav class="hidden md:flex space-x-8">
        <!-- Navigation items -->
      </nav>
    </header>
  `;
}
```

## 🔄 Updating Components

### **Global Updates**
- Modify the component file once
- All pages automatically get the update
- No need to edit individual pages

### **Page-Specific Customization**
- Override component behavior with JavaScript
- Use CSS to customize appearance
- Add page-specific content

## 🚀 Development Workflow

1. **Create new pages** using the template structure
2. **Modify components** in the `components/` directory
3. **Test locally** by opening HTML files in your browser
4. **Build for production** using `make build`
5. **Deploy** to your hosting provider

## 🛠️ Available Makefile Commands

```bash
# Show available components
make components

# Build the project
make build

# Start development server
make serve

# Run all checks
make validate

# Clean build directory
make clean
```
