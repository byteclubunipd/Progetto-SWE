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
  const dataAggiornamento = document.getElementById('data-aggiornamento');
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

  const statiIssue = {
    revisione: { ordine: 0, simbolo: null, testo: ' (in revisione)' },
    aperta: { ordine: 1, simbolo: '○', testo: ' (aperta)' },
    chiusa: { ordine: 2, simbolo: '✓', testo: ' (chiusa)' },
  };

  // Da ricordarsi che una issue aperta è in revisione se è collegata a una pull request.
  async function leggiIssueInRevisione(url) {
    if (!url) {
      return new Set();
    }
    try {
      const risultato = await leggiDatiGitHub(url);
      return new Set(risultato.items.map(issue => issue.number));
    } catch (error) {
      console.warn('Impossibile leggere le issue in revisione.', error);
      return new Set();
    }
  }

  function statoIssue(issue, inRevisione) {
    if (issue.state !== 'open') {
      return 'chiusa';
    }
    return inRevisione.has(issue.number) ? 'revisione' : 'aperta';
  }

  function creaIconaLente() {
    const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svg.setAttribute('viewBox', '0 0 16 16');
    svg.setAttribute('focusable', 'false');
    const cerchio = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
    cerchio.setAttribute('cx', '6.5');
    cerchio.setAttribute('cy', '6.5');
    cerchio.setAttribute('r', '4.5');
    const manico = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    manico.setAttribute('d', 'M10 10l4 4');
    svg.append(cerchio, manico);
    return svg;
  }

  function creaVoceIssue(issue, inRevisione) {
    const stato = statoIssue(issue, inRevisione);
    const voce = document.createElement('li');
    voce.className = `issue-${stato}`;

    const icona = document.createElement('span');
    icona.className = 'issue-icona';
    icona.setAttribute('aria-hidden', 'true');
    if (stato === 'revisione') {
      icona.append(creaIconaLente());
    } else {
      icona.textContent = statiIssue[stato].simbolo;
    }

    const link = document.createElement('a');
    link.href = issue.html_url;
    link.target = '_blank';
    link.rel = 'noopener noreferrer';
    link.textContent = issue.title;

    const testoStato = document.createElement('span');
    testoStato.className = 'sr-only';
    testoStato.textContent = statiIssue[stato].testo;
    link.append(testoStato);

    voce.append(icona, link);
    return voce;
  }

  function mostraIssue(issues, inRevisione) {
    const voci = issues.map(issue => creaVoceIssue(issue, inRevisione));
    if (!voci.length) {
      const voceVuota = document.createElement('li');
      voceVuota.className = 'issue-vuota';
      voceVuota.textContent = 'Nessuna issue in questa milestone';
      voci.push(voceVuota);
    }
    milestoneIssues.replaceChildren(...voci);
    milestoneIssues.hidden = false;
  }

  // Sostituisce la data della build con il momento in cui i dati sono stati letti.
  function mostraOraDati() {
    if (!dataAggiornamento) {
      return;
    }
    const adesso = new Date();
    const ora = document.createElement('time');
    ora.dateTime = adesso.toISOString();
    ora.textContent = `${adesso.toLocaleDateString('it-IT')} alle `
      + adesso.toLocaleTimeString('it-IT', { hour: '2-digit', minute: '2-digit' });
    dataAggiornamento.replaceChildren('Dati aggiornati il ', ora);
  }

  async function aggiornaMilestone() {
    if (!projectMeta || !milestoneName || !milestoneProgress || !milestoneSummary
        || !milestoneIssues) {
      return;
    }

    const url = projectMeta.dataset.githubMilestonesUrl;
    const issuesUrl = projectMeta.dataset.githubIssuesUrl;
    const reviewUrl = projectMeta.dataset.githubReviewUrl;
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

      const [risposta, inRevisione] = await Promise.all([
        leggiDatiGitHub(`${issuesUrl}?milestone=${current.number}&state=all&per_page=100`),
        leggiIssueInRevisione(reviewUrl),
      ]);
      const ordine = issue => statiIssue[statoIssue(issue, inRevisione)].ordine;
      const issues = risposta
        .filter(issue => !issue.pull_request && issue.state_reason !== 'not_planned')
        .sort((left, right) => ordine(left) - ordine(right) || right.number - left.number);

      const conta = stato => issues.filter(issue => statoIssue(issue, inRevisione) === stato).length;
      const completate = conta('chiusa');
      const revisione = conta('revisione');
      const aperte = conta('aperta');
      const progress = issues.length ? Math.round((completate / issues.length) * 100) : 0;

      milestoneName.textContent = current.title;
      milestoneProgress.style.width = `${progress}%`;
      barra.setAttribute('aria-valuenow', String(progress));
      barra.removeAttribute('aria-valuetext');
      milestoneSummary.textContent = [
        `${completate} ${completate === 1 ? 'completata' : 'completate'}`,
        revisione ? `${revisione} in revisione` : null,
        `${aperte} ${aperte === 1 ? 'aperta' : 'aperte'}`,
      ].filter(Boolean).join(' · ');
      mostraIssue(issues, inRevisione);
      mostraOraDati();
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
