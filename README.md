# 🛂 WhatIsWrong

WhatIsWrong is a web application designed to help users identify and troubleshoot issues with their applications and systems.
It provides a user-friendly interface for tracking problems by collecting error messages from various applications and grouping them in a single centralized location.

> Supported architectures: `amd64`, `arm64`

You can find a live demo of the application [here](https://whatiswrong-demo.zanotn.space/), with the following credentials:

- **Username**: `demo_user`
- **Password**: `demo_password`

## 🐳 Installation (Docker only)

The application requires Docker to be installed on your machine.
Why Docker? Because it simplifies the setup process and ensures that all dependencies are correctly configured.

How to install Docker:

- For Windows and Mac: Download and install Docker Desktop from [here](https://www.docker.com/products/docker-desktop).
- For Linux: Follow the instructions for your specific distribution from [here](https://docs.docker.com/engine/install/).

### Choosing a the correct docker compose configuration

- **Postgres**:
  - App + DB + Auto update: [docker-compose.postgres.app-db-auto-update.yml](https://github.com/ZanoTN/whatiswrong/blob/main/docker_compose_configs/docker-compose.postgres.app-db-auto-update.yml)
  - App + DB: [docker-compose.postgres.app-db.yml](https://github.com/ZanoTN/whatiswrong/blob/main/docker_compose_configs/docker-compose.postgres.app-db.yml)
  - App + Auto update: [docker-compose.postgres.app-auto-update.yml](https://github.com/ZanoTN/whatiswrong/blob/main/docker_compose_configs/docker-compose.postgres.app-auto-update.yml)
  - App only: [docker-compose.postgres.app.yml](https://github.com/ZanoTN/whatiswrong/blob/main/docker_compose_configs/docker-compose.postgres.app.yml)

- **SQLite** (Not supported for now):
  - App + DB + Auto update: [docker-compose.postgres.app-db-auto-update.yml]()
  - App + DB: [docker-compose.postgres.app-db.yml]()

- **MySQL** (Not supported for now):
  - App + DB + Auto update: [docker-compose.mysql.app-db-auto-update.yml]()
  - App + DB: [docker-compose.mysql.app-db.yml]()
  - App + Auto update: [docker-compose.mysql.app-auto-update.yml]()
  - App only: [docker-compose.mysql.app.yml]()

### Running the application

1. Open a terminal and navigate to the directory where the `docker-compose` file is located.
2. Run the following command to start the application:

```bash
docker-compose -f <your-chosen-docker-compose-file.yml> up -d
```

3. The application will be accessible at `http://localhost:8085`.

## 🤝 Contributing

Contributions are welcome! If you have any ideas for improvements or want to report a bug, please open an issue or submit a pull request.

### Start developing locally

1. Clone the repository.
2. Use VS Code Dev Containers to open the project in a containerized development environment.
3. Run migrations and start the application using "rails server" command.
4. (Optional) Some data can be created using the command `rails runner "DemoService.run"`.
