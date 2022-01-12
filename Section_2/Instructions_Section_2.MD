# DSAID Data Engineering Technical Test (Section 2)

1. You may access my `docker` image in the repository for DSAID Data Engineering Technical Test's section 2 at [here](https://hub.docker.com/repository/docker/jingyuanpeh/govtech-section_2-postgres)
2. Alternatively, you can simply pull my docker image using: `docker pull jingyuanpeh/govtech-section_2-postgres:1.0`

## Steps
**Using persisted DB**
1. After pulling the image, use `docker exec -it govtech-section_2-postgres bash`
2. Login as postgres user `psql -U postgres`. When prompted for password, type in 'password'.
3. Use `\c carshop` to connect to carshop database
4. Refer to the ER diagram and DDL for more information on the DB.
5. You can also refer to [this](https://github.com/JingYuan-Peh/GovTech_DE_Assignment/blob/main/Section_2/Section_2_Queries.sql) to run and get the answers for this section.

## Set up
**Not using the image from my repo**
1. To setup the docker container without using persisted DB, firstly set up a PostgreSQL database using the base `docker` image using `docker pull postgres:alpine`
2. Spin up a postgres image using `docker run --name govtech-section_2-postgres -d -p 5432:5432 -e POSTGRES_PASSWORD=password -e POSTGRES_USER=postgres -e PGDATA=/var/lib/postgresql/data -v pgdata:/var/lib/postgresql/data postgres:alpine`
3. Run `docker exec -it govtech-section_2-postgres bash` to enable Bash
4. Login as postgres user `psql -U postgres`. When prompted for password, type in 'password'.
5. Run the DDL script [here](https://github.com/JingYuan-Peh/GovTech_DE_Assignment/blob/main/Section_2/Section_2_DDL.sql)
