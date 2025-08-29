# litellm-oldcpu
LiteLLM Docker image build for older CPUs that do not support the x86-64-v2 instruction set.

# Credits?
@guilherme-deschamps, who made the original reply in [LiteLLM Issue #9702](https://github.com/BerriAI/litellm/issues/9702#issuecomment-3004985175).
I simply added the Prisma schema copy and `prisma generate`

# Why? 
I was runnning an old machine and wanted LiteLLM as a proxy for Groq API, and Cerebras to pipe into Open-WebUI. 
However, the docker image throw Glibc errors avout requiring the x86-64-v2 instruction set. This comes from the chainguard image used as a builder and runtime.
This has the nice bonus of consuming less space! ~800MB in this image compared ot 2.1GB of the real `ghcr.io/berriai/litellm-database:main-stable` package.

# How?
By using a Python Slim image, and simply `pip install`ing `litellm` and `litellm[proxy]` (and `prisma` and `langfuse`).
After that, generate the prisma binaries with `prisma generate`, of course after having copied the `schema.prisma` from the litellm repo

# Build guide
## Build requirements
You need `docker` and `docker buildx`.

## Build instructions
```
git clone https://github.com/StNiosem/litellm-oldcpu.git
cd litellm-oldcpu
docker build .
```
