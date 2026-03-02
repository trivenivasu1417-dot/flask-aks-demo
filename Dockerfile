# Base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy app
COPY app.py .

# Install Flask
RUN pip install flask

# Expose port
EXPOSE 5000

# Run app
CMD ["python", "app.py"]
