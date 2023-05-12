document.addEventListener("DOMContentLoaded", () => {
  const exportCsvLink = document.querySelector("#export-csv");

  if (exportCsvLink) {
    exportCsvLink.addEventListener("click", (event) => {
      event.preventDefault();
      const url = event.target.getAttribute("href");

      fetch(url)
        .then((response) => response.blob())
        .then((blob) => {
          const url = window.URL.createObjectURL(blob);
          const a = document.createElement("a");
          a.href = url;
          a.download = `bookmarks-${new Date().toISOString().slice(0, 10)}.csv`;
          a.click();
        });
    });
  }
});
