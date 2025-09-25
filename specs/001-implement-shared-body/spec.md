# Feature Specification: Shared Theme Body Control & ThemeHelpers

**Feature Branch**: `001-implement-shared-body`  
**Created**: 2025-09-25  
**Status**: Draft  
**Input**: User description: "Implement shared body control `_inc-theme-body.ascx` as the single layout host; update wrappers `Portals/_default/Skins/Base/*.ascx` to include it with attributes (`LayoutVariant`, `PaneLayout`, `HeaderStyle`, `ShowBreadcrumb`); add/standardize `App_Code/BaseTheme/ThemeHelpers.cs` helpers; expose Figma tokens as CSS custom properties; ensure a11y and performance budgets; packaging and migration notes; visual baseline and contract tests."

## Execution Flow (main)
```
1. Parse user description from Input
	→ If empty: ERROR "No feature description provided"
2. Extract key concepts from description
	→ Identify: actors, actions, data, constraints
3. For each unclear aspect:
	→ Mark with [NEEDS CLARIFICATION: specific question]
4. Fill User Scenarios & Testing section
	→ If no clear user flow: ERROR "Cannot determine user scenarios"
5. Generate Functional Requirements
	→ Each requirement must be testable
	→ Mark ambiguous requirements
6. Identify Key Entities (if data involved)
7. Run Review Checklist
	→ If any [NEEDS CLARIFICATION]: WARN "Spec has uncertainties"
	→ If implementation details found: ERROR "Remove tech details"
8. Return: SUCCESS (spec ready for planning)
```

---

## ⚡ Quick Guidelines
- ✅ Focus on WHAT users need and WHY
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure)
- 👥 Written for business stakeholders, not developers

### Section Requirements
- **Mandatory sections**: Must be completed for every feature
- **Optional sections**: Include only when relevant to the feature
- When a section doesn't apply, remove it entirely (don't leave as "N/A")

### For AI Generation
When creating this spec from a user prompt:
1. **Mark all ambiguities**: Use [NEEDS CLARIFICATION: specific question] for any assumption you'd need to make
2. **Don't guess**: If the prompt doesn't specify something (e.g., "login system" without auth method), mark it
3. **Think like a tester**: Every vague requirement should fail the "testable and unambiguous" checklist item
4. **Common underspecified areas**:
	- User types and permissions
	- Data retention/deletion policies  
	- Performance targets and scale
	- Error handling behaviors
	- Integration requirements
	- Security/compliance needs

---

## User Scenarios & Testing (mandatory)

### Primary User Story
As a site maintainer, I want all skins to delegate layout to a single shared body control so that layout behavior is consistent across pages and easier to maintain, with both Desktop layout and Mobile layout from Figma treated as authoritative and kept in parity.

### Acceptance Scenarios
1. Given a portal using the `Default.ascx` skin, When the page renders, Then the shared body control produces the correct panes and header/footer elements per wrapper attributes.
2. Given a page using `SingleNarow.ascx`, When it renders, Then only the single content pane is visible and the body control applies the expected CSS classes.
3. Given a page using `SplitPanesCenter.ascx` or `SplitPanesFluid.ascx`, When it renders, Then left/right/content panes are visible and arranged according to the selected layout variant.
4. Given design tokens defined in Figma, When the page renders, Then corresponding CSS custom properties exist under `:root` and match token values (parity report passes) for both Desktop layout and Mobile layout.
5. Given accessibility requirements, When the home and content templates are audited, Then WCAG 2.1 AA checks pass (focus, keyboard, landmarks, contrast).
6. Given performance budgets, When the key templates load, Then uncompressed budgets are within CSS ≤ 200 KB, JS ≤ 100 KB at FCP.
7. Given Figma groups named "Main menu" and "Service menu", When navigation renders on Desktop and Mobile, Then both menus are produced by DNN DDR Menu using Razor templates and match the Figma layouts without hard-coded menu HTML in skins.
8. Given a mobile viewport, When the page renders, Then the desktop menu is hidden and a Bootstrap Offcanvas opens with navigation rendered by a DDR Razor template; focus is trapped while open and Esc closes the menu.

### Edge Cases
- Skins missing attribute values: The body control applies safe defaults (e.g., `LayoutVariant=Default`, `PaneLayout=Single`, `HeaderStyle=None`).
- Unexpected attribute values: The body control ignores invalid values and falls back to defaults without breaking layout.
- Missing helpers: If a helper call fails, the body control renders minimal markup and logs a warning without blocking page render.

## Technical Context
- Tooling: Figma MCP (VS Code) is REQUIRED to access the "Desktop layout" and "Mobile layout" pages for inspection/export.
- Access: Configure Figma credentials securely via VS Code Secret Storage or env var `FIGMA_TOKEN`.
- Variance: If MCP cannot be used, document rationale and ensure Desktop/Mobile parity via alternative workflow.
- Styles: All styles MUST be authored in SCSS under `Portals/_default/Skins/Base/src/scss/` covering layouts and components.
- Framework: Bootstrap v5 is mandatory. Customize via SCSS variables/partials only.
- Build: Use webpack to compile SCSS → CSS. Compiled CSS is a generated artifact.
- Compilation: DNN Roslyn compiler (2sxc) REQUIRED; code targets C# 8.0 language level compatible with your runtime.
  
