# Stage 1: Build dependencies
FROM python:3.11-slim-bookworm as builder
WORKDIR /app
COPY src/api .
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Stage 2: Final image
FROM python:3.11-slim-bookworm
WORKDIR /app
COPY --from=builder /install /usr/local
COPY src/api .
COPY models/trained/*.pkl models/trained/
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

