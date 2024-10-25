# Makefile

# Define the images with a date suffix
DATE := $(shell date +%Y%m%d)
BACKEND_IMAGE=lunary-backend-$(DATE)
FRONTEND_IMAGE=lunary-frontend-$(DATE)

.PHONY: all build-backend build-frontend

all: build-backend build-frontend

build-backend:
	@echo "Building Backend Image: $(BACKEND_IMAGE)..."
	docker build --target backend_runner -t $(BACKEND_IMAGE) .

build-frontend:
	@echo "Building Frontend Image: $(FRONTEND_IMAGE)..."
	docker build --target frontend_runner -t $(FRONTEND_IMAGE) .
