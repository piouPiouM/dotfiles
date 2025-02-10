---
filetypes: javascriptreact typescriptreact
---
# React project rules

You are an expert in Web development including TypeScript, CSS, CSS Modules, React, Redux, Node.js and
Storybook. You excel at selecting and choosing the best tools, avoiding unnecessary duplication and complexity.

Follow the official React documentation for up to date best practices on data fetching, state management, rendering,
routing and component composition.

## Assignments

- Fully implement all requested functionality.
- Leave no TODOs, placeholders or missing pieces.
- Ensure code is clean, readable and maintainable.
- Ensure code is complete! Verify that all requested functionality is implemented and that the code is fully functional.

## Code style and structure

- Write concise, technical TypeScript code with accurate examples.
- Use functional components and React hooks; prefer declarative patterns.
- Favor modular and reusable components over monolithic code.
- Use descriptive variable names with auxiliary verbs (e.g., `isLoading`, `hasError`).

## Naming convention

- React component: PascalCase (e.g., `MyComponent`)
- React hook: camelCase prefixed by `use` (e.g., `useAwesomeUtility`)
- directories:
    - use kebab-case to name directories (e.g., `my-component/`)
    - put unit tests in `__tests__` forlder.
    - put integration tests in `__tests__` forlder.
- files:
    - use the name of the React Component in camelCase (e.g., `myComponent`)
    - use extension `.component.tsx` for React components (e.g., `myComponent.component.tsx`)
    - use extension `.constants.ts` for collection of constants (e.g., `myComponent.constants.ts`)
    - use extension `.types.ts` for collection of types (e.g., `myComponent.types.ts`)
    - use extension `.types.ts` for collection of types (e.g., `myComponent.types.ts`)
    - use extension `.module.css` for collection of CSS styles (e.g., `myComponent.module.css`)
    - use extension `.stories.tsx` for collection of Storybook stories (e.g., `myComponent.stories.tsx`)
    - use extension `.int.tsx` for integration tests performed with React Testing Library (e.g., `myComponent.int.tsx`)
    - use extension `.spec.js` for unit tests (e.g., `myComponent.spec.js`)
    - use the name of the hook in camelCase with extension `.hook.ts` (e.g., `useAwesomeUtility.hook.ts`)
- variable: camelCase (e.g., `name`)
- compound variable: camelCase (e.g., `firstName`)
- constant: UPPER_CASE (e.g., `NAME`)
- compound constant: UPPER_CASE (e.g., `FIRST_NAME`)
- function: camelCase (e.g., `get`)
- compound funtion: camelCase (e.g., `getFirstName`)
- Favor named exports.

## TypeScript usage

- Use TypeScript for all files; prefer types over interfaces.
- Avoid `any` types; use utility types when necessary.
- Avoid enums; use maps instead.
- Rely on React-specific TypeScript utilities (e.g., `ComponentProps`).

## Syntax and formatting

- Use arrow functions for all components.
- Avoid unnecessary curly braces in JSX; use concise syntax for clean, readable code.
- Use the `classNames` utility function for merging dynamic class names (classnames).

## React and component best practices

- Leverage the composition model to build modular, testable UI elements.
- Structure files logically: group components, hooks, utilities, and types in clearly named directories.

## API

- Prefer iteration and modularization over large, monolithic logic blocks.
- Group API logic into hooks (e.g., `useFetchData`).