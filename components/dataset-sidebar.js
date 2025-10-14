// Dataset Sidebar Component
export function createDatasetSidebar(options = {}) {
  const {
    countries = 'Kenya',
    publisher = 'nLine Inc.',
    publisherUrl = 'https://nline.io',
    contact = 'info@nline.io',
    showShareLinks = true,
    shareMessage = 'Check%20out%20the%20MF%20Power%20Data%20dataset%20from%20the%20New%20Horizons%20Team%20at%20Global%20Health%20Labs%20-%20comprehensive%20power%20quality%20data%20from%20Kenya',
    datasetUrl = 'https://d26lhl8wzfc5j.cloudfront.net/index.html'
  } = options;

  const shareLinks = showShareLinks ? `
    <div class="flex space-x-2 mt-2">
      <!--Twitter/X-->
      <a href="https://twitter.com/intent/tweet?text=${shareMessage}&url=${datasetUrl}" target="_blank" class="text-gray-600 hover:text-gray-900">
        <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
          <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
        </svg>
      </a>
      <!--Facebook-->
      <a href="https://www.facebook.com/sharer/sharer.php?u=${datasetUrl}&quote=${shareMessage}" target="_blank" class="text-gray-600 hover:text-gray-900">
        <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
          <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
        </svg>
      </a>
      <!--LinkedIn-->
      <a href="https://www.linkedin.com/sharing/share-offsite/?url=${datasetUrl}&title=${shareMessage}" target="_blank" class="text-gray-600 hover:text-gray-900">
        <svg class="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
          <path d="M22 21.968H17.859V15.4807C17.859 13.934 17.8311 11.9422 15.7049 11.9422C13.5481 11.9422 13.2178 13.6273 13.2178 15.3671V21.9675H9.07683V8.63045H13.0522V10.4534H13.1058C13.5036 9.77309 14.0786 9.2134 14.7695 8.83408C15.4602 8.45467 16.241 8.2698 17.0285 8.29915C21.2258 8.29915 22 11.0603 22 14.6519V21.968ZM4.40396 6.80704C3.92859 6.80714 3.46386 6.66627 3.06855 6.40223C2.67323 6.1382 2.3651 5.76285 2.18311 5.32368C2.00112 4.8845 1.95344 4.40122 2.04611 3.93494C2.13879 3.46868 2.36765 3.04036 2.70376 2.70417C3.03986 2.36797 3.46811 2.13901 3.93435 2.04622C4.40057 1.95344 4.88385 2.001 5.32305 2.18291C5.76226 2.36481 6.13765 2.67287 6.40176 3.06814C6.66588 3.46341 6.80685 3.92813 6.80685 4.40352C6.80685 5.04088 6.55371 5.65214 6.10309 6.10287C5.65249 6.55361 5.0413 6.8069 4.40396 6.80704ZM6.47446 21.9675H2.32917V8.63045H6.47499L6.47446 21.9675Z"/>
        </svg>
      </a>
    </div>
  ` : '';

  return `
    <div class="lg:col-span-1">
      <div class="bg-white rounded-lg shadow-sm p-6 space-y-6">
        <!-- Countries -->
        <div class="flex items-start space-x-3">
          <span class="material-icons text-blue-600 text-2xl">public</span>
          <div>
            <h3 class="font-semibold text-gray-900">Countries covered</h3>
            <p class="text-gray-600 text-sm">${countries}</p>
          </div>
        </div>
        
        <!-- Publisher -->
        <div class="flex items-start space-x-3">
          <span class="material-icons text-blue-600 text-2xl">business</span>
          <div>
            <h3 class="font-semibold text-gray-900">Publisher</h3>
            <p class="text-gray-600 text-sm"><a href="${publisherUrl}" class="text-blue-600 hover:underline">${publisher}</a></p>
          </div>
        </div>
        
        <!-- Contact -->
        <div class="flex items-start space-x-3">
          <span class="material-icons text-blue-600 text-2xl">email</span>
          <div>
            <h3 class="font-semibold text-gray-900">Contact</h3>
            <p class="text-gray-600 text-sm"><a href="mailto:${contact}" class="text-blue-600 hover:underline">${contact}</a></p>
          </div>
        </div>
        
        <!-- Share -->
        <div class="flex items-start space-x-3">
          <span class="material-icons text-blue-600 text-2xl">share</span>
          <div>
            <h3 class="font-semibold text-gray-900">Share</h3>
            ${shareLinks}
          </div>
        </div>
      </div>
    </div>
  `;
}
