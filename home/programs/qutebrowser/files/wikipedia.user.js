// ==UserScript==
// @name        Wikipedia rice
// @namespace   qutebrowser
// @match       https://wikipedia.org/*
// @match       https://*.wikipedia.org/*
// @run-at      document-end
// ==/UserScript==

GM_addStyle(String.raw`
  :root {
    --rice-bg: #@base00@;
    --rice-bg-alt: #@base01@;
    --rice-surface: #@base02@;
    --rice-border: #@base03@;
    --rice-muted: #@base04@;
    --rice-fg: #@base05@;
    --rice-bright: #@base06@;
    --rice-red: #@base08@;
    --rice-yellow: #@base0A@;
    --rice-green: #@base0B@;
    --rice-aqua: #@base0C@;
    --rice-blue: #@base0D@;
    --rice-mono: "@mono@", monospace;

    color-scheme: dark !important;
    --background-color-base: var(--rice-bg) !important;
    --background-color-neutral-subtle: var(--rice-bg-alt) !important;
    --background-color-interactive-subtle: var(--rice-surface) !important;
    --background-color-progressive-subtle: var(--rice-bg-alt) !important;
    --background-color-destructive-subtle: var(--rice-bg-alt) !important;
    --border-color-base: var(--rice-border) !important;
    --border-color-muted: var(--rice-border) !important;
    --color-base: var(--rice-fg) !important;
    --color-subtle: var(--rice-muted) !important;
    --color-emphasized: var(--rice-bright) !important;
    --color-progressive: var(--rice-aqua) !important;
    --color-visited: var(--rice-blue) !important;
  }

  html,
  body,
  .mw-page-container,
  .mw-page-container-inner,
  .vector-header-container,
  .vector-sticky-header,
  .vector-pinned-container,
  .vector-dropdown-content,
  .mw-body {
    background: var(--rice-bg) !important;
    color: var(--rice-fg) !important;
  }

  body,
  button,
  input,
  select,
  textarea,
  .mw-body-content,
  .mw-parser-output {
    font-family: var(--rice-mono) !important;
  }

  body {
    scrollbar-color: var(--rice-border) var(--rice-bg) !important;
  }

  .mw-page-container {
    max-width: 112rem !important;
    border-color: var(--rice-border) !important;
  }

  .mw-body {
    border-color: var(--rice-border) !important;
  }

  .mw-body-content {
    font-size: 0.94rem !important;
    line-height: 1.75 !important;
  }

  .mw-body-content p {
    max-width: 78ch;
  }

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  .mw-page-title-main {
    color: var(--rice-bright) !important;
    font-family: var(--rice-mono) !important;
    font-weight: 600 !important;
    letter-spacing: -0.035em;
  }

  h1,
  h2 {
    border-color: var(--rice-border) !important;
  }

  h1::before,
  .mw-heading1 > h1::before {
    color: var(--rice-green);
    content: "# ";
  }

  .mw-heading2 > h2::before,
  .mw-parser-output > h2::before {
    color: var(--rice-border);
    content: "## ";
  }

  a,
  .mw-parser-output a.external {
    color: var(--rice-aqua) !important;
    text-decoration-color: color-mix(in srgb, var(--rice-aqua) 35%, transparent) !important;
    text-underline-offset: 0.18em;
  }

  a:visited {
    color: var(--rice-blue) !important;
  }

  a:hover,
  a:focus {
    color: var(--rice-green) !important;
    text-decoration-color: currentColor !important;
  }

  .vector-toc-link,
  .vector-menu-content-list a,
  .mw-portlet a {
    font-size: 0.78rem !important;
  }

  .vector-toc-link:hover,
  .vector-toc-link-active,
  .vector-pinnable-header-toggle-button:hover {
    background: var(--rice-bg-alt) !important;
  }

  .vector-toc-list-item-active > .vector-toc-link {
    border-left: 2px solid var(--rice-green) !important;
    color: var(--rice-green) !important;
    padding-left: 0.55rem !important;
  }

  .infobox,
  .sidebar,
  .wikitable,
  .navbox,
  .metadata,
  .ambox,
  .ombox,
  .tmbox,
  .cmbox,
  .fmbox,
  .imbox,
  .messagebox,
  .catlinks,
  .thumbinner,
  .toc,
  pre,
  code,
  blockquote {
    background: var(--rice-bg-alt) !important;
    border-color: var(--rice-border) !important;
    color: var(--rice-fg) !important;
    box-shadow: none !important;
  }

  .infobox,
  .sidebar,
  .wikitable,
  .navbox,
  .thumbinner,
  .catlinks,
  pre,
  blockquote {
    border-radius: 2px !important;
  }

  .infobox-above,
  .infobox-title,
  .infobox-header,
  .sidebar-title,
  .sidebar-heading,
  .navbox-title,
  .navbox-group,
  .wikitable > tr > th,
  .wikitable > * > tr > th {
    background: var(--rice-surface) !important;
    color: var(--rice-bright) !important;
  }

  td,
  th,
  tr,
  .navbox-list,
  .navbox-even,
  .navbox-odd {
    border-color: var(--rice-border) !important;
  }

  code,
  pre,
  kbd,
  samp {
    font-family: var(--rice-mono) !important;
  }

  code,
  kbd {
    color: var(--rice-yellow) !important;
  }

  blockquote {
    border-left: 3px solid var(--rice-green) !important;
    color: var(--rice-muted) !important;
    padding: 0.75rem 1rem !important;
  }

  hr {
    border-color: var(--rice-border) !important;
  }

  input,
  select,
  textarea,
  button,
  .cdx-button,
  .mw-ui-button {
    background-color: var(--rice-bg-alt) !important;
    border-color: var(--rice-border) !important;
    color: var(--rice-fg) !important;
    box-shadow: none !important;
  }

  input:focus,
  select:focus,
  textarea:focus,
  button:focus-visible,
  .cdx-button:focus-visible {
    border-color: var(--rice-green) !important;
    box-shadow: 0 0 0 1px var(--rice-green) !important;
    outline: none !important;
  }

  .cdx-text-input__input:enabled,
  .vector-search-box-input {
    background-color: var(--rice-bg-alt) !important;
    color: var(--rice-fg) !important;
  }

  .mw-logo-wordmark,
  .mw-logo-tagline,
  .vector-icon,
  img.mwe-math-fallback-image-inline,
  img.mwe-math-fallback-image-display {
    filter: invert(0.82) sepia(0.08) !important;
  }

  .thumbimage,
  .mw-file-element {
    border-color: var(--rice-border) !important;
  }

  ::selection {
    background: var(--rice-green) !important;
    color: var(--rice-bg) !important;
  }

  @media (max-width: 720px) {
    .mw-body-content {
      font-size: 0.9rem !important;
      line-height: 1.65 !important;
    }
  }
`);
