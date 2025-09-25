FROM node:22-alpine
WORKDIR /runtime
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs
# If /.env-file/.env is mounted into the container, its variables are made available to the server before it starts up.
RUN mkdir -p /.env-file && touch /.env-file/.env && chown -R nextjs:nodejs /.env-file
RUN mkdir -p /.env-secrets && touch /.env-secrets/.env.secrets && chown -R nextjs:nodejs /.env-secrets

COPY --chown=nextjs:nodejs .next/standalone ./
RUN echo '{ "status": "UP" }' > ./apps/login/.next/static/health.json

USER nextjs
ENV HOSTNAME="0.0.0.0" \
    PORT="3000" \
    NODE_ENV="production"

EXPOSE 3000

# TODO: Check healthy, not ready
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD ["/bin/sh", "-c", "node /runtime/healthcheck.js http://localhost:${PORT}/healthy"]
ENTRYPOINT ["/runtime/entrypoint.sh", "node", "apps/login/server.js" ]
