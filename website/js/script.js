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
  const chiaveCache = 'byteclub-milestone-v1';
  const durataCache = 10 * 60 * 1000;

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

  function leggiCache() {
    try {
      const dati = JSON.parse(localStorage.getItem(chiaveCache));
      return dati && Array.isArray(dati.issues) ? dati : null;
    } catch (error) {
      return null;
    }
  }

  function salvaCache(dati) {
    try {
      localStorage.setItem(chiaveCache, JSON.stringify(dati));
    } catch (error) {
      console.warn('Impossibile salvare i dati della milestone.', error);
    }
  }

  async function scaricaDati(url, issuesUrl, reviewUrl) {
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
    const issues = risposta
      .filter(issue => !issue.pull_request && issue.state_reason !== 'not_planned')
      .map(issue => ({
        numero: issue.number,
        titolo: issue.title,
        url: issue.html_url,
        stato: statoIssue(issue, inRevisione),
      }))
      .sort((left, right) => statiIssue[left.stato].ordine - statiIssue[right.stato].ordine
        || right.numero - left.numero);

    return { ora: Date.now(), milestone: current.title, issues };
  }

  function creaVoceIssue(issue) {
    const stato = issue.stato;
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
    link.href = issue.url;
    link.target = '_blank';
    link.rel = 'noopener noreferrer';
    link.textContent = issue.titolo;

    const testoStato = document.createElement('span');
    testoStato.className = 'sr-only';
    testoStato.textContent = statiIssue[stato].testo;
    link.append(testoStato);

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

  function mostraOraDati(momento) {
    if (!dataAggiornamento) {
      return;
    }
    const data = new Date(momento);
    const ora = document.createElement('time');
    ora.dateTime = data.toISOString();
    ora.textContent = `${data.toLocaleDateString('it-IT')} alle `
      + data.toLocaleTimeString('it-IT', { hour: '2-digit', minute: '2-digit' });
    dataAggiornamento.replaceChildren('Dati aggiornati il ', ora);
  }

  function mostraDati(dati, barra) {
    const conta = stato => dati.issues.filter(issue => issue.stato === stato).length;
    const completate = conta('chiusa');
    const revisione = conta('revisione');
    const aperte = conta('aperta');
    const totale = dati.issues.length;
    const progress = totale ? Math.round((completate / totale) * 100) : 0;

    milestoneName.textContent = dati.milestone;
    milestoneProgress.style.width = `${progress}%`;
    barra.setAttribute('aria-valuenow', String(progress));
    barra.removeAttribute('aria-valuetext');
    milestoneSummary.textContent = [
      `${completate} ${completate === 1 ? 'completata' : 'completate'}`,
      revisione ? `${revisione} in revisione` : null,
      `${aperte} ${aperte === 1 ? 'aperta' : 'aperte'}`,
    ].filter(Boolean).join(' · ');
    mostraIssue(dati.issues);
    mostraOraDati(dati.ora);
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
    const cache = leggiCache();

    if (cache && Date.now() - cache.ora < durataCache) {
      mostraDati(cache, barra);
      return;
    }

    try {
      const dati = await scaricaDati(url, issuesUrl, reviewUrl);
      salvaCache(dati);
      mostraDati(dati, barra);
    } catch (error) {
      console.error('Impossibile aggiornare la milestone GitHub.', error);
      if (cache) {
        mostraDati(cache, barra);
        return;
      }
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
