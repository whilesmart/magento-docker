## Magento Docker Development Setup

### Usage Instructions

Follow these instructions to set up Magento 2 in a Docker development environment using Apache and PHP 8.1.

1. **Clone the Repository**:

    ```sh
    git clone git@github.com:whilesmart/magento-docker.git
    cd magento-docker
    mkdir code # Required for Magento2 code files
    ```

2. **Place your Magento 2 project** in the `code` directory:
    - Copy or clone your Magento 2 project into the `code` directory. The `code` directory will serve as the root of your Magento 2 installation.
    - You can use git tracking in the `code` directory for your actual Magento project if you like, since a `.gitignore` file is included with the line `code/` in it.

3. **Create `info.php` for testing**:
    - Create an `info.php` file in the `code/pub` directory with the following content:

      ```php
      <?php phpinfo(); ?>
      ```

    - Access this file in your browser at `http://localhost:8000/info.php` to verify your PHP settings and configuration.

4. **Build and start the Docker containers**:

    ```sh
    docker compose up --build
    ```

5. **Run Magento setup**:

    After the containers are up and running, execute the Magento setup within the web container:

    ```sh
    docker compose exec web bin/magento setup:install \
    --base-url=http://localhost:8000 \
    --db-host=db \
    --db-name=magento \
    --db-user=magento \
    --db-password=magento \
    --admin-firstname=admin \
    --admin-lastname=admin \
    --admin-email=admin@admin.com \
    --admin-user=admin \
    --admin-password=admin123 \
    --language=en_US \
    --currency=USD \
    --timezone=America/Chicago \
    --use-rewrites=1 \
    --search-engine=elasticsearch7 \
    --elasticsearch-host=elasticsearch \
    --elasticsearch-port=9200
    ```

6. **Access Magento**:

    - **Frontend**: [http://localhost:8000](http://localhost:8000)
    - **Backend**: [http://localhost:8000/admin](http://localhost:8000/admin) (use the admin credentials set during the setup)

### Project Structure

Your project directory should have the following structure:

```
project-root/
├── Dockerfile
├── docker-compose.yml
├── 000-default.conf
├── .gitignore
└── code/
    └── pub/
        └── info.php
```

### Advanced Configuration

#### Docker Setup Details

The provided Docker setup includes:

- **Apache**: Configured with mod_php to serve PHP files.
- **PHP 8.1**: Installed with necessary extensions for running Magento 2.
- **MySQL (MariaDB)**: As the database server.
- **Elasticsearch**: For the Magento search engine.

#### Directory Structure

```
project-root/
├── Dockerfile
├── docker-compose.yml
├── 000-default.conf
├── .gitignore
└── code/
    ├── app/
    ├── bin/
    ├── lib/
    ├── pub/
    │   └── info.php
    ├── var/
    └── vendor/
```

### Credits

This setup utilizes the `install-php-extensions` tool from [mlocati/docker-php-extension-installer](https://github.com/mlocati/docker-php-extension-installer).

### License

This project is licensed under the MIT License.