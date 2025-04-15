# Use Python 3.11 slim image
FROM python:3.11-slim-bullseye

# Install system dependencies for the required Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONDONOTWRITEBYTECODE=1

# Copy app files
COPY . .

# Expose port and run the app
EXPOSE 5000
CMD ["python", "main.py"]