// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

const results = document.getElementById('search-results');
const input = document.getElementById('search-input');

const showSearchResult = (data) => {
  results.innerHTML = '';

  data.forEach(element => {
    const newElement = document.createElement('li');
    newElement.innerHTML = element.value;
    results.appendChild(newElement);
  });
}

input.addEventListener('keyup', (e) => {
  fetch(`/searches?query=${e.target.value}`)
  .then(data => data.json())
  .then(data => {
    if (data.length > 0) {
      showSearchResult(data);
    }

    if (data.error) {
      results.innerHTML = data.error;
    }
  })
});
