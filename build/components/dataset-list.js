// Dataset List Component
export function generateDatasetList() {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const datasets = [];
    
    // Start from June 2017
    let year = 2017;
    let monthIndex = 5; // June is index 5
    
    // Generate until September 2025
    while (year < 2025 || (year === 2025 && monthIndex <= 8)) { // September is index 8
        const monthName = months[monthIndex];
        const fileName = `Kenya_${year}_${monthName}.parquet`;
        const s3Url = `s3://ghl-mfs-data/data/kenya/${fileName}`;
        const cloudFrontUrl = `https://d2g52vato6bo1j.cloudfront.net/data/kenya/${fileName}`;
        const displayName = `Kenya ${monthName} ${year}`;
        
        datasets.push({
            fileName,
            s3Url,
            cloudFrontUrl,
            displayName,
            year,
            month: monthName
        });
        
        // Move to next month
        monthIndex++;
        if (monthIndex >= 12) {
            monthIndex = 0;
            year++;
        }
    }
    
    return datasets;
}

export function createDatasetListHTML(datasets) {
    let html = '';
    
    datasets.forEach(dataset => {
        html += `
                        <!-- ${dataset.displayName} -->
                        <div class="flex items-center justify-between p-4 border border-gray-200 rounded-lg hover:bg-gray-50">
                            <div class="flex items-center space-x-4">
                                <span class="material-icons text-green-600 text-2xl">description</span>
                                <div>
                                    <h3 class="font-medium text-gray-900">${dataset.displayName}</h3>
                                </div>
                            </div>
                            <a href="${dataset.cloudFrontUrl}" target="_blank" class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg flex items-center text-sm font-medium">
                                <span class="material-icons text-sm mr-1">download</span>
                                Download
                            </a>
                        </div>
        `;
    });
    
    return html;
}

export function createPaginationHTML(currentPage, totalPages) {
    let html = '<div class="flex justify-center items-center space-x-2 mb-8">';
    
    // Previous button
    if (currentPage > 1) {
        html += `<button onclick="changePage(${currentPage - 1})" class="px-3 py-2 text-gray-500 hover:text-gray-700">Previous</button>`;
    } else {
        html += `<button disabled class="px-3 py-2 text-gray-300 cursor-not-allowed">Previous</button>`;
    }
    
    // Page numbers
    const startPage = Math.max(1, currentPage - 2);
    const endPage = Math.min(totalPages, currentPage + 2);
    
    if (startPage > 1) {
        html += `<button onclick="changePage(1)" class="px-3 py-2 text-gray-500 hover:text-gray-700">1</button>`;
        if (startPage > 2) {
            html += `<span class="px-3 py-2 text-gray-500">...</span>`;
        }
    }
    
    for (let i = startPage; i <= endPage; i++) {
        if (i === currentPage) {
            html += `<button class="px-3 py-2 bg-blue-600 text-white rounded">${i}</button>`;
        } else {
            html += `<button onclick="changePage(${i})" class="px-3 py-2 text-gray-500 hover:text-gray-700">${i}</button>`;
        }
    }
    
    if (endPage < totalPages) {
        if (endPage < totalPages - 1) {
            html += `<span class="px-3 py-2 text-gray-500">...</span>`;
        }
        html += `<button onclick="changePage(${totalPages})" class="px-3 py-2 text-gray-500 hover:text-gray-700">${totalPages}</button>`;
    }
    
    // Next button
    if (currentPage < totalPages) {
        html += `<button onclick="changePage(${currentPage + 1})" class="px-3 py-2 text-gray-500 hover:text-gray-700">Next</button>`;
    } else {
        html += `<button disabled class="px-3 py-2 text-gray-300 cursor-not-allowed">Next</button>`;
    }
    
    html += '</div>';
    return html;
}

// Sorting functions
export function sortDatasets(datasets, sortBy) {
    const sortedDatasets = [...datasets];
    
    // Month order for chronological sorting
    const monthOrder = {
        'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
        'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    };
    
    switch (sortBy) {
        case 'year-desc':
            return sortedDatasets.sort((a, b) => {
                // First sort by year (descending)
                if (b.year !== a.year) {
                    return b.year - a.year;
                }
                // Then by month (descending within year)
                return monthOrder[b.month] - monthOrder[a.month];
            });
        case 'year-asc':
            return sortedDatasets.sort((a, b) => {
                // First sort by year (ascending)
                if (a.year !== b.year) {
                    return a.year - b.year;
                }
                // Then by month (ascending within year)
                return monthOrder[a.month] - monthOrder[b.month];
            });
        case 'name-asc':
            return sortedDatasets.sort((a, b) => a.displayName.localeCompare(b.displayName));
        case 'name-desc':
            return sortedDatasets.sort((a, b) => b.displayName.localeCompare(a.displayName));
        default:
            return sortedDatasets;
    }
}
