{ pkgs, config, ... }:
with config.lib.stylix.colors;
{
  xdg.configFile."vesktop/themes/system24.theme.css".source = pkgs.writeText "system24.theme.css" ''
    /* import theme modules */
    @import url('https://refact0r.github.io/system24/src/main.css'); /* main theme css. DO NOT REMOVE */
    @import url('https://refact0r.github.io/system24/src/unrounding.css'); /* gets rid of all rounded corners. remove if you want rounded corners. */

    /* customize things here */
    :root {{
    	--font: 'DM Mono'; /* UI font name. it must be installed on your system. */
    	letter-spacing: -0.05ch; /* decreases letter spacing for better readability. */
    	font-weight: 300; /* UI font weight. */
    	--label-font-weight: 500; /* font weight for panel labels. */
    	--corner-text: 'system24'; /* custom text to display in the corner. only works on windows. */
    	--pad: 16px; /* padding between panels. */
    	--txt-pad: 10px; /* padding inside panels to prevent labels from clipping */
    	--panel-roundness: 0px; /* corner roundness of panels. ONLY WORKS IF unrounding.css IS REMOVED (see above). */

    	/* background colors */
    	--bg-0: oklch(from #${base01} l c h); /* main background color. */
    	--bg-1: oklch(from #${base01} calc(l + 0.04) c h); /* background color for secondary elements like code blocks, embeds, etc. */
    	--bg-2: oklch(from #${base01} calc(l + 0.08) c h); /* color of neutral buttons. */
    	--bg-3: oklch(from #${base01} calc(l + 0.12) c h); /* color of neutral buttons when hovered. */

    	/* state modifiers */
    	--hover: oklch(54% 0 0 / 0.1); /* color of hovered elements. */
    	--active: oklch(54% 0 0 / 0.2); /* color of elements when clicked. */
    	--selected: var(--active); /* color of selected elements. */

    	/* text colors */
    	--txt-dark: var(--bg-0); /* color of dark text on colored backgrounds. */
    	--txt-link: var(--cyan); /* color of links. */
    	--txt-0: oklch(from #${base07} 100% c h); /* color of bright/white text. */
    	--txt-1: oklch(from #${base07} 80% c h); /* main text color. */
    	--txt-2: oklch(from #${base07} 60% c h); /* color of secondary text like channel list. */
    	--txt-3: oklch(from #${base07} 40% c h); /* color of muted text. */

    	/* accent colors */
    	--acc-0: var(--purple); /* main accent color. */
    	--acc-1: var(--purple-1); /* color of accent buttons when hovered. */
    	--acc-2: var(--purple-2); /* color of accent buttons when clicked. */

    	/* borders */
    	--border-width: 2px; /* panel border thickness. */
    	--border-color: var(--bg-3); /* panel border color. */
    	--border-hover-color: var(--acc-0); /* panel border color when hovered. */
    	--border-transition: 0.2s ease; /* panel border transition. */

    	/* status dot colors */
    	--online-dot: var(--green); /* color of online dot. */
    	--dnd-dot: var(--pink); /* color of do not disturb dot. */
    	--idle-dot: var(--yellow); /* color of idle dot. */
    	--streaming-dot: var(--purple); /* color of streaming dot. */

    	/* mention/ping and message colors */
    	--mention-txt: var(--acc-0); /* color of mention text. */
    	--mention-bg: color-mix(in oklch, var(--acc-0), transparent 90%); /* background highlight of mention text. */
    	--mention-overlay: color-mix(in oklch, var(--acc-0), transparent 90%); /* overlay color of messages that mention you. */
    	--mention-hover-overlay: color-mix(in oklch, var(--acc-0), transparent 95%); /* overlay color of messages that mention you when hovered. */
    	--reply-overlay: var(--active); /* overlay color of message you are replying to. */
    	--reply-hover-overlay: var(--hover); /* overlay color of message you are replying to when hovered. */

    	/* color shades */
    	--pink: oklch(from #${base00} l c h);
    	--pink-1: oklch(from var(--pink) calc(l - 0.1) c h);
    	--pink-2: oklch(from var(--pink) calc(l - 0.2) c h);
    	--purple: oklch(from #${base01} l c h);
    	--purple-1: oklch(from var(--purple) calc(l - 0.1) c h);
    	--purple-2: oklch(from var(--purple) calc(l - 0.2) c h);
    	--cyan: oklch(from #${base02} l c h);
    	--yellow: oklch(from #${base03} l c h);
    	--green: oklch(from #${base04} l c h);
    	--green-1: oklch(from var(--green) calc(l - 0.1) c h);
    	--green-2: oklch(from var(--green) calc(l - 0.2) c h);
    }}
  '';
}