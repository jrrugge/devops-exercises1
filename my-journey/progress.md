# My DevOps Journey

Hands-on labs and projects on the way to a **cloud / platform engineering** role. Each section below is a course module I completed, with a screenshot of the finished lab and my own notes. The strongest piece of work is the end-to-end AWS project at the top.

- **Started:** _add start date_
- **GitHub:** [@jrrugge](https://github.com/jrrugge)
- **LinkedIn** [@jrrugge](https://www.linkedin.com/in/jrugge-/)

## Featured project: Smart Lead on AWS

I took a developer's Spring Boot source code, packaged it into a container image, designed an AWS platform for it and deployed it with Terraform and GitHub Actions: private networking, HTTPS on my own domain, a web application firewall and a pipeline with no stored AWS keys.

**[Read the case study](projects/01-smart-lead-aws/README.md)** · [Deep dive](projects/01-smart-lead-aws/deep-dive.md) · [How I built the image](#building-the-app-image)

## What is in this log

| # | Module | What I practised |
| --- | --- | --- |
| 01 | [Linux Fundamentals](#01-linux-fundamentals) | The terminal and shell, files and directories, users and groups, permissions |
| 02 | [Vim](#02-vim) | Editing in the terminal |
| 03 | [Linux for Professionals](#03-linux-for-professionals) | Pipes and redirection, environment variables, system administration, networking, SSH |
| 04 | [Shell Scripting](#04-shell-scripting) | Bash basics, conditions and loops, functions, error handling, automation |
| 05 | [Git and GitHub](#05-git-and-github-fundamentals) | Repositories, tracking changes, remotes |
| 06 | [Docker](#06-docker) | Containers, images, volumes, networking, Compose, two capstones, Smart Lead |
| Project | [Smart Lead on AWS](projects/01-smart-lead-aws/README.md) | Terraform, AWS, CI/CD, security |

Useful commands from these labs are in the [cheatsheet](cheatsheet.md).

---

## 01 Linux Fundamentals

### 01 The Terminal

<img width="1067" height="557" alt="Lab 01, The Terminal" src="https://github.com/user-attachments/assets/38b46f53-d753-4c37-8e8e-f2c2afb65375" />

### 02 The Shell

<img width="771" height="352" alt="Lab 02, The Shell" src="https://github.com/user-attachments/assets/783881e0-8656-4bce-84f7-9a925ae22cd8" />

Save the list of installed shells into the sandbox:

```bash
cat /etc/shells > ~/sandbox/shells.txt
```

Make zsh the shell I get on every login:

```bash
sudo chsh -s "$(which zsh)" $USER
```

Put settings in `~/.zshrc`: an alias, the theme, the team aliases and the git plugin:

```bash
cat > ~/.zshrc << 'EOF'
alias ll='ls -lah'
alias gs='git status'
alias k='kubectl get pods'
alias dc='docker compose'
ZSH_THEME="agnoster"
plugins=(git)
EOF
```

`ll` is a shortcut for `ls -lah`; `gs`, `k` and `dc` are the team shortcuts; `ZSH_THEME` picks a theme and `plugins=(git)` turns on the git plugin.

### 03 Linux Commands

<img width="1117" height="330" alt="Lab 03, Linux Commands" src="https://github.com/user-attachments/assets/e7118ca9-def6-4e4c-994f-4153b746e0be" />

```bash
ls -a ~/sandbox/files > ~/sandbox/hidden.txt            # all files, including hidden
date +%F > ~/sandbox/today.txt                           # today's date
apropos "space usage" > ~/sandbox/apropos-space.txt      # search man pages by keyword
which du > ~/sandbox/where-is-du.txt                     # locate a program
ls -l ~/sandbox/files > ~/sandbox/long.txt               # permissions, owner, size per file

# append the toolkit to ~/.zshrc
cat >> ~/.zshrc <<'EOF'
alias gl='git log --oneline'
alias dps='docker ps'
alias kgp='kubectl get pods'
EOF
```

### 04 The Linux File System

<img width="782" height="275" alt="Lab 04, The Linux File System" src="https://github.com/user-attachments/assets/ae7d1e54-f222-4f2f-9f78-c2f8f530cc32" />

### 05 Working with Files

<img width="790" height="367" alt="Lab 05, Working with Files" src="https://github.com/user-attachments/assets/4a11b0c4-fe41-4c4a-833e-0140c3f20e78" />

> **Note:** two checks in this lab looked like a grader problem. These commands worked when I inspected the results by hand, and the grader still would not pass them even after I created matching dummy files.
>
> ```bash
> touch part1.txt part2.txt
> cat ~/sandbox/part1.txt ~/sandbox/part2.txt > ~/sandbox/full.txt
> rm ~/sandbox/dump/*.tmp ~/sandbox/dump/core.dump
> ```

### 06 Working with Directories

<img width="852" height="445" alt="Lab 06, Working with Directories" src="https://github.com/user-attachments/assets/1db2129d-a4b6-4f08-ac42-5fecc182539d" />

### 07 Users and Groups

<img width="812" height="395" alt="Lab 07, Users and Groups" src="https://github.com/user-attachments/assets/ee5dc204-0a14-4207-a9ca-332537110477" />

### 08 File Permissions

<img width="826" height="446" alt="Lab 08, File Permissions" src="https://github.com/user-attachments/assets/6c85cf1d-c6c4-463f-bea2-0008ba4d5a9f" />

---

## 02 Vim

<img width="807" height="275" alt="Vim lab" src="https://github.com/user-attachments/assets/c8a81310-abdd-4cb0-950f-2678381f2082" />

---

## 03 Linux for Professionals

### 01 Redirection and pipes

<img width="1176" height="505" alt="Redirection and pipes lab" src="https://github.com/user-attachments/assets/edcc240e-3358-4f17-a0e2-373a151cd550" />

### 02 Environment variables

<img width="1161" height="331" alt="Environment variables lab" src="https://github.com/user-attachments/assets/6aa11bd6-6a05-43a0-8ac1-e519b7778461" />

### 03 System administration

<img width="1192" height="346" alt="System administration lab" src="https://github.com/user-attachments/assets/975322dc-24df-400f-b8f8-d525c5b51440" />

### 04 Networking

<img width="982" height="322" alt="Networking lab" src="https://github.com/user-attachments/assets/c34635ac-7b86-444a-b239-2390815a4161" />

### 05 SSH

<img width="1055" height="377" alt="SSH lab" src="https://github.com/user-attachments/assets/e913edd8-bbe6-4407-88bc-c6b91f100bba" />

---

## 04 Shell Scripting

### 01 Bash basics

<img width="1022" height="331" alt="Bash basics lab" src="https://github.com/user-attachments/assets/1cedaaf5-a9f7-4354-9147-604fe2e8d4e8" />

### 02 Conditions and loops

<img width="1040" height="267" alt="Conditions and loops lab" src="https://github.com/user-attachments/assets/e627d895-9559-4051-8040-738806ceef8c" />

### 03 Functions

<img width="1012" height="320" alt="Functions lab" src="https://github.com/user-attachments/assets/c62b6cd0-1ef4-44d5-a9c0-d16727f161cd" />

### 04 Error handling

<img width="982" height="290" alt="Error handling lab" src="https://github.com/user-attachments/assets/2675a1f1-5626-48cb-bb1d-0fc6a621679c" />

### 05 Files and automation

<img width="1021" height="307" alt="Files and automation lab" src="https://github.com/user-attachments/assets/37f69b0a-a3f9-4074-b2a2-be7fcb86f00e" />

---

## 05 Git and GitHub Fundamentals

### 01 First repo

<img width="965" height="275" alt="Git lab, first repo" src="https://github.com/user-attachments/assets/ad8c4936-68c6-4f71-8a25-479a4e71368d" />

### 02 Tracking changes

<img width="992" height="270" alt="Git lab, tracking changes" src="https://github.com/user-attachments/assets/67d38c2c-0712-4953-8526-b578901d6635" />

### 03 Remotes

<img width="940" height="311" alt="Git lab, remotes" src="https://github.com/user-attachments/assets/35b06c12-9189-4e03-929c-f23b29153ed8" />

### 04 Capstone

<img width="945" height="301" alt="Git capstone" src="https://github.com/user-attachments/assets/bd3e6234-3fa1-4dc1-a110-1abc1ddbc6a2" />

---

## 06 Docker

### 01 Containers

<img width="1065" height="350" alt="Docker lab, containers" src="https://github.com/user-attachments/assets/e9f85fbb-bd78-4837-97d6-8d6a219b06ae" />

### 02 Images

<img width="927" height="237" alt="Docker lab, images" src="https://github.com/user-attachments/assets/41d7cc43-143a-4d2b-903c-1dd405ee8727" />

### 03 Volumes

<img width="1021" height="277" alt="Docker lab, volumes" src="https://github.com/user-attachments/assets/8872f07d-915f-4ba8-828d-1a5d9b613ba7" />

### 04 Building images

<img width="1032" height="376" alt="Docker lab, building images" src="https://github.com/user-attachments/assets/82e1d3f2-c221-40ba-bb3f-489c33a2b887" />

### 05 Debugging

<img width="837" height="282" alt="Docker lab, debugging" src="https://github.com/user-attachments/assets/f352bce4-dc2c-4f0b-9019-65b0da1ff1f2" />

### 06 Networking and Compose

<img width="835" height="267" alt="Docker networking lab, first check" src="https://github.com/user-attachments/assets/b5401531-2e55-4393-bdf0-3c25ef42e541" />

<img width="1047" height="175" alt="Docker networking lab, second check" src="https://github.com/user-attachments/assets/e5516171-d910-4bb3-8434-769ea509a3d1" />

### 07 Capstone: full-stack app on Docker

A three-tier stack that combines building images, container networking and Compose:

```text
browser -> web (nginx UI, :8080) -> api (Python backend) -> db (Postgres, named volume)
```

nginx serves the UI and proxies API calls to the backend. The backend reads and writes a Postgres table, and the database keeps its data in a named volume so it survives restarts. I containerised the backend and wired the three services together with Docker Compose.

<img width="1005" height="370" alt="Full-stack capstone running" src="https://github.com/user-attachments/assets/ac2b3b18-0a4f-4ebe-aefc-ed600ee92105" />

### 08 Capstone: microservices

Multiple services, a database per service, service-to-service calls and one UI, all orchestrated with Docker Compose.

<img width="1192" height="387" alt="Microservices capstone, services running" src="https://github.com/user-attachments/assets/9128db73-759e-499f-8c75-cd1acc25ab5e" />

<img width="482" height="246" alt="Microservices capstone, result" src="https://github.com/user-attachments/assets/80916dc7-6bd0-44e5-b01f-c3ab0384ee18" />

**Why not run the database in a container in production?** A raw database container is a serious risk. Production microservices use a managed service such as AWS RDS, Google Cloud SQL or Azure SQL in a highly available, multi-AZ setup:

- The **primary** database handles all reads and writes.
- A **standby** "hot backup" sits in a separate physical data centre (Availability Zone), and data is copied to it by synchronous replication.
- On a failure in zone A, the provider fails over automatically to the standby in zone B within seconds, with no code change.
- The standby can sometimes serve reads to improve performance.

```text
              orders-service
                    |
      +-------------+-------------+   automatic failover
      v                           v
 Primary DB (AZ A)  --sync-->  Standby DB (AZ B)
 reads and writes              hot backup
```

### 09 Capstone: Smart Lead

Capstone submission. Repository: [devops-exercises1](https://github.com/jrrugge/devops-exercises1) · Project folder: [`06-docker/09-capstone-smart-lead`](../06-docker/09-capstone-smart-lead) · Completed 30 October 2026.

**This capstone is the starting point of the [Smart Lead on AWS project](projects/01-smart-lead-aws/README.md)**, where I took the same application and deployed it to AWS.

#### How to run it

```bash
git clone https://github.com/jrrugge/devops-exercises1.git
cd devops-exercises1/06-docker/09-capstone-smart-lead

# the config override: in cloud deployments these values live in Secrets Manager
cp env.example .env

# bring the whole system up
docker compose up --build -d
```

<img width="1025" height="155" alt="docker compose up output" src="https://github.com/user-attachments/assets/89be90bb-1f22-49af-9c29-37aeac6cf1c5" />

- Messages from potential leads are received at `http://localhost:8080/api/v1/messages`.
- Qualified leads are fetched from `http://localhost:8080/api/v1/leads`.

#### Prove it works

```bash
# submit a message: this populates the queue and the database
curl -X POST localhost:8080/api/v1/messages \
  -H 'Content-Type: application/json' \
  -d '{"content":"How much does the pro plan cost?"}'

# a qualified lead should now appear
curl localhost:8080/api/v1/leads
```

<img width="1175" height="197" alt="Message submitted and qualified lead returned" src="https://github.com/user-attachments/assets/f9047fd5-e546-42d4-ba7a-e5e016dd882d" />

#### Design decisions

##### Building the app image

**Base images, and single or multi-stage:** the `pom.xml` dictates the base images, because it lists what the app needs to compile and run. Its `<java.version>21</java.version>` tag says the app is written for Java 21, so I needed images that support Java 21: `maven:3.9.6-eclipse-temurin-21-jammy` to compile and `eclipse-temurin:21-jre-jammy` to run. I separated compilation from execution with a **multi-stage build**: the heavy Maven tooling and source code are discarded after the jar is built, and only the jar is copied into a lightweight JRE image. That keeps the final image small and secure. Reading the requirements from the project's own blueprint means the container matches the environment the application expects.

##### Pointing the app at the containers

I used Spring Boot's relaxed binding to override defaults in `application.properties` with uppercase environment variables set in `docker-compose.yml`. The compose file reads its values from the `.env` file, which keeps secrets out of the repository. The defaults point at `localhost` for every service, so I redirected `SPRING_DATASOURCE_URL` and `SPRING_CLOUD_AWS_SQS_ENDPOINT` to the internal container hostnames (`db` and `localstack`). I set `ENABLE_FAKE_HF=true` to switch on the offline AI stub, mirrored a literal upstream typo in `AWS_QUEQUE_URL`, and turned off the `MANAGEMENT_OTLP` exports so the logs stay focused on the application.

##### Startup ordering

A plain `depends_on` only tracks whether a process has started. Instead I added a health check per service: `pg_isready` for the database and a `curl -f` against LocalStack's health endpoint (`/_localstack/health`). The app's `depends_on` requires `condition: service_healthy` for both, so the Spring Boot container waits until the database and queue are ready to accept traffic, and does not crash on start.

##### The queue

The SQS queue is created automatically on startup through LocalStack's `SQS_QUEUES=message-analysis-queue` setting in the compose file. The app finds it over the internal Docker network using `AWS_QUEQUE_URL` and `APP_QUEUE_NAME`, which resolve to the LocalStack container.

##### The AI call

I ran without a real HuggingFace key by setting `ENABLE_FAKE_HF=true`, which switches on the built-in offline mock analyzer. In production, a developer would set it to `false` and pass the token through an untracked `.env` file as `HF_TOKEN`, which Spring Boot picks up at start-up, so there is no image edit and no committed secret.

##### Persistence

The database data lives in `/var/lib/postgresql/data` inside the container, mapped to a Docker-managed named volume, `postgres_data`, on my machine. I confirmed it survives a restart by sending a message with `curl`, checking a lead was created, running `docker compose down` to remove the containers, then `docker compose up -d` and fetching `http://localhost:8080/api/v1/leads` again. It returned the same records.

#### Reflection

- **Which `application.properties` values did I override, and why?** `SPRING_DATASOURCE_URL` and `SPRING_CLOUD_AWS_SQS_ENDPOINT`, to point at the container hostnames (`db`, `localstack`) so the containers talk across the Docker network and the app runs anywhere Docker is installed. `AWS_QUEQUE_URL`, to route the SQS listeners correctly. `ENABLE_FAKE_HF`, set to `true` so the app works for peer review without external keys.
- **How did I guarantee the app waits for the database and queue?** Health checks plus `condition: service_healthy`. See [Startup ordering](#startup-ordering).
- **Where does the data live, and how did I prove it survives?** See [Persistence](#persistence).
- **How would I switch to a real HuggingFace key without changing the image?** See [The AI call](#the-ai-call).
- **What would I improve?** Add an nginx reverse proxy container to terminate TLS.

#### What happened next

The "next steps" for this capstone were to deploy it to AWS, first as-is and then in an AWS-native form, with a real SQS service and a separate Postgres database in its own subnets, designed for high availability, scalability and security. That is the [Smart Lead on AWS project](projects/01-smart-lead-aws/README.md).

---

## Key takeaways

- **Read the application's own build file to choose the runtime.** The `pom.xml` told me the Java version, and so the base images.
- **Build in layers and verify each one** before starting the next.
- **Check the real state, not just the plan.** An unsaved file once cost me an hour of debugging a load balancer.
- **Short-lived credentials beat stored keys.** GitHub Actions authenticates to AWS with OIDC, with nothing stored.
- **Know what `destroy` removes.** It deleted my image registry once.

## Gotchas that confused me

- The Linux "Working with Files" lab grader rejected correct commands (see the [note](#05-working-with-files)).
- GitHub's OIDC token subject includes numeric IDs, so a trust policy written from the classic format is rejected.
- A Maven wrapper committed from Windows loses its execute bit, which breaks a Linux CI runner.

The full list is in the [case study deep dive](projects/01-smart-lead-aws/deep-dive.md#challenges-and-how-i-solved-them).
