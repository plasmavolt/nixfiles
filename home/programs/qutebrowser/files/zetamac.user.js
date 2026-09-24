// ==UserScript==
// @name        Zetamac rice
// @namespace   qutebrowser
// @match       https://arithmetic.zetamac.com/*
// @match       http://arithmetic.zetamac.com/*
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
    --rice-accent: #@base0D@;
  }

  html,
  body {
    background-color: var(--rice-bg) !important;
    color: var(--rice-fg) !important;
  }

  #welcome,
  #game .banner {
    background-color: var(--rice-bg-alt) !important;
    color: var(--rice-fg) !important;
  }

  #game .banner p,
  dd,
  dt,
  p {
    color: var(--rice-fg) !important;
  }

  a {
    color: var(--rice-accent) !important;
  }

  a:visited {
    color: var(--rice-aqua) !important;
  }

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  legend,
  label,
  strong,
  b {
    color: var(--rice-bright) !important;
  }

  fieldset,
  form,
  table,
  th,
  td,
  div,
  section,
  article {
    border-color: var(--rice-border) !important;
  }

  input,
  select,
  textarea {
    background-color: var(--rice-surface) !important;
    border-color: var(--rice-border) !important;
    color: var(--rice-bright) !important;
  }

  input:focus,
  select:focus,
  textarea:focus {
    border-color: var(--rice-accent) !important;
    outline-color: var(--rice-accent) !important;
  }

  button,
  input[type="button"],
  input[type="submit"],
  input[type="reset"] {
    background-color: var(--rice-accent) !important;
    border-color: var(--rice-accent) !important;
    color: var(--rice-bg) !important;
  }

  th {
    background-color: var(--rice-surface) !important;
    color: var(--rice-bright) !important;
  }

  tr,
  td {
    background-color: transparent !important;
    color: var(--rice-fg) !important;
  }

  #problem,
  .problem,
  .question {
    color: var(--rice-bright) !important;
  }

  #timer,
  .timer,
  #score,
  .score {
    color: var(--rice-yellow) !important;
  }

  .correct,
  #correct {
    color: var(--rice-green) !important;
  }

  .incorrect,
  .wrong,
  #wrong,
  .error {
    color: var(--rice-red) !important;
  }

  ::selection {
    background-color: var(--rice-accent) !important;
    color: var(--rice-bg) !important;
  }
`);
