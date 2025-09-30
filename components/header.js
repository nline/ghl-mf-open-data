// Header Component
export function createHeader() {
  return `
    <header class="bg-white shadow-sm border-b">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-4">
          <!-- Logo -->
          <div class="flex items-center">
            <a href="index.html">
              <img src="public/gh-labs-logo.svg" alt="GH+ Labs" class="h-12 w-auto hover:opacity-80 transition-opacity">
            </a>
          </div>
          
          <!-- Navigation -->
          <nav class="hidden md:flex space-x-8">
            <a href="index.html" class="text-blue-600 border-b-2 border-blue-600 pb-1 font-medium">DATA</a>
            <a href="#" class="text-gray-600 hover:text-gray-900 font-medium">CONTACT</a>
          </nav>
          
          <!-- User Guide -->
          <div class="flex items-center">
            <a href="#" class="flex items-center text-gray-600 hover:text-gray-900">
              <span class="material-icons text-lg mr-1">menu_book</span>
              <span class="text-sm font-medium">User Guide</span>
            </a>
          </div>
        </div>
      </div>
    </header>
  `;
}