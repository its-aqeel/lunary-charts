Thank you for clarifying the structure. Here’s the updated README file that reflects that the `Makefile` and `Dockerfile` are in the **Lunary-charts** repository but the actual image build code is in the **Lunary** repository.

### Complete README.md

```markdown
# Lunary Application Setup

This document provides a comprehensive guide to setting up the Lunary application using Docker and Helm charts. 

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Step 1: Clone the Lunary Repository](#step-1-clone-the-lunary-repository)
- [Step 2: Clone the Lunary-Charts Repository](#step-2-clone-the-lunary-charts-repository)
- [Step 3: Build Docker Images](#step-3-build-docker-images)
- [Step 4: Deploy Using Helm Charts](#step-4-deploy-using-helm-charts)
- [License](#license)

## Overview

The Lunary application is designed for efficient operations with a modern architecture. This guide outlines the steps necessary to set up and run the application locally using Docker and deploy it using Helm charts.

## Getting Started

Follow the steps below to clone the Lunary repository, build the Docker images, and run the application.

### Prerequisites

Ensure you have the following installed on your machine:

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Helm**: [Install Helm](https://helm.sh/docs/intro/install/)
- **Git**: [Install Git](https://git-scm.com/downloads)

### Step 1: Clone the Lunary Repository

1. Open your terminal.
2. Clone the official Lunary repository using the following command:

   ```bash
   git clone https://github.com/lunary-ai/lunary.git
   ```

3. Navigate into the cloned Lunary directory:

   ```bash
   cd lunary
   ```

### Step 2: Clone the Lunary-Charts Repository

1. In the terminal, clone the Lunary-Charts repository using the following command:

   ```bash
   git clone https://github.com/lunary-ai/lunary-charts.git
   ```

2. Navigate into the cloned Lunary-Charts directory:

   ```bash
   cd lunary-charts
   ```

### Step 3: Build Docker Images

1. **Navigate back to the Lunary directory**:

   ```bash
   cd ../lunary
   ```

2. Use the provided `Makefile` and `Dockerfile` from the Lunary-Charts repository to build the Docker images. Run the following command:

   ```bash
   cd lunary
   cp ../lunary-charts/Makefile Makefile
   cp ../lunary-charts/Dockerfile Dockerfile

   make
   ```

   This command will execute the default target defined in the `Makefile`, which builds both the backend and frontend Docker images.

3. After the build process completes, verify that the images have been created by running:

   ```bash
   docker images
   ```

   You should see images for both the backend and frontend in the list.

### Step 4: Deploy Using Helm Charts

1. Navigate back to the Lunary-Charts directory:

   ```bash
   cd ../lunary-charts/deployment
   ```

2. Ensure you have the Helm charts set up in your repository. Use the following command to install the charts:

   ```bash
   helm install lunary-app lunary-app 
   ```

3. To customize the deployment, you can modify the `values.yaml` file in your Helm chart directory. This file contains configurable parameters for your application, such as environment variables, service types, and replica counts.
