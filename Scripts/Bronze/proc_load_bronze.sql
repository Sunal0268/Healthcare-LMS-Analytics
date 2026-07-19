## Bronze Layer Data Loading

The Bronze layer stores raw source data without applying any transformations.

During development, the datasets were generated as CSV files using Python and imported into PostgreSQL using the pgAdmin Import/Export tool.

A stored procedure (`proc_load_bronze.sql`) was initially developed to automate file ingestion using PostgreSQL's `COPY` command. However, PostgreSQL restricts server-side access to local user directories on Windows due to security permissions. Since this project is designed for local execution, the Import/Export tool was used for Bronze ingestion instead.

In a production environment, this manual import step would typically be replaced by an orchestration tool such as Azure Data Factory, Apache Airflow, SSIS, or another ETL platform to automate data ingestion into the Bronze layer.

The transformation pipeline (Bronze → Silver → Gold) remains unchanged and accurately reflects a Medallion Architecture.
