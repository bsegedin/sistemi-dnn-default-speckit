<!--
Sync Impact Report
- Version change: 1.8.0 → 1.9.0
- Modified principles: None
- Added standards: Technology Standards & Constraints → Navigation Menus (Mobile Offcanvas with DDR Razor; hide desktop on mobile)
- Removed sections: None
- Change summary: Require Bootstrap Offcanvas for mobile navigation; desktop menu hidden on mobile. Offcanvas content must be rendered by a DDR Menu using Razor templates and should be wired via `_inc-theme-body.ascx`, with accessibility (focus trap, ARIA) respected.
- Templates requiring updates:
	⚠ .specify/templates/plan-template.md (add Mobile Offcanvas DDR Menu gate; update footer to v1.9.0)
	✅ .specify/templates/spec-template.md (reviewed)
	✅ .specify/templates/tasks-template.md (reviewed)
	✅ .specify/templates/agent-file-template.md (reviewed)
- Follow-up TODOs:
	• TODO(SUPPORTED_DNN_VERSIONS): Confirm minimum DNN CE version and site .NET runtime this theme must support.
-->

# DNN CMS CE Theme Development Constitution

## Core Principles

### I. Figma Is the Single Source of Truth for Design
All theme UI decisions MUST originate in Figma and be reflected as reusable tokens and components.
- Figma library and file naming: `_Development / SpecKit Playground` with pages: Desktop layout, Mobile layout.
- Coverage: Both Desktop layout and Mobile layout pages are authoritative; implementation MUST reflect both and maintain parity.
- Design tokens (colors, typography, spacing, radii, shadows) MUST exist as Figma variables and map 1:1 to CSS custom properties
	under `:root` (e.g., `--color-primary-500`). Tokens MAY be namespaced by theme.
- Components MUST be auto‑layout based, responsive, and include necessary states (hover/focus/active/disabled).
- Exported assets (SVG/PNG) MUST be derived from Figma, named by token/component, and committed under the theme assets folder.
Rationale: A single, inspectable design source prevents drift and accelerates consistent implementation.

### II. DNN Theme Structure and Packaging Are Stable Contracts
The theme MUST follow DNN CE skin/container conventions and ship as versioned install packages.
- Structure: Skins in `Portals/_default/Skins/Base/`, Containers in `Portals/_default/Containers/Base/` (or project‑specific portal path).
- Markup: Use DNN HTML/ASCX skinning conventions and tokens; keep semantic HTML and minimal custom server controls.
- Assets: Bundle CSS/JS/images per theme; register via Client Resource Management; provide minified production assets.
- Packages: Produce installable ZIPs for Skins and Containers per DNN packaging guidelines, with manifest and version.
Rationale: Respecting DNN conventions ensures predictable installs, upgrades, and interoperability.

### III. Accessibility and Performance Are Non‑Negotiable
The theme MUST meet WCAG 2.1 AA and defined performance budgets.
- A11y: Semantic landmarks, keyboard navigation, visible focus, ARIA where required, color contrast ≥ 4.5:1, motion‑safe patterns.
- Performance budgets (uncompressed, per page at first contentful paint): CSS ≤ 200 KB, JS ≤ 100 KB; images optimized with modern formats; lazy load non‑critical media.
- Responsiveness: Fluid layout with tested breakpoints (xs, sm, md, lg, xl) and device-agnostic sizing.
Rationale: Accessibility and speed directly impact usability, SEO, and compliance.

### IV. Test‑First Visual and Contract Validation
Before merging implementation, establish and validate visual and contract baselines.
- Visual: Maintain baseline screenshots for key templates (Home, Content, Listing, Article, Search) and approve deltas with an explicit rationale.
- Contracts: Validate presence and values of published CSS variables (design tokens) and required DOM landmarks/ids/classes.
- Smoke flows: Navigation, search, pagination, and form interactions MUST be exercised on each release candidate.
Rationale: Lightweight tests prevent regressions across releases without over‑engineering.

