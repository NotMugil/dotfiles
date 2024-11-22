# Commit Message Guidelines

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

## Commit Message Header Format
Each commit message consists of a header, a body and a footer. The header has a special format that includes a type, a scope and a subject:

```
<type>(<optional scope>): <short summary>
  │       │             │
  │       │             └─⫸ Summary in present tense. Not capitalized. No period at the end.
  │       │
  │       └─⫸ Commit Scope: <appname>|animations|scripts|aliases|shell|other
  │                         
  │                          
  │                          
  │                          
  │
  └─⫸ Commit Type: fix|feat|docs|perf|style|refactor|test|delete|rename|move
```

## Commit Message Types



* **docs**: Documentation only changes
```markdown
docs: correct spelling of readme
```
* **feat**: A new feature
```markdown
feat(scripts): add script to switch between dark and light themes
```
* **fix**: A bug fix
```markdown
fix(animations): fix bug causing stutter while switching workspace
```
* **perf**: A code change that improves performance
```markdown
perf: optimize image loading for faster rendering
```
* **refactor**: A code change that neither fixes a bug nor adds a feature
```markdown
refactor: optimize rendering logic for better performance
```
* **conf**: Changes in configuration files, typically related to settings or parameters
```markdown
conf(hypr): update config for better workspace management
```
* **move**: Moving files or code from one location to another within the project to better organize the codebase
```markdown
move: relocate css files to styles/ directory
```
* **rename**: Renaming files, variables, functions, or other elements within the codebase without changing their functionality.
```markdown
rename: update variable names for clarity
```
* **delete**: Removing unnecessary files or code that is no longer needed in the project.
```markdown
delete: remove obsolete helper function
```
* **test**: Adding missing tests or correcting existing tests
```markdown
test: add unit tests for user authentication module
```
