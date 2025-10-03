# custom-zitadel-login-nx

[![Build Project](https://github.com/ArnauAregall/custom-zitadel-login-nx/actions/workflows/build.yml/badge.svg)](https://github.com/ArnauAregall/custom-zitadel-login-nx/actions/workflows/build.yml)

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

- `apps/login`: Zitadel's Next.js login application
- `packages/zitadel-client`: Client library for Zitadel APIs
- `packages/zitadel-proto`: Protocol buffer definitions and generated code
- `proto/`: Protocol buffer source files, fetched from the Zitadel upstream repository
- `tools/`: Custom scripts for managing the workspace and fetching upstream changes

## Getting Started

### Installing Dependencies

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
   pnpm run upstream:fetch:all
   ```

4. Install the project dependencies using pnpm:

   ```shell
    pnpm install
    ```

### Building and Testing

To build and test the project, follow these steps:

1. Build and test the projects using Nx:
    
    ```shell
    pnpm nx reset
    pnpm nx run-many --targets lint build test
    ```

2. Clean NX cache  (optional):
    NX caches build and test results to speed up subsequent runs. If you want to clear the cache, you can run:
    
    ```shell
    pnpm nx reset
    ```

3. Clean the entire repository (optional):
    If you want to remove all generated files and start fresh, you can run:

    ```shell
    pnpm nx run-many --targets clean
    ```
   
### Running the Application

To run the custom login application locally:

1. Generate local `.env.local` file sourcing an IAM Login Client PAT

    ```shell
    pnpm run local:env https://localhost:8080 pat_iam_login_client
    ```
    
    The command above will create a `apps/login/.env.local` file with the necessary environment variables to connect to the specified Zitadel instance.
    
    To run the application against a remote Zitadel instance, configure the arguments accordingly:
    ```shell
    pnpm run local:env https://remote.zitadel.com remote_pat_iam_login_client
    ```

2. Start the development server:

    ```shell
    pnpm nx run @zitadel/login:dev
    ```

### Build Docker Image

```shell
 docker buildx build \
  -f apps/login/Dockerfile \
  -t custom-zitadel-login-nx:latest \
  apps/login
```

## Fetching Upstream Changes

To keep your fork up to date with the upstream Zitadel repository, you can use the provided scripts:

- Fetch all upstream changes:

    ```shell
    pnpm run upstream:fetch:all
    ```
- Fetch only proto files:

    ```shell
    pnpm run upstream:fetch:proto
    ```
  
- Fetch only login files:

    ```shell
    pnpm run upstream:fetch:login
    ```

- Clean, re-fetch all upstream changes and reinstall dependencies:

    ```shell
    pnpm run upstream:clean && pnpm run upstream:fetch:all && pnpm install
    ```