### V. Versioning, Deprecation, and Simplicity
Use Semantic Versioning for the theme and avoid unnecessary complexity.
- SemVer: MAJOR for breaking markup/tokens, MINOR for new components/tokens, PATCH for fixes/clarifications.
- Deprecations: Announce in one MINOR before removal; provide a migration note for affected markup/classes/tokens.
- Simplicity: Prefer HTML/CSS and minimal vanilla JS; avoid heavy frameworks unless justified by a clear user need.
Rationale: Predictable change management and lean implementation reduce maintenance cost.

### VI. Starter Kit Is the Canonical Starting Point
All new themes MUST be created using this repository as the Starter Kit starting point.
- Bootstrap: Clone/copy this Starter Kit, keep the structure (skins/containers, build pipeline, scripts) and update theme identifiers.
- Figma attachment: Attach the Figma file (Desktop and Mobile pages) as the design source and implement strictly against it.
- No ad-hoc skeletons: Do NOT scaffold themes outside of this Starter Kit; deviations require explicit maintainer approval.
Rationale: A single, maintained base prevents drift, enforces tooling/pipeline standards, and accelerates delivery.

## Technology Standards & Constraints

- Platform: DNN Community Edition 9.13.x (Web Forms skinning). Theme need to support only latest DNN from 9.13.x and later.
- Skinning: Use HTML or ASCX skinning consistently; document chosen approach per theme; keep containers minimal.
- Theme Architecture: All wrappers (skins) MUST include the shared body control at `Portals/_default/Skins/Base/controls/_inc-theme-body.ascx`.
	Wrappers pass configuration via control attributes (e.g., `LayoutVariant`, `PaneLayout`, `HeaderStyle`, `ShowBreadcrumb`).
	The body control hosts all DNN panes and adapts visibility/markup and resource registration based on those inputs.
- Theme Objects: MUST follow the official DNN Theme Objects documentation; avoid legacy or undocumented objects.
	References:
	- https://docs.dnncommunity.org/content/tutorials/themes/theme-objects/index.html
	- https://github.com/DNNCommunity/DNNDocs/blob/main/content/tutorials/themes/theme-objects/index.md
- Navigation Menus: Figma groups named "Main menu" and "Service menu" MUST be implemented using DNN DDR Menu with Razor templates.
	- Implementation: Use DDR Menu provider and Razor templates per the official guides; do not hard-code menu HTML.
	- Parity: Razor templates MUST reflect both Desktop layout and Mobile layout variants from Figma.
	- References:
		• DDR Menu User Guide: https://www.dnnsoftware.com/wiki/ddrmenu-user-guide
		• DDR Menu Razor Templates: https://www.dnnsoftware.com/wiki/ddrmenu-razor-templates
	- Mobile Offcanvas: On mobile viewports, navigation MUST use Bootstrap Offcanvas. The desktop menu MUST be hidden on mobile. The offcanvas content MUST be a DDR Menu rendered via a Razor template. Offcanvas MUST be keyboard accessible (focus trap, Esc to close) and expose ARIA attributes (`aria-controls`, `aria-labelledby`, `aria-expanded`). `_inc-theme-body.ascx` SHOULD host and wire this behavior.
- Utilities & Helpers: Shared helpers live in `App_Code/BaseTheme/ThemeHelpers.cs` (namespace `BaseTheme`).
	- MAY be used by `_inc-theme-body.ascx` for pane visibility toggles, formatting, composing skin objects, and Client Resource Management.
	- Public helper methods are part of the theme contract: breaking signature/behavior changes REQUIRE a MAJOR version bump; additions are MINOR; internal fixes are PATCH.
	- Helpers MUST be unit‑testable, avoid static global state, and not perform data access. Side effects limited to rendering and resource registration.
- CSS: Author in SCSS (recommended) or CSS; output compiled, vendor‑prefixed CSS; naming: BEM‑style.
- Tokens: Expose Figma tokens as CSS custom properties under `:root` and theme scope.
- Design Integration: Figma MCP (VS Code) MUST be used to access the Figma "Desktop layout" and "Mobile layout" pages
	for inspection/export and token parity checks.
	- Security: Store Figma credentials securely (VS Code Secret Storage or environment variable `FIGMA_TOKEN`).
	- Variance: If MCP cannot be used, document rationale in the PR and demonstrate parity using an alternative workflow.
