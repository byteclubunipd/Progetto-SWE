document.addEventListener("DOMContentLoaded", function() {
  const bottoneMenu = document.getElementById('bottoneMenu');
  const menu = document.getElementById('menu');
  const linksMenu = document.querySelectorAll('#menu a');
  const temaToggle = document.getElementById('tema-toggle');
  const projectMeta = document.querySelector('.project-meta');
  const milestoneName = document.getElementById('milestone-name');
  const milestoneProgress = document.getElementById('milestone-progress');
  const milestoneSummary = document.getElementById('milestone-summary');
  const desktopQuery = window.matchMedia('(min-width: 880px)');

  async function aggiornaMilestone() {
    if (!projectMeta || !milestoneName || !milestoneProgress || !milestoneSummary) {
      return;
    }

    const url = projectMeta.dataset.githubMilestonesUrl;
    if (!url) {
      return;
    }

    try {
      const response = await fetch(url, {
        headers: { Accept: 'application/vnd.github+json' }
      });
      if (!response.ok) {
        throw new Error(`GitHub API: ${response.status}`);
      }
      const milestones = await response.json();
      const current = milestones
        .filter(milestone => milestone.state === 'open')
        .sort((left, right) => right.number - left.number)[0]
        || milestones.sort((left, right) => right.number - left.number)[0];

      if (!current) {
        throw new Error('Nessuna milestone disponibile');
      }

      const total = current.open_issues + current.closed_issues;
      const progress = total ? Math.round((current.closed_issues / total) * 100) : 0;
      milestoneName.textContent = current.title;
      milestoneProgress.style.width = `${progress}%`;
      milestoneProgress.parentElement.setAttribute('aria-valuenow', String(progress));
      milestoneSummary.textContent =
        `${current.closed_issues} completate · ${current.open_issues} aperte`;
    } catch (error) {
      console.error('Impossibile aggiornare la milestone GitHub.', error);
    }
  }

  function aggiornaTema(theme) {
    const dark = theme === 'dark';
    document.documentElement.dataset.theme = dark ? 'dark' : 'light';
    temaToggle.setAttribute('aria-pressed', String(dark));
    temaToggle.querySelector('.tema-etichetta').textContent =
      dark ? 'Tema: Scuro' : 'Tema: Chiaro';
    temaToggle.setAttribute(
      'aria-label',
      dark ? 'Attiva modalità chiara' : 'Attiva modalità scura'
    );
  }

  function aggiornaVisibilitaMenu() {
    const menuVisibile = desktopQuery.matches || menu.classList.contains('attivo');
    menu.setAttribute('aria-hidden', String(!menuVisibile));
    linksMenu.forEach(link => {
      link.tabIndex = menuVisibile ? 0 : -1;
    });
  }

  function chiudiMenu() {
    menu.classList.remove('attivo');
    bottoneMenu.setAttribute('aria-expanded', 'false');
    bottoneMenu.setAttribute('aria-label', 'Apri menu di navigazione');
    aggiornaVisibilitaMenu();
    bottoneMenu.focus();
  }

  function apriMenu() {
    menu.classList.add('attivo');
    bottoneMenu.setAttribute('aria-expanded', 'true');
    bottoneMenu.setAttribute('aria-label', 'Chiudi menu di navigazione');
    aggiornaVisibilitaMenu();
    linksMenu[0]?.focus();
  }

  if (temaToggle) {
    const savedTheme = localStorage.getItem('byteclub-theme');
    const preferredTheme = window.matchMedia('(prefers-color-scheme: dark)').matches
      ? 'dark'
      : 'light';
    aggiornaTema(savedTheme || preferredTheme);
    temaToggle.addEventListener('click', function() {
      const nextTheme = document.documentElement.dataset.theme === 'dark'
        ? 'light'
        : 'dark';
      aggiornaTema(nextTheme);
      localStorage.setItem('byteclub-theme', nextTheme);
    });
  }

  aggiornaMilestone();

  if (bottoneMenu && menu) {
    aggiornaVisibilitaMenu();

    // Al click sul bottone apre/chiude
    bottoneMenu.addEventListener('click', function(e) {
      e.stopPropagation();
      if (menu.classList.contains('attivo')) {
        chiudiMenu();
      } else {
        apriMenu();
      }
    });

    linksMenu.forEach(link => {
      link.addEventListener('click', chiudiMenu);
    });

    document.addEventListener('keydown', function(event) {
      if (event.key === 'Escape' && menu.classList.contains('attivo')) {
        chiudiMenu();
      }
    });

    desktopQuery.addEventListener('change', function() {
      menu.classList.remove('attivo');
      bottoneMenu.setAttribute('aria-expanded', 'false');
      bottoneMenu.setAttribute('aria-label', 'Apri menu di navigazione');
      aggiornaVisibilitaMenu();
    });
  }
});
