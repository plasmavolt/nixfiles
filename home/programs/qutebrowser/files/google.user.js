// ==UserScript==
// @name        Google rice
// @namespace   qutebrowser
// @match       https://www.google.com/*
// @match       https://google.com/*
// @match       https://*.google.com/search*
// @run-at      document-start
// ==/UserScript==

// llm-generated google rice

function riceAddStyle(css) {
  const add = () => {
    const style = document.createElement("style");
    style.id = "rice-google";
    style.textContent = css;
    (document.head || document.documentElement || document.body).appendChild(
      style,
    );
  };

  if (document.head || document.documentElement || document.body) {
    add();
  } else {
    document.addEventListener("DOMContentLoaded", add, { once: true });
  }
}

riceAddStyle(String.raw`
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
    --rice-dim: color-mix(in srgb, var(--rice-fg) 62%, var(--rice-bg));
    --rice-mono: "@mono@", monospace;

    color-scheme: dark !important;
  }

  /*
   * Google's design tokens. Set on every element (not just :root) because
   * Google re-declares them on scoped theme containers (.NMq1me, .AgWCw, ...),
   * which would otherwise shadow an inherited override.
   */
  *,
  *::before,
  *::after {
    /* surfaces */
    --EpFNW: var(--rice-bg) !important;
    --xhUGwc: var(--rice-bg) !important;
    --cIehld: var(--rice-bg) !important;
    --PBxOKe: var(--rice-bg) !important;
    --CwQ7J: var(--rice-bg) !important;
    --ZXiaGf: var(--rice-bg) !important;
    --NoaQW: var(--rice-bg) !important;
    --DEeStf: var(--rice-bg-alt) !important;
    --XKMDxc: var(--rice-bg-alt) !important;
    --YaIeMb: var(--rice-bg-alt) !important;
    --MV2sG: var(--rice-bg-alt) !important;
    --TSWZIb: var(--rice-surface) !important;
    --aYn2S: var(--rice-surface) !important;
    --Ijc2tf: var(--rice-surface) !important;
    --Lm570b: var(--rice-surface) !important;
    --BRLwE: var(--rice-surface) !important;
    --Zia6nf: var(--rice-surface) !important;
    --jwFC2e: var(--rice-surface) !important;
    --KIZPne: var(--rice-surface) !important;

    /* borders / dividers */
    --mXZkqc: var(--rice-surface) !important;
    --gS5jXb: var(--rice-surface) !important;
    --JclFj: var(--rice-surface) !important;
    --Aqn7xd: var(--rice-surface) !important;
    --ONhrGd: var(--rice-surface) !important;
    --Yi4Nb: var(--rice-border) !important;
    --kloG3: var(--rice-border) !important;
    --vZe0jb: var(--rice-border) !important;
    --ZEpPmd: var(--rice-border) !important;
    --QWaaaf: var(--rice-border) !important;
    --nwXobb: var(--rice-border) !important;

    /* text */
    --YLNNHc: var(--rice-fg) !important;
    --jINu6c: var(--rice-fg) !important;
    --VuZXBd: var(--rice-fg) !important;
    --xPpiM: var(--rice-fg) !important;
    --VeLyLc: var(--rice-fg) !important;
    --y01ou: var(--rice-fg) !important;
    --bcxd3b: var(--rice-fg) !important;
    --hwEqod: var(--rice-fg) !important;
    --vWq1if: var(--rice-fg) !important;
    --LMFHUd: var(--rice-fg) !important;
    --CRMNZd: var(--rice-fg) !important;
    --bbQxAb: var(--rice-fg) !important;
    --pEa0Bc: var(--rice-dim) !important;
    --uLz37c: var(--rice-dim) !important;
    --IXoxUe: var(--rice-dim) !important;
    --amnPwe: var(--rice-dim) !important;
    --EoKObe: var(--rice-bright) !important;
    --V9ysqf: var(--rice-bright) !important;
    --Xqboce: var(--rice-bright) !important;
    --d5F9Lb: var(--rice-bg) !important;
    --todMNc: var(--rice-bg) !important;

    /* accents */
    --JKqx2: var(--rice-accent) !important;
    --rrJJUc: var(--rice-accent) !important;
    --ngPXTb: var(--rice-accent) !important;
    --Nsm0ce: var(--rice-accent) !important;
    --lv6yU: var(--rice-accent) !important;
    --TMYS9: var(--rice-accent) !important;
    --fuvksc: var(--rice-accent) !important;
    --p9J9c: var(--rice-accent) !important;
    --Wmwad: var(--rice-accent) !important;
    --gJjJk: var(--rice-accent) !important;
    --MoaHse: var(--rice-accent) !important;
    --TyVYld: var(--rice-accent) !important;
    --izGsqb: var(--rice-accent) !important;
    --Pa8Wlb: var(--rice-accent) !important;
    --vdwxpe: var(--rice-accent) !important;
    --ywz01c: var(--rice-yellow) !important;
    --yTtsEf: var(--rice-green) !important;
    --XPCkhb: var(--rice-green) !important;
    --baJkQc: var(--rice-red) !important;

    /* AI overview / material 3 tokens */
    --m3c1: var(--rice-accent) !important;
    --m3c2: var(--rice-bg-alt) !important;
    --m3c3: var(--rice-bg) !important;
    --m3c5: var(--rice-bg-alt) !important;
    --m3c6: var(--rice-surface) !important;
    --m3c7: var(--rice-surface) !important;
    --m3c9: var(--rice-fg) !important;
    --m3c10: var(--rice-dim) !important;
    --m3c11: var(--rice-fg) !important;
    --m3c12: var(--rice-accent) !important;
    --m3c13: var(--rice-surface) !important;
    --m3c14: var(--rice-fg) !important;
    --m3c15: var(--rice-accent) !important;
    --m3c16: var(--rice-dim) !important;
    --m3c17: var(--rice-surface) !important;
    --m3c18: var(--rice-accent) !important;
    --m3c19: var(--rice-accent) !important;
    --m3c20: var(--rice-accent) !important;
    --m3c21: var(--rice-accent) !important;
    --m3c22: var(--rice-surface) !important;
    --m3c23: var(--rice-accent) !important;

    --gm3-sys-color-background: var(--rice-bg) !important;
    --gm3-sys-color-surface: var(--rice-bg) !important;
    --gm3-sys-color-surface-dim: var(--rice-bg) !important;
    --gm3-sys-color-surface-container-lowest: var(--rice-bg) !important;
    --gm3-sys-color-surface-container-low: var(--rice-bg-alt) !important;
    --gm3-sys-color-surface-container: var(--rice-bg-alt) !important;
    --gm3-sys-color-surface-container-high: var(--rice-surface) !important;
    --gm3-sys-color-surface-container-highest: var(--rice-surface) !important;
    --gm3-sys-color-surface-bright: var(--rice-surface) !important;
    --gm3-sys-color-surface-variant: var(--rice-surface) !important;
    --gm3-sys-color-inverse-surface: var(--rice-fg) !important;
    --gm3-sys-color-inverse-on-surface: var(--rice-bg) !important;
    --gm3-sys-color-inverse-primary: var(--rice-accent) !important;
    --gm3-sys-color-on-background: var(--rice-fg) !important;
    --gm3-sys-color-on-surface: var(--rice-fg) !important;
    --gm3-sys-color-on-surface-variant: var(--rice-dim) !important;
    --gm3-sys-color-outline: var(--rice-border) !important;
    --gm3-sys-color-outline-variant: var(--rice-surface) !important;
    --gm3-sys-color-primary: var(--rice-accent) !important;
    --gm3-sys-color-primary-fixed-dim: var(--rice-accent) !important;
    --gm3-sys-color-on-primary: var(--rice-bg) !important;
    --gm3-sys-color-primary-container: var(--rice-surface) !important;
    --gm3-sys-color-on-primary-container: var(--rice-fg) !important;
    --gm3-sys-color-secondary: var(--rice-aqua) !important;
    --gm3-sys-color-secondary-container: var(--rice-surface) !important;
    --gm3-sys-color-on-secondary-container: var(--rice-fg) !important;
    --gm3-sys-color-tertiary: var(--rice-green) !important;
    --gm3-sys-color-tertiary-container: var(--rice-surface) !important;
    --gm3-sys-color-on-tertiary-container: var(--rice-fg) !important;
    --gm3-sys-color-error: var(--rice-red) !important;
    --gm3-sys-color-surface-tint: transparent !important;
  }

  html,
  body {
    background: var(--rice-bg) !important;
    color: var(--rice-fg) !important;
    scrollbar-color: var(--rice-border) var(--rice-bg) !important;
  }

  body,
  body *:not(svg, svg *, [class*="symbol"], [class*="material-icons"]) {
    font-family: var(--rice-mono) !important;
  }

  ::selection {
    background: var(--rice-accent) !important;
    color: var(--rice-bg) !important;
  }

  /* links */
  a:visited h3,
  a:visited .LC20lb {
    color: var(--rice-aqua) !important;
  }

  mark {
    background: transparent !important;
    color: var(--rice-yellow) !important;
  }

  /* search box */
  .RNNXgb {
    background: var(--rice-bg-alt) !important;
    border: 1px solid var(--rice-border) !important;
    box-shadow: none !important;
  }

  .RNNXgb:hover,
  .RNNXgb:focus-within {
    border-color: var(--rice-accent) !important;
  }

  .RNNXgb * {
    background-color: transparent !important;
    border-color: transparent !important;
    box-shadow: none !important;
  }

  /* suggestion dropdown, continues the focused search box */
  .aajZCb {
    background: var(--rice-bg-alt) !important;
    border-color: var(--rice-accent) !important;
    box-shadow: none !important;
  }

  .UUbT9 {
    background: transparent !important;
    box-shadow: none !important;
  }

  textarea.gLFyf,
  input.gLFyf,
  textarea[name="q"],
  input[name="q"] {
    background: transparent !important;
    color: var(--rice-bright) !important;
    caret-color: var(--rice-accent) !important;
  }

  /* onegoogle bar */
  a.gb_A,
  a[href*="accounts.google.com/ServiceLogin"] {
    background: transparent !important;
    border: 1px solid var(--rice-border) !important;
    color: var(--rice-accent) !important;
    box-shadow: none !important;
  }

  a.gb_A:hover,
  a[href*="accounts.google.com/ServiceLogin"]:hover {
    border-color: var(--rice-accent) !important;
  }

  /*
   * "Show more" fades over collapsed AI overviews, answers and panels.
   * Some hardcode #22242a instead of using --xhUGwc, so pin them all here
   * rather than waiting for the repaint pass below.
   */
  .RDmXvc {
    background-image: linear-gradient(
      transparent 0,
      color-mix(in srgb, var(--rice-bg) 90%, transparent) 52px,
      var(--rice-bg) 80px
    ) !important;
  }

  .b0Zsmc,
  .lKiHcd::after,
  .OKWFbd {
    background-image: linear-gradient(to bottom, transparent, var(--rice-bg)) !important;
  }

  .Zze5V {
    background-image: linear-gradient(to bottom, transparent, var(--rice-bg) 30px, var(--rice-bg)) !important;
  }

  .GTl0ce::before {
    background-image: linear-gradient(
      to top,
      color-mix(in srgb, var(--rice-bg) 93%, transparent) 0,
      transparent 100%
    ) !important;
  }

  /* fake caret in the AI follow-up box */
  .CEpIFc::after {
    box-shadow: inset 2px 0 0 0 var(--rice-accent) !important;
  }

  /* AI "thinking" glows and rainbow borders */
  .UEnp2c,
  .tgPjse,
  .aSjwGd,
  .k6kT9d::before {
    background: conic-gradient(
      var(--rice-accent),
      var(--rice-aqua),
      var(--rice-green),
      var(--rice-yellow),
      var(--rice-accent)
    ) !important;
  }

  .HECelc,
  .wrqyud {
    background: conic-gradient(from 100deg, transparent 0, var(--rice-accent) 25%, transparent 50%) !important;
  }

  /* drop google's drop shadows */
  [style*="box-shadow"],
  .sbfc,
  .minidiv .sfbg {
    box-shadow: none !important;
  }
`);

