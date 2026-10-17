#!/bin/sh
# Inject running git commit from runtime environment if present (Render, Railway, Kubernetes, Docker)
if [ -n "$RENDER_GIT_COMMIT" ]; then
    echo -n "$RENDER_GIT_COMMIT" > /usr/share/nginx/html/health
elif [ -n "$COMMIT_SHA" ] && [ "$COMMIT_SHA" != "unknown" ]; then
    echo -n "$COMMIT_SHA" > /usr/share/nginx/html/health
fi
