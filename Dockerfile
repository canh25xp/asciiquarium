# ---- Stage 1: Build perl modules ----
FROM debian:stable-slim AS builder

# Install dependencies (Perl, Curses, compiler, cpanminus)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    perl \
    libcurses-perl \
    make \
    gcc \
    cpanminus && \
    rm -rf /var/lib/apt/lists/*

RUN cpanm --notest --local-lib=/perl-local Term::Animation

# ---- Stage 2: Minimal runtime image ----
FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    perl \
    libcurses-perl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /perl-local /perl-local

# Set PERL5LIB so Perl finds the module
ENV PERL5LIB=/perl-local/lib/perl5

COPY asciiquarium /usr/local/bin/asciiquarium

RUN chmod +x /usr/local/bin/asciiquarium

CMD ["asciiquarium"]
