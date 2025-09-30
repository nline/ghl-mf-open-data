// Footer Component
export function createFooter() {
  return `
    <footer class="bg-white border-t mt-16">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="flex flex-col md:flex-row justify-between items-center">
          <!-- Logo -->
          <div class="flex items-center mb-4 md:mb-0">
            <a href="index.html">
              <img src="public/gh-labs-logo.svg" alt="GH+ Labs" class="h-12 w-auto hover:opacity-80 transition-opacity">
            </a>
          </div>
          
          <!-- Navigation -->
          <nav class="flex space-x-6 mb-4 md:mb-0">
            <a href="#" class="text-gray-600 hover:text-gray-900">About</a>
            <a href="#" class="text-gray-600 hover:text-gray-900">Website Policies</a>
            <a href="#" class="text-gray-600 hover:text-gray-900">Sitemap</a>
          </nav>
          
          <!-- Social Links -->
          <div class="flex items-center space-x-4">
            <span class="text-gray-600 text-sm">Stay in touch:</span>
            <a href="#" class="text-gray-600 hover:text-gray-900">
              <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M22 21.968H17.859V15.4807C17.859 13.934 17.8311 11.9422 15.7049 11.9422C13.5481 11.9422 13.2178 13.6273 13.2178 15.3671V21.9675H9.07683V8.63045H13.0522V10.4534H13.1058C13.5036 9.77309 14.0786 9.2134 14.7695 8.83408C15.4602 8.45467 16.241 8.2698 17.0285 8.29915C21.2258 8.29915 22 11.0603 22 14.6519V21.968ZM4.40396 6.80704C3.92859 6.80714 3.46386 6.66627 3.06855 6.40223C2.67323 6.1382 2.3651 5.76285 2.18311 5.32368C2.00112 4.8845 1.95344 4.40122 2.04611 3.93494C2.13879 3.46868 2.36765 3.04036 2.70376 2.70417C3.03986 2.36797 3.46811 2.13901 3.93435 2.04622C4.40057 1.95344 4.88385 2.001 5.32305 2.18291C5.76226 2.36481 6.13765 2.67287 6.40176 3.06814C6.66588 3.46341 6.80685 3.92813 6.80685 4.40352C6.80685 5.04088 6.55371 5.65214 6.10309 6.10287C5.65249 6.55361 5.0413 6.8069 4.40396 6.80704ZM6.47446 21.9675H2.32917V8.63045H6.47499L6.47446 21.9675Z"/>
              </svg>
            </a>
            <a href="#" class="text-gray-600 hover:text-gray-900">
              <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
                <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
              </svg>
            </a>
          </div>
        </div>
      </div>
    </footer>
  `;
}