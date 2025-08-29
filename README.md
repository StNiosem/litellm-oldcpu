# litellm-oldcpu
LiteLLM Docker image build for older CPUs that do not support the x86-64-v2 instruction set.

# Credits?
@guilherme-deschamps, who made the original reply in [LiteLLM Issue #9702](https://github.com/BerriAI/litellm/issues/9702#issuecomment-3004985175).
I simply added the Prisma schema copy and `prisma generate`

# Why? 
I was runnning an old machine and wanted LiteLLM as a proxy for Groq API, and Cerebras to pipe into Open-WebUI. 
However, the docker image throw Glibc errors avout requiring the x86-64-v2 instruction set. This comes from the chainguard image used as a builder and runtime.
This has the nice bonus of consuming less space! ~1.5GB in this image compared to ~2.1GB of the real `ghcr.io/berriai/litellm-database:main-stable` package.

# How?
By using a Python Slim image, and simply `pip install`ing `litellm` and `litellm[proxy]` (and `prisma` and `langfuse`).
After that, generate the prisma binaries with `prisma generate`, of course after having copied the `schema.prisma` from the litellm repo

# Usage
Refer to [official LiteLLM Documantation](https://docs.litellm.ai/docs/simple_proxy)
To connect a database to the proxy server for Virtual Keys, use an environment variable named `DATABASE_URL`
It sould be like this:
```
{DB_TYPE}://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DATABASE}
```
Where:
* `{DB_TYPE}` is your database server's type, most probably `postgres`,  and I don't know about mysql and MariaDB
* `{DB_USER}` is your database server user
* `{DB_PASSWORD}` is your database serer password
* `{DB_HOST}` is your database server host, most liely `db`if running in Docker Compose, but can be an IP, anything
* `{DB_PORT}` is your database server port, 5432 for PostgreSQL
* `{DATABASE}` is your database server's database

# Build guide
## Build requirements
You need `docker` and `docker buildx`.

## Build instructions
```
git clone https://github.com/StNiosem/litellm-oldcpu.git
cd litellm-oldcpu
docker build .
```
