FROM debian:stable-slim

# Install dependencies (Perl, Curses, compiler, cpanminus)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    perl \
    libcurses-perl \
    make \
    gcc \
    cpanminus && \
    rm -rf /var/lib/apt/lists/*

# Install Term::Animation using cpanm (non-interactive)
RUN cpanm --notest Term::Animation

# Copy project into container
WORKDIR /app
COPY . /app

# Install asciiquarium script into PATH
RUN install -m 755 /app/asciiquarium /usr/local/bin/asciiquarium

# Default command
CMD ["asciiquarium"]
