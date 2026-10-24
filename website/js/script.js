document.addEventListener("DOMContentLoaded", function() {
  const bottoneMenu = document.getElementById('bottoneMenu');
  const menu = document.getElementById('menu');
  const overlay = document.getElementById('overlay-sfondo');
  const linksMenu = document.querySelectorAll('#menu a');

  function chiudiMenu() {
    menu.classList.remove('attivo');
    overlay.classList.remove('attivo');
  }

  function apriMenu() {
    menu.classList.add('attivo');
    overlay.classList.add('attivo');
  }

  if (bottoneMenu && menu && overlay) {
    // Al click sul bottone apre/chiude
    bottoneMenu.addEventListener('click', function(e) {
      e.stopPropagation();
      if (menu.classList.contains('attivo')) {
        chiudiMenu();
      } else {
        apriMenu();
      }
    });

    overlay.addEventListener('click', chiudiMenu);

    linksMenu.forEach(link => {
      link.addEventListener('click', chiudiMenu);
    });
  }
});
