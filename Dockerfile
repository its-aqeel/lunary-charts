# Base image for Node
FROM node:21-bookworm AS base

# Backend Stage
## DEPS for Backend
FROM base AS backend_deps
WORKDIR /app

COPY ./package.json ./package-lock.json ./
COPY ./patches ./patches
COPY ./packages/backend/package.json ./packages/backend/
COPY ./packages/shared/package.json ./packages/shared/
RUN npm ci

## RUNNER for Backend
FROM base AS backend_runner
WORKDIR /app

ARG LUNARY_VERSION=latest
ENV LUNARY_VERSION=${LUNARY_VERSION}
ENV LUNARY_PUBLIC_KEY=259d2d94-9446-478a-ae04-484de705b522 
ENV SKIP_EMAIL_VERIFY=true
ENV NODE_ENV=production
ENV IS_SELF_HOSTED=true

COPY --from=backend_deps /app ./
COPY ./packages/backend ./packages/backend
COPY ./packages/shared ./packages/shared
COPY ./packages/db ./packages/db

EXPOSE 3333 
CMD ["npm", "run", "start:backend"]

# Frontend Stage
## DEPS for Frontend
FROM node:20-bookworm AS frontend_deps
WORKDIR /app

COPY package.json package-lock.json ./
COPY packages/frontend/package.json packages/frontend/
COPY packages/shared/package.json packages/shared/
RUN npm ci

## BUILDER for Frontend
FROM frontend_deps AS frontend_builder
WORKDIR /app

COPY --from=frontend_deps /app ./
COPY ./packages ./packages
COPY ./packages/frontend/load-env.sh ./packages/frontend

ENV NEXT_PUBLIC_IS_SELF_HOSTED true
ENV NEXT_PUBLIC_API_URL xyzPLACEHOLDERxyz
ARG LUNARY_VERSION=latest
ENV NEXT_PUBLIC_LUNARY_VERSION ${LUNARY_VERSION}

RUN npm run build:frontend 

## RUNNER for Frontend
FROM base AS frontend_runner
WORKDIR /app

ENV DEFAULT_PLAN custom
ENV SKIP_EMAIL_VERIFY true
ENV NEXT_TELEMETRY_DISABLED 1
ENV NODE_ENV production

COPY --from=frontend_builder /app ./ 

EXPOSE 8080 
CMD ["npm", "run", "start:frontend"]
