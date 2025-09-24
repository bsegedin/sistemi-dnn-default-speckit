<!--
Sync Impact Report
- Version change: none → 1.0.0
- Modified principles: N/A (initial adoption)
- Added sections: Core Principles (5), Technology Standards & Constraints, Development Workflow & Quality Gates, Governance
- Removed sections: None
- Templates requiring updates:
	✅ .specify/templates/plan-template.md (Constitution Check + version footer)
	✅ .specify/templates/spec-template.md (reviewed, no changes needed)
	✅ .specify/templates/tasks-template.md (reviewed, no changes needed)
	✅ .specify/templates/agent-file-template.md (reviewed, no changes needed)
- Follow-up TODOs:
	• TODO(SUPPORTED_DNN_VERSIONS): Confirm minimum DNN CE version and site .NET runtime this theme must support.
-->

# DNN CMS CE Theme Development Constitution

## Core Principles

### I. Figma Is the Single Source of Truth for Design
All theme UI decisions MUST originate in Figma and be reflected as reusable tokens and components.
- Figma library and file naming: `_Development / SpecKit Playground` with pages: Desktop layouit, Mobile layout.
- Design tokens (colors, typography, spacing, radii, shadows) MUST exist as Figma variables and map 1:1 to CSS custom properties
	under `:root` (e.g., `--color-primary-500`). Tokens MAY be namespaced by theme.
- Components MUST be auto‑layout based, responsive, and include necessary states (hover/focus/active/disabled).
- Exported assets (SVG/PNG) MUST be derived from Figma, named by token/component, and committed under the theme assets folder.
Rationale: A single, inspectable design source prevents drift and accelerates consistent implementation.

### II. DNN Theme Structure and Packaging Are Stable Contracts
The theme MUST follow DNN CE skin/container conventions and ship as versioned install packages.
- Structure: Skins in `Portals/_default/Skins/SistemiDefault/`, Containers in `Portals/_default/Containers/SistemiDefault/` (or project‑specific portal path).
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

## Technology Standards & Constraints

- Platform: DNN Community Edition 9.x (Web Forms skinning). TODO(SUPPORTED_DNN_VERSIONS).
- Skinning: Use HTML or ASCX skinning consistently; document chosen approach per theme; keep containers minimal.
- CSS: Author in SCSS (recommended) or CSS; output compiled, vendor‑prefixed CSS; naming: BEM‑style.
- Tokens: Expose Figma tokens as CSS custom properties under `:root` and theme scope.
- JS: Register via Client Resource Management; avoid global collisions; no blocking scripts above the fold.
- Icons: Prefer inline SVG; include fallbacks as needed.
- Browser Support: Evergreen browsers (latest 2 versions); no IE11 support.
- Assets & Caching: Versioned filenames or query strings; enable long‑term caching for static assets.

## Development Workflow & Quality Gates

1. Design in Figma → tokens/components approved → annotate implementation notes where needed.
2. Implement skins/containers and map tokens → CSS variables and utilities.
3. Package theme (Skins/Containers) and install on a test portal.
4. Run Quality Gates (must PASS):
	 - Figma tokens → CSS variables parity report
	 - A11y audit (WCAG 2.1 AA) on key templates
	 - Performance budgets within limits on key templates
	 - Visual baseline updated and diffs approved
	 - SemVer bump recorded with CHANGELOG and migration notes

## Governance

- Authority: This Constitution supersedes other style guides for theme development in this repo.
- Amendments: Via PR updating this file; include version bump rationale, change summary, and migration guidance.
- Review: All PRs must include a completed Constitution Check (see Workflow & Quality Gates) and be approved by maintainers.
- Versioning Policy: Follow Principle V; every release tags theme and packages with the same version.
- Compliance: Periodic audits ensure continued adherence; blockers must be resolved before release.

**Version**: 1.0.0 | **Ratified**: 2025-09-24 | **Last Amended**: 2025-09-24