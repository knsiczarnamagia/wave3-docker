# Używamy obrazu bazowego z Python 3.12
FROM python:3.12-slim

# Ustawiamy katalog roboczy w kontenerze
WORKDIR /app

# Instalacja narzędzi potrzebnych do budowy aplikacji
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Instalacja Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Kopiujemy pliki konfiguracyjne Poetry
COPY pyproject.toml poetry.lock* ./

# Instalacja zależności z użyciem Poetry
RUN poetry install --no-root --no-dev --only main

# Kopiujemy pliki projektu do kontenera
COPY . .

# Uruchomienie bota za pomocą Poetry
CMD ["poetry", "run", "python", "bot.py"]