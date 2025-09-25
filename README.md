# custom-zitadel-login-nx

This repository is a fork of the [zitadel/zitadel](https://github.com/zitadel/zitadel) project. It contains only the essential Nx workspace projects required to build a custom login application using Next.js.

## About

This repository is a fork of the [zitadel/zitadel](https://github.com/zitadel/zitadel) project. It has been streamlined to include only the essential Nx workspace projects required for building a custom login application with Next.js. The focus is on providing a tailored authentication and authorization experience using Zitadel, while keeping the codebase minimal and maintainable.

For more information about Zitadel, visit the [zitadel/zitadel GitHub repository](https://github.com/zitadel/zitadel).


## Tech Stack

- **TypeScript**
- **JavaScript**
- **React**
- **Next.js**
- **Nx** (monorepo management)
- **pnpm** (package manager)
- **Go** (for protocol buffer and backend utilities)

## Project Structure

- `apps/login`: Custom Next.js login application
- `packages/zitadel-client`: Client library for Zitadel APIs
- `packages/zitadel-proto`: Protocol buffer definitions and generated code
- `proto/`: Protocol buffer source files

## Getting Started

### Installing Local Dependencies

To set up the project locally, follow these steps:

1. **Install Docker**  
   Download and install Docker from [docker.com](https://www.docker.com/products/docker-desktop/).

2. **Install Node.js using nvm** (v22 recommended)  
   Install [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating) and use it to install Node.js:

   ```shell
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
   
   export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
   
   nvm install 22
   nvm use 22
   ```

3. Fetch the Zitadel upstream repository dependencies:

   ```shell
   ./zitadel_upstream_fetch.sh all
   ```

4. Install the project dependencies using pnpm:

   ```shell
    pnpm install
    ```
   
5. Build and test the projects using Nx:

   ```shell
    nx run-many --targets lint build test
    ```