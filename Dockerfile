FROM --platform=linux/amd64 python:slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Install LiteLLM
RUN pip install litellm litellm[proxy] prisma langfuse

# Generate prisma binaries to use Database functions
COPY ./schema.prisma .
RUN prisma generate

# Set the entrypoint (optional: specify host and port like normal 'litellm' command)
ENTRYPOINT ["litellm"]
