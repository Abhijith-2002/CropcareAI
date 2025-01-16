# Use Python 3.9-slim as the base image
FROM python:3.9-slim

# Install essential build tools and dependencies
RUN apt-get update && apt-get install -y \
    python3-dev \
    gfortran \
    libopenblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, and wheel
RUN pip install --upgrade pip setuptools wheel

# Set the working directory inside the container
WORKDIR /app

# Copy the entire app directory into the container
COPY ./app /app

# Install dependencies from requirements.txt
COPY ./app/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Expose port 5000 for Flask app
EXPOSE 5000

# Command to run the application
CMD ["python", "/app/app.py"]
