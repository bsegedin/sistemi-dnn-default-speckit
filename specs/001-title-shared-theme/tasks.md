# Tasks: Shared Theme Body Control, DDR Menus, and Build/Packaging Compliance

**Feature Dir**: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\specs\001-title-shared-theme`  
**Source Root**: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website`  
**Skin Root**: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base`  
**Prerequisites**: `plan.md` (present), research.md (n/a), data-model.md (n/a), contracts/ (n/a), quickstart.md (n/a)

## Execution Flow (main)
```
1) Load plan.md (this feature)
2) Generate tasks per constitution & spec → setup → tests-first → implementation → integration → polish
3) Mark [P] where tasks operate on different files
4) Order by dependencies; include parallel execution examples
```

## Format: [ID] [P?] Description
- [P] = safe to run in parallel (different files, no ordering conflicts)
- Always include exact absolute file paths

---

## Phase 3.1: Setup
- [ ] T001 Verify Starter Kit base is used (no ad-hoc scaffolding); document theme identifiers to use in this feature
      Notes: Use this repo as the base; prepare name/version for packaging.
- [ ] T002 Configure Figma MCP in VS Code (Desktop/Mobile pages access) and record token export workflow in
      `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\specs\001-title-shared-theme\quickstart.md`
- [ ] T003 Ensure DNN Roslyn compiler (2sxc) is installed and active on target portal; record version in
      `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\specs\001-title-shared-theme\research.md`
- [ ] T004 [P] Create controls directory if missing:
      `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base\controls\`
- [ ] T005 [P] Create menus directories for DDR Razor templates if missing:
      - `...\Skins\Base\menus\MainMenu\`
      - `...\Skins\Base\menus\ServiceMenu\`
- [ ] T006 [P] Ensure build output folders exist:
      - `...\Skins\Base\dist\`
      - `...\Skins\Base\dist\lib\`
- [ ] T007 Validate `package.json` scripts in skin root include JS vendoring and no node_modules on prod/test; if missing, add:
      File: `...\Skins\Base\package.json`
      Scripts present: `update-lib-bootstrap`, `update-lib-glightbox`, `update-libs`, `build-dev`, `build-prod`
- [ ] T008 Run vendoring to populate dist libs:
      In `...\Skins\Base\`: `npm install`; `npm run update-libs`
- [ ] T009 Confirm webpack builds CSS/JS to `dist` and SCSS sources live in `src\scss\`; if absent, create placeholder structure:
      - `...\Skins\Base\src\scss\index.scss`
      - `...\Skins\Base\src\scss\_tokens.scss`

## Phase 3.2: Tests First (TDD) — MUST FAIL initially
- [ ] T010 [P] Token parity contract test (CSS custom properties)
      Create Node test script to assert required CSS variables exist in compiled CSS under `dist`.
      File: `...\Skins\Base\tests\contract\tokens.test.mjs`
      Inputs: `...\Skins\Base\dist\*.css`
- [ ] T011 [P] Visual baseline scaffold for key templates (Home, Content, Listing, Article, Search)
      Create a minimal Playwright/puppeteer harness and baseline folder; capture initial images (expected to differ initially).
      Files:
      - `...\Skins\Base\tests\visual\baseline\[home|content|listing|article|search].png`
      - `...\Skins\Base\tests\visual\run.mjs` (script to capture screenshots)
- [ ] T012 [P] Accessibility audit test (axe)
      Create puppeteer + axe-core script to check focus order, landmarks, contrast on Home/Content.
      File: `...\Skins\Base\tests\a11y\axe-audit.mjs`
- [ ] T013 [P] Performance budget check (Lighthouse CLI or PSI API offline)
      Create script to assert uncompressed CSS ≤ 200 KB and JS ≤ 100 KB at FCP for key pages.
      File: `...\Skins\Base\tests\perf\budgets.mjs`
- [ ] T014 Add npm test runners to skin `package.json` for the above (without implementing fixes yet):
      - `test:tokens`, `test:visual`, `test:a11y`, `test:perf`, `test:all`

## Phase 3.3: Core Implementation (only after tests exist and initially fail)
- [ ] T015 Create shared body control markup
      File: `...\Skins\Base\controls\_inc-theme-body.ascx`
      Purpose: host panes, apply classes, include header/footer regions.
- [ ] T016 Create shared body control code-behind (C# 8.0)
      File: `...\Skins\Base\controls\_inc-theme-body.ascx.cs`
      Purpose: parse wrapper attributes (`LayoutVariant`, `PaneLayout`, `HeaderStyle`, `ShowBreadcrumb`), toggle panes.
- [ ] T017 Implement/standardize helpers
      File: `D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\App_Code\BaseTheme\ThemeHelpers.cs`
      Purpose: pane visibility, formatting, composing theme objects, Client Resource Management.
- [ ] T018 Update wrapper skins to delegate to shared body control and pass attributes
      Files: `...\Skins\Base\*.ascx` (e.g., Default.ascx, SingleNarow.ascx, SplitPanesCenter.ascx, SplitPanesFluid.ascx)
- [X] T019 Implement DDR Menu Razor templates — Main Menu
      File: `...\Skins\Base\nav\main\template.cshtml`
      Requirement: Must match Figma Desktop/Mobile; no hard-coded menu HTML in skins.
- [X] T020 Implement DDR Menu Razor templates — Service Menu
      File: `...\Skins\Base\nav\service\template.cshtml`
      Requirement: Must match Figma Desktop/Mobile; no hard-coded menu HTML in skins.
- [X] T021 Wire DDR Menu skin objects in skins to use Razor templates
      Files: `...\Skins\Base\*.ascx` — add DDR Menu SkinObject references with `MenuStyle="Razor"` and template path.
 - [X] T021a Implement mobile Bootstrap Offcanvas menu wiring in `_inc-theme-body.ascx`
      Files: `...\Skins\Base\controls\_inc-theme-body.ascx[.cs]`
      Requirement: Hide desktop menu on mobile; offcanvas content rendered via DDR Razor template; ensure focus trap, Esc to close, ARIA attributes.
- [ ] T022 Author tokens in SCSS as CSS variables
      File: `...\Skins\Base\src\scss\_tokens.scss` → `:root { --color-*, --space-*, --radius-*, ... }`
- [ ] T023 Integrate tokens and layout styles
      File: `...\Skins\Base\src\scss\index.scss` → import Bootstrap v5 overrides, tokens, and component/layout partials
- [ ] T024 Build assets
      In `...\Skins\Base\`: `npm run build-prod`
- [ ] T025 Vendor JS libs to dist (dist-only policy)
      In `...\Skins\Base\`: `npm run update-libs`

## Phase 3.4: Integration
- [ ] T026 Register CSS/JS via DNN Client Resource Management in shared body control or wrapper skins
      Ensure only `dist` assets are referenced (no node_modules paths).
- [ ] T027 Validate menus render correctly (Desktop/Mobile parity) and keyboard navigation works
      Check ARIA, `aria-current`, focus order.
 - [ ] T027a Validate mobile Offcanvas behavior
      Ensure desktop menu hidden on mobile; offcanvas opens/closes via toggle, traps focus, Esc closes, and screen reader labels are correct.
- [ ] T028 Re-run tests: tokens, visual, a11y, performance
      Expect tests to pass or produce explainable diffs.
- [ ] T029 Prepare DNN packaging scripts for theme/container ZIPs
      Create packaging script: `D:\...\Website\Portals\_default\Skins\Base\pack.ps1` and document steps in `quickstart.md`.

## Phase 3.5: Polish
- [ ] T030 [P] Update `CHANGELOG.md` with SemVer bump and migration notes
- [ ] T031 [P] Document quickstart and maintenance in `specs\001-title-shared-theme\quickstart.md`
- [ ] T032 [P] Confirm `.gitignore` excludes `node_modules` and includes `dist` artifacts policy
- [ ] T033 [P] Remove dead code, comments; ensure consistent naming (BEM), a11y labels

## Dependencies
- T001 → T002 → T003
- T004, T005, T006, T007, T008, T009 can run in parallel once T001 is done
- Tests (T010–T014) must exist before implementation (T015–T025)
- T015 blocks T016–T018
- T019–T021 depend on menus folders (T005) and skin files
- T022–T024 depend on SCSS folder (T009)
- T025 depends on T007/T008
- T026–T028 depend on core implementation completion
- Packaging (T029) after integration
- Polish tasks (T030–T033) after core/integration

## Parallel Execution Examples
```
# Example 1: Run setup folder tasks in parallel
Task: "Create controls directory" (T004)
Task: "Create menus directories" (T005)
Task: "Ensure dist folders exist" (T006)
Task: "Validate package.json scripts" (T007)
Task: "Run vendoring" (T008)
Task: "Ensure SCSS structure" (T009)

