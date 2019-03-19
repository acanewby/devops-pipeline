CREATE USER terraform SUPERUSER PASSWORD 'terraform';
CREATE DATABASE terraform_backend;
GRANT ALL PRIVILEGES ON DATABASE terraform_backend TO terraform;