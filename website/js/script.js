document.addEventListener("DOMContentLoaded", function() {
  const bottoneMenu = document.getElementById('bottoneMenu');
  const menu = document.getElementById('menu');
  const linksMenu = document.querySelectorAll('#menu a');
  const temaToggle = document.getElementById('tema-toggle');
  const projectMeta = document.querySelector('.project-meta');
  const milestoneName = document.getElementById('milestone-name');
  const milestoneProgress = document.getElementById('milestone-progress');
  const milestoneSummary = document.getElementById('milestone-summary');
  const milestoneIssues = document.getElementById('milestone-issues');
  const desktopQuery = window.matchMedia('(min-width: 880px)');

  async function leggiDatiGitHub(url) {
    const response = await fetch(url, {
      headers: { Accept: 'application/vnd.github+json' }
    });
    if (!response.ok) {
      throw new Error(`GitHub API: ${response.status}`);
    }
    return response.json();
  }

  function creaVoceIssue(issue) {
    const aperta = issue.state === 'open';
    const voce = document.createElement('li');
    voce.className = aperta ? 'issue-aperta' : 'issue-chiusa';

    const icona = document.createElement('span');
    icona.className = 'issue-icona';
    icona.setAttribute('aria-hidden', 'true');
    icona.textContent = aperta ? '○' : '✓';

    const link = document.createElement('a');
    link.href = issue.html_url;
    link.target = '_blank';
    link.rel = 'noopener noreferrer';
    link.textContent = issue.title;

    const stato = document.createElement('span');
    stato.className = 'sr-only';
    stato.textContent = aperta ? ' (aperta)' : ' (chiusa)';
    link.append(stato);

    voce.append(icona, link);
    return voce;
  }

  function mostraIssue(issues) {
    const voci = issues.map(creaVoceIssue);
    if (!voci.length) {
      const voceVuota = document.createElement('li');
      voceVuota.className = 'issue-vuota';
      voceVuota.textContent = 'Nessuna issue in questa milestone';
      voci.push(voceVuota);
    }
    milestoneIssues.replaceChildren(...voci);
    milestoneIssues.hidden = false;
  }

  async function aggiornaMilestone() {
    if (!projectMeta || !milestoneName || !milestoneProgress || !milestoneSummary
        || !milestoneIssues) {
      return;
    }

    const url = projectMeta.dataset.githubMilestonesUrl;
    const issuesUrl = projectMeta.dataset.githubIssuesUrl;
    if (!url || !issuesUrl) {
      return;
    }

    const barra = milestoneProgress.parentElement;

    try {
      const milestones = await leggiDatiGitHub(url);
      const current = milestones
        .filter(milestone => milestone.state === 'open')
        .sort((left, right) => left.number - right.number)[0]
        || milestones.sort((left, right) => right.number - left.number)[0];

      if (!current) {
        throw new Error('Nessuna milestone disponibile');
      }

      const risposta = await leggiDatiGitHub(
        `${issuesUrl}?milestone=${current.number}&state=all&per_page=100`
      );
      const issues = risposta
        .filter(issue => !issue.pull_request && issue.state_reason !== 'not_planned')
        .sort((left, right) =>
          (left.state === 'open' ? 0 : 1) - (right.state === 'open' ? 0 : 1)
          || right.number - left.number);

      const aperte = issues.filter(issue => issue.state === 'open').length;
      const completate = issues.length - aperte;
      const progress = issues.length ? Math.round((completate / issues.length) * 100) : 0;

      milestoneName.textContent = current.title;
      milestoneProgress.style.width = `${progress}%`;
      barra.setAttribute('aria-valuenow', String(progress));
      barra.removeAttribute('aria-valuetext');
      milestoneSummary.textContent =
        `${completate} ${completate === 1 ? 'completata' : 'completate'} · `
        + `${aperte} ${aperte === 1 ? 'aperta' : 'aperte'}`;
      mostraIssue(issues);
    } catch (error) {
      console.error('Impossibile aggiornare la milestone GitHub.', error);
      milestoneName.textContent = 'Non disponibile';
      barra.hidden = true;
      milestoneIssues.hidden = true;
      milestoneSummary.textContent = 'Dati non raggiungibili al momento';
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