# Example 2: Run tests-first tasks in parallel
Task: "Token parity contract test" (T010)
Task: "Visual baseline scaffold" (T011)
Task: "Accessibility audit test" (T012)
Task: "Performance budget check" (T013)
```

## Task Agent Commands (reference)
- Create file: "Add <file> with scaffold contents"
- Edit file: "Update <file> section X to ..."
- Run command (PowerShell):
  - `cd "D:\Materijali\Sistemi\DnnDefault\Dev\sistemi-dnn-default-speckit\Website\Portals\_default\Skins\Base"`
  - `npm install`
  - `npm run build-prod`
  - `npm run update-libs`

## Validation Checklist
- [ ] Figma Desktop/Mobile parity validated (menus, layout)
- [ ] DDR Menu Razor templates used for Main/Service menus; no hard-coded HTML
 - [ ] Mobile offcanvas used on mobile, desktop menu hidden; offcanvas DDR menu accessible (focus trap, Esc, ARIA)
- [ ] Token parity tests GREEN (CSS variables present)
- [ ] A11y audits GREEN; exceptions documented
- [ ] Performance budgets respected (CSS ≤ 200 KB, JS ≤ 100 KB uncompressed @ FCP)
- [ ] dist-only JS policy enforced; no node_modules in prod/test
- [ ] Theme packaged for DNN install; SemVer + CHANGELOG updated