- Styles & Build Pipeline:
	- Authoring: All styles MUST be authored in SCSS under `Portals/_default/Skins/Base/src/scss/` covering layouts and components.
	- Framework: Bootstrap v5 is MANDATORY. Customizations MUST be applied via SCSS variables/partials, NOT by editing compiled Bootstrap CSS.
	- Build: webpack MUST compile SCSS → CSS. Compiled CSS is a generated artifact and registered via Client Resource Management.
	- Policy: Direct edits to compiled CSS files are FORBIDDEN. All visual changes MUST originate in SCSS sources.
- Compilation & Language:
	- Compiler: DNN Roslyn Compiler (2sxc) MUST be installed and active to enable modern C# in DNN.
	- Language level: C# 8.0 is the project standard. New code in ASCX code-behind and `App_Code` MUST compile under C# 8.0.
	- Constraints: Avoid APIs not available on .NET Framework used by your DNN version; prefer language features compatible with runtime.
	- References: https://2sxc.org/en/download/dnn-roslyn-compiler
- JS: Register via Client Resource Management; avoid global collisions; no blocking scripts above the fold.
	- Dependencies & Packaging: All third‑party JS MUST be declared in `package.json` and copied from `node_modules` to `dist` (e.g., `dist/lib`) via npm scripts (e.g., `update-lib-*`, `update-libs`). `node_modules` MUST NOT be deployed to production or test environments. Only assets under `dist` are referenced/registered in DNN.
- Icons: Prefer inline SVG; include fallbacks as needed.
- Browser Support: Evergreen browsers (latest 2 versions); no IE11 support.
- Assets & Caching: Versioned filenames or query strings; enable long‑term caching for static assets.

## Development Workflow & Quality Gates

0. Bootstrap from this Starter Kit → set theme name/manifest → configure build scripts and paths.
1. Design in Figma → tokens/components approved → annotate implementation notes where needed; attach Figma in VS Code MCP.
2. Implement skins/containers and map tokens → CSS variables and utilities.
3. Package theme (Skins/Containers) and install on a test portal.
4. Run Quality Gates (must PASS):
	 - Figma tokens → CSS variables parity report
	 - A11y audit (WCAG 2.1 AA) on key templates
	 - Performance budgets within limits on key templates
	 - Visual baseline updated and diffs approved
	 - SemVer bump recorded with CHANGELOG and migration notes

## Authoritative References

- DNN Theme Objects: https://docs.dnncommunity.org/content/tutorials/themes/theme-objects/index.html
- DNN Theme Objects (source): https://github.com/DNNCommunity/DNNDocs/blob/main/content/tutorials/themes/theme-objects/index.md
- DNN DDR Menu: https://www.dnnsoftware.com/wiki/ddrmenu-user-guide
- DDR Menu Razor Templates: https://www.dnnsoftware.com/wiki/ddrmenu-razor-templates
- Client Resource Management: https://dnndocs.com/ (search: "Client Resource Management")
- Bootstrap 5: https://getbootstrap.com/docs/5.3/getting-started/introduction/
- webpack: https://webpack.js.org/concepts/
- DNN Roslyn Compiler (2sxc): https://2sxc.org/en/download/dnn-roslyn-compiler

## Governance

- Authority: This Constitution supersedes other style guides for theme development in this repo.
- Amendments: Via PR updating this file; include version bump rationale, change summary, and migration guidance.
- Review: All PRs must include a completed Constitution Check (see Workflow & Quality Gates) and be approved by maintainers.
- Versioning Policy: Follow Principle V; every release tags theme and packages with the same version.
- Compliance: Periodic audits ensure continued adherence; blockers must be resolved before release.

**Version**: 1.9.0 | **Ratified**: 2025-09-24 | **Last Amended**: 2025-09-24