/*
 * Not everything goes through the tokens above: some colours are hardcoded in
 * Google's stylesheets, inline styles or pseudo-elements, and some pages (the
 * homepage, the suggestion dropdown) are only ever served with the light
 * theme. Walk the DOM and repaint any remaining neutral grey onto the palette.
 */
(() => {
  const parse = (s) => {
    const m =
      s &&
      s.match(
        /rgba?\(([\d.]+)[,\s]+([\d.]+)[,\s]+([\d.]+)(?:[,\s/]+([\d.]+))?\)/,
      );
    return m ? [+m[1], +m[2], +m[3], m[4] === undefined ? 1 : +m[4]] : null;
  };
  const lum = (c) => Math.max(c[0], c[1], c[2]);
  // greys, including google's blue-tinted dark slates (#394457, #3a3f50, ...)
  const isNeutral = (c) => {
    const spread = lum(c) - Math.min(c[0], c[1], c[2]);
    return spread <= 24 || (c[2] === lum(c) && spread <= 40 && lum(c) <= 0x70);
  };
  const key = (c) => `${c[0]},${c[1]},${c[2]}`;
  const paint = (v, a) =>
    a < 1
      ? `color-mix(in srgb, var(${v}) ${Math.round(a * 100)}%, transparent)`
      : `var(${v})`;

  // rgb values of the palette, so we never touch what we've already set
  const ours = new Set();
  const seed = () => {
    const probe = document.createElement("div");
    document.documentElement.appendChild(probe);
    for (const v of [
      "bg",
      "bg-alt",
      "surface",
      "border",
      "muted",
      "fg",
      "bright",
      "dim",
      "accent",
    ]) {
      probe.style.color = `var(--rice-${v})`;
      const c = parse(getComputedStyle(probe).color);
      if (c) ours.add(key(c));
    }
    probe.remove();
  };
  const foreign = (c) => c && c[3] > 0 && !ours.has(key(c)) && isNeutral(c);

  // dark greys come from the dark theme, light greys from the light theme
  const bgToken = (c) => {
    const l = lum(c);
    if (l <= 0x24) return "--rice-bg";
    if (l <= 0x34) return "--rice-bg-alt";
    if (l <= 0x56) return "--rice-surface";
    if (l <= 0x70) return "--rice-border";
    if (l >= 0xfe) return "--rice-bg";
    if (l >= 0xf0) return "--rice-bg-alt";
    if (l >= 0xc0) return "--rice-surface";
    return null;
  };

  // dark text only exists in the light theme
  const fgToken = (c) => {
    const l = lum(c);
    if (l <= 0x50) return "--rice-fg";
    if (l <= 0x80) return "--rice-dim";
    return null;
  };

  // returns the overrides needed for one computed style
  const overrides = (cs, svg) => {
    const out = {};

    let c = parse(cs.backgroundColor);
    if (foreign(c) && bgToken(c))
      out["background-color"] = paint(bgToken(c), c[3]);

    const img = cs.backgroundImage;
    if (img.includes("gradient") && !img.includes("url(")) {
      // solid grey-to-grey shading (e.g. the shopping header): flatten it
      const stops = (img.match(/rgba?\([^)]*\)/g) || []).map(parse);
      if (
        !img.includes("color(") &&
        stops.length &&
        stops.every((c) => c && c[3] === 1 && isNeutral(c))
      ) {
        out["background-image"] = "none";
        return finish(out, cs, svg);
      }
      let changed = false;
      const g = img.replace(/rgba?\([^)]*\)/g, (m) => {
        const c = parse(m);
        if (!foreign(c) || !bgToken(c)) return m;
        changed = true;
        return paint("--rice-bg", c[3]);
      });
      if (changed) out["background-image"] = g;
    }

    return finish(out, cs, svg);
  };

  // text, icon and border colours
  const finish = (out, cs, svg) => {
    let c = parse(cs.color);
    if (foreign(c) && fgToken(c)) out.color = paint(fgToken(c), c[3]);

    if (svg) {
      c = parse(cs.fill);
      if (foreign(c) && lum(c) <= 0x80) out.fill = "var(--rice-dim)";
    }

    for (const side of ["top", "right", "bottom", "left"]) {
      if (!parseFloat(cs.getPropertyValue(`border-${side}-width`))) continue;
      c = parse(cs.getPropertyValue(`border-${side}-color`));
      if (!foreign(c)) continue;
      const l = lum(c);
      if (l >= 0xc0 || (l >= 0x30 && l <= 0x60))
        out[`border-${side}-color`] = "var(--rice-surface)";
    }

    return out;
  };

  // pseudo-elements can't take inline styles, so give them a rule each
  let sheet = null;
  let nextId = 0;
  const pseudoRule = (el, pseudo, props) => {
    if (!el.dataset.rice) el.dataset.rice = String(nextId++);
    const body = Object.entries(props)
      .map(([k, v]) => `${k}: ${v} !important;`)
      .join(" ");
    sheet.insertRule(
      `[data-rice="${el.dataset.rice}"]${pseudo} { ${body} }`,
      sheet.cssRules.length,
    );
  };

  const SKIP = new Set([
    "IMG",
    "VIDEO",
    "CANVAS",
    "IFRAME",
    "PICTURE",
    "SOURCE",
    "SCRIPT",
    "STYLE",
    "LINK",
    "META",
    "NOSCRIPT",
    "BR",
  ]);
  const visit = (el) => {
    if (el.nodeType !== 1 || SKIP.has(el.tagName)) return;
    const cs = getComputedStyle(el);
    if (cs.display === "none") return;

    for (const [k, v] of Object.entries(
      overrides(cs, el instanceof SVGElement),
    )) {
      if (el.style.getPropertyValue(k) !== v)
        el.style.setProperty(k, v, "important");
    }

    for (const pseudo of ["::before", "::after"]) {
      const ps = getComputedStyle(el, pseudo);
      // skip hover/press state layers, they rely on opacity
      if (ps.content === "none" || ps.content === "normal" || +ps.opacity < 1)
        continue;
      const props = overrides(ps, false);
      if (Object.keys(props).length) pseudoRule(el, pseudo, props);
    }
  };

  const scan = (root) => {
    visit(root);
    for (const el of root.querySelectorAll("*")) visit(el);
  };

  let pending = new Set();
  let scheduled = false;
  const flush = () => {
    scheduled = false;
    const roots = pending;
    pending = new Set();
    for (const r of roots) if (r.isConnected) scan(r);
  };
  const queue = (n) => {
    if (n.nodeType !== 1) return;
    pending.add(n);
    if (!scheduled) {
      scheduled = true;
      requestAnimationFrame(flush);
    }
  };

  const start = () => {
    seed();
    const style = document.createElement("style");
    style.id = "rice-google-pseudo";
    document.head.appendChild(style);
    sheet = style.sheet;

    scan(document.body);
    new MutationObserver((muts) => {
      for (const m of muts) {
        if (m.type === "childList") m.addedNodes.forEach(queue);
        else queue(m.target);
      }
    }).observe(document.body, {
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: [
        "class",
        "style",
        "hidden",
        "aria-expanded",
        "aria-selected",
      ],
    });
    // google streams in stylesheets after the markup they style (the AI
    // overview in particular), so restyled elements need another pass
    let rescan = 0;
    const rescanSoon = () => {
      clearTimeout(rescan);
      rescan = setTimeout(() => scan(document.body), 150);
    };
    new MutationObserver((muts) => {
      for (const m of muts) {
        for (const n of m.addedNodes) {
          if (
            n.tagName === "STYLE" &&
            n.id !== "rice-google" &&
            n.id !== "rice-google-pseudo"
          )
            rescanSoon();
          if (n.tagName === "LINK")
            n.addEventListener("load", rescanSoon, { once: true });
        }
      }
    }).observe(document.documentElement, { childList: true, subtree: true });
    addEventListener("load", rescanSoon, { once: true });
  };

  if (document.body) start();
  else document.addEventListener("DOMContentLoaded", start, { once: true });
})();
