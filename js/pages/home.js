// Digital Bank - Home Page Interactive Logic
document.addEventListener('DOMContentLoaded', function () {
  // Balance ticker simulation
  const balanceEl = document.querySelector('.phone-balance');
  if (balanceEl && balanceEl.textContent.includes('₹')) {
    // Interactive hover effect
    balanceEl.style.cursor = 'pointer';
    balanceEl.title = 'Click to toggle currency format';
  }

  // Search button functionality
  const searchBtn = document.querySelector('.search-btn');
  if (searchBtn) {
    searchBtn.addEventListener('click', function () {
      const query = prompt('Search Digital Bank services or FAQs:');
      if (query) {
        window.location.href = 'services.html?q=' + encodeURIComponent(query);
      }
    });
  }
});
