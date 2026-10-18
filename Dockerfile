FROM nginx:alpine

# Build-time argument to inject source Git commit SHA into /health endpoint
ARG COMMIT_SHA=unknown

# Remove default Nginx welcome assets
RUN rm -rf /usr/share/nginx/html/*

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy application static files
COPY . /usr/share/nginx/html/

# Embed the Git commit SHA into /health file
RUN printf "%s\n" "${COMMIT_SHA}" > /usr/share/nginx/html/health

# Setup runtime hook for dynamic environment commit SHA (e.g. Render)
RUN printf '#!/bin/sh\nif [ -n "$RENDER_GIT_COMMIT" ]; then\n  echo -n "$RENDER_GIT_COMMIT" > /usr/share/nginx/html/health\nelif [ -n "$COMMIT_SHA" ] && [ "$COMMIT_SHA" != "unknown" ]; then\n  echo -n "$COMMIT_SHA" > /usr/share/nginx/html/health\nfi\n' > /docker-entrypoint.d/40-commit-sha.sh && chmod +x /docker-entrypoint.d/40-commit-sha.sh

# Expose web server port
EXPOSE 80

# Health check verifying the /health endpoint
HEALTHCHECK --interval=10s --timeout=3s --start-period=3s --retries=3 \
  CMD wget -q -O - http://127.0.0.1:80/health >/dev/null 2>&1 || exit 1

# Start Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