Note: Navigation menus must use DDR Menu with Razor templates per official documentation: DDR Menu User Guide (https://www.dnnsoftware.com/wiki/ddrmenu-user-guide) and Razor Templates (https://www.dnnsoftware.com/wiki/ddrmenu-razor-templates).

## Clarifications

### Session 2025-09-25
- Figma MCP access (source of truth for designs):
	- Desktop layout: https://www.figma.com/design/MTcg0pGVIzWYaIlIyOS6Cb/SpecKit-Playground?node-id=1-101&t=UPgCcGBXCxq490uM-4
	- Mobile layout: https://www.figma.com/design/MTcg0pGVIzWYaIlIyOS6Cb/SpecKit-Playground?node-id=2-155&t=UPgCcGBXCxq490uM-4
	- Note: Links point to selections for pinpointing elements. Ensure VS Code Figma MCP is authenticated; store token securely.
- Decisions/Status:
	- Figma pages above are authoritative for Desktop and Mobile parity requirements.
	- DDR Menu with Razor templates is required for "Main menu" and "Service menu"; Bootstrap Offcanvas is required for mobile nav.
- Open questions (tracked by FR-012/FR-013):
	- Minimum supported DNN CE version and .NET runtime (confirm exact versions).
	- Authoritative list of wrapper attributes and allowed values (finalize names and enums).

## Requirements (mandatory)

### Functional Requirements
- FR-001: The system MUST render all page layouts through `Portals/_default/Skins/Base/controls/_inc-theme-body.ascx`.
- FR-002: Each skin wrapper in `Portals/_default/Skins/Base/*.ascx` MUST include the shared body control and pass attributes (`LayoutVariant`, `PaneLayout`, `HeaderStyle`, `ShowBreadcrumb`).
- FR-003: The shared body control MUST host all DNN panes and toggle visibility/structure according to wrapper attributes.
- FR-004: The system MUST expose Figma design tokens as CSS variables under `:root` with stable names used by the theme, covering both Desktop layout and Mobile layout designs.
- FR-005: The theme MUST pass WCAG 2.1 AA checks on key templates (focus, keyboard navigation, landmarks, contrast ≥ 4.5:1).
- FR-006: The theme MUST meet performance budgets (uncompressed at FCP: CSS ≤ 200 KB, JS ≤ 100 KB) on key templates.
- FR-007: The theme MUST follow DNN Theme Objects documentation; only documented skin objects may be used.
- FR-008: Shared helpers MUST reside in `App_Code/BaseTheme/ThemeHelpers.cs` and be callable by the body control for pane toggles, formatting, composing skin objects, and Client Resource Management.
- FR-009: Public helper method signatures/behaviors MUST remain stable; breaking changes REQUIRE a MAJOR version bump; additions are MINOR; fixes are PATCH.
- FR-010: The feature MUST produce installable theme packages per DNN packaging guidelines and include migration notes.
- FR-011: The feature MUST establish visual baselines for Home/Content/Listing/Article/Search and require approval for diffs.
- FR-014: Figma groups "Main menu" and "Service menu" MUST be implemented using DNN DDR Menu with Razor templates; no hard-coded menu HTML. Razor templates MUST reflect both Desktop and Mobile variants from Figma.
- FR-015: All third‑party JavaScript dependencies MUST be declared in `package.json` and copied from `node_modules` to `dist` (e.g., `dist/lib`) via npm scripts (e.g., `update-lib-*`, `update-libs`). `node_modules` MUST NOT exist on production or test environments; only vendored files under `dist` may be referenced by the theme.
- FR-016: Mobile navigation MUST use Bootstrap Offcanvas. The desktop menu MUST be hidden on mobile. Offcanvas content MUST be rendered via a DDR Menu Razor template, wired through `_inc-theme-body.ascx`, and meet a11y requirements (focus trap, labeled toggles, Esc to close, proper ARIA attributes).

*Ambiguities to resolve:*
- FR-012: [NEEDS CLARIFICATION: Confirm exact minimum DNN CE version and .NET runtime (see TODO(SUPPORTED_DNN_VERSIONS))]
- FR-013: [NEEDS CLARIFICATION: Confirm the authoritative list of wrapper attributes and allowed values]

### Key Entities (if applicable)
- Theme Wrapper: A skin ASCX that delegates to the shared body control and sets layout attributes.
- Body Control: `_inc-theme-body.ascx` renders panes, applies classes, and coordinates helpers.
- Theme Helpers: `App_Code/BaseTheme/ThemeHelpers.cs` provides rendering utilities and resource registration.
- Design Tokens: Figma variables mapped to CSS custom properties.

---

## Review & Acceptance Checklist
*GATE: Automated checks run during main() execution*

### Content Quality
- [ ] No implementation details (languages, frameworks, APIs)
- [ ] Focused on user value and business needs
- [ ] Written for non-technical stakeholders
- [ ] All mandatory sections completed

### Requirement Completeness
- [ ] No [NEEDS CLARIFICATION] markers remain
- [ ] Requirements are testable and unambiguous  
- [ ] Success criteria are measurable
- [ ] Scope is clearly bounded
- [ ] Dependencies and assumptions identified
- [ ] Styles authored in SCSS (no direct CSS edits); Bootstrap v5; webpack build
- [ ] Roslyn compiler installed/enabled; C# 8.0 language features validated

### Quickstart (tooling)
1. Install and authenticate the Figma MCP in VS Code.
2. Open the Figma file and verify access to pages: "Desktop layout" and "Mobile layout".
3. Run token parity checks and export any required assets via MCP workflow.

---

## Execution Status
*Updated by main() during processing*

- [ ] User description parsed
- [ ] Key concepts extracted
- [ ] Ambiguities marked
- [ ] User scenarios defined
- [ ] Requirements generated
- [ ] Entities identified
- [ ] Review checklist passed

---
