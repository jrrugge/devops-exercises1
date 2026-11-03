# My DevOps Journey

- **Started:** _YYYY-MM-DD_
- **GitHub:** @jrrugge

> Log what you learn as you go. Commit + push to your fork after each session.

---

## 01 · Linux Fundamentals

- [ ] 01 - The Terminal

<img width="1067" height="557" alt="image" src="https://github.com/user-attachments/assets/38b46f53-d753-4c37-8e8e-f2c2afb65375" />

- [ ] 02 - The Shell
 
<img width="771" height="352" alt="image" src="https://github.com/user-attachments/assets/783881e0-8656-4bce-84f7-9a925ae22cd8" />

Commands: 
1.1. Save the list of installed shells:
cat /etc/shells

cat /etc/shells > ~/sandbox/shells.txt
That file is /etc/shells. The line above copies it into your sandbox.

2.1. Make zsh the shell you get every time you log in:
sudo chsh -s "$(which zsh)" $USER

Put your settings in ~/.zshrc. Covers the alias, the theme, the team aliases, and the git plugin:

cat > ~/.zshrc << 'EOF'
alias ll='ls -lah'
alias gs='git status'
alias k='kubectl get pods'
alias dc='docker compose'
ZSH_THEME="agnoster"
plugins=(git)
EOF

ll is a shortcut for ls -lah. gs, k, and dc are the team shortcuts. ZSH_THEME picks a theme. plugins=(git) turns on the git plugin.

- [ ] 03 - Linux Commands

<img width="1117" height="330" alt="image" src="https://github.com/user-attachments/assets/e7118ca9-def6-4e4c-994f-4153b746e0be" />

history
1. find all the files flag
ls -a (--all)
ls -a ~/sandbox/files > ~/sandbox/hidden.txt

1.2 date
date +%F > ~/sandbox/today.txt

2 search man page descriptions by keyword
apropos "space usage" > ~/sandbox/apropos-space.txt

locate the program
which du > ~/sandbox/where-is-du.txt

man ls
ls -l ~/sandbox/files > ~/sandbox/long.txt #show permissions, owner, sixe per file

append the toolkit to ~/.zhrc
cat >> ~/.zhrc <<'EOF'
alias gl='git log --oneline'
alias dps='docker ps'
alias kgp='kubectl get pods'
EOF

- [ ] 04 - The Linux File System

<img width="782" height="275" alt="image" src="https://github.com/user-attachments/assets/ae7d1e54-f222-4f2f-9f78-c2f8f530cc32" />
  
- [ ] 05 - Working with Files

<img width="790" height="367" alt="image" src="https://github.com/user-attachments/assets/4a11b0c4-fe41-4c4a-833e-0140c3f20e78" />

**>Below 2 issues i think are a possible issue with the grader**
lab might be broken as the commands used here clearly work when i manually inspect
touch part1.txt part2.txt
cat ~/sandbox/part1.txt ~/sandbox/part2 > ~/sandbox/full.txt

rm ~/sandbox/dump/*.tmp ~/sandbox/dump/core.dump  - these files didnt exist, went further to create summy tmp files with the same setup and grader still wont pass this 
   
- [ ] 06 - Working with Directories

<img width="852" height="445" alt="image" src="https://github.com/user-attachments/assets/1db2129d-a4b6-4f08-ac42-5fecc182539d" />


- [ ] 07 - Users & Groups

<img width="812" height="395" alt="image" src="https://github.com/user-attachments/assets/ee5dc204-0a14-4207-a9ca-332537110477" />


- [ ] 08 - File Permissions

<img width="826" height="446" alt="image" src="https://github.com/user-attachments/assets/6c85cf1d-c6c4-463f-bea2-0008ba4d5a9f" />


## 02 · Vim

<img width="807" height="275" alt="image" src="https://github.com/user-attachments/assets/c8a81310-abdd-4cb0-950f-2678381f2082" />


## 03 · Linux for Professionals

01-redirection-and-pipes

<img width="1176" height="505" alt="image" src="https://github.com/user-attachments/assets/edcc240e-3358-4f17-a0e2-373a151cd550" />


02-environment-variables

<img width="1161" height="331" alt="image" src="https://github.com/user-attachments/assets/6aa11bd6-6a05-43a0-8ac1-e519b7778461" />


03-system-admin

<img width="1192" height="346" alt="image" src="https://github.com/user-attachments/assets/975322dc-24df-400f-b8f8-d525c5b51440" />


04-networking

<img width="982" height="322" alt="image" src="https://github.com/user-attachments/assets/c34635ac-7b86-444a-b239-2390815a4161" />


05-ssh

<img width="1055" height="377" alt="image" src="https://github.com/user-attachments/assets/e913edd8-bbe6-4407-88bc-c6b91f100bba" />

## 04 Shell Scripting

01 - bash basics

<img width="1022" height="331" alt="image" src="https://github.com/user-attachments/assets/1cedaaf5-a9f7-4354-9147-604fe2e8d4e8" />



02 - conditions-and-loops

<img width="1040" height="267" alt="image" src="https://github.com/user-attachments/assets/e627d895-9559-4051-8040-738806ceef8c" />


03-functions

<img width="1012" height="320" alt="image" src="https://github.com/user-attachments/assets/c62b6cd0-1ef4-44d5-a9c0-d16727f161cd" />


04-error-handling

<img width="982" height="290" alt="image" src="https://github.com/user-attachments/assets/2675a1f1-5626-48cb-bb1d-0fc6a621679c" />


05-files-and-automation

<img width="1021" height="307" alt="image" src="https://github.com/user-attachments/assets/37f69b0a-a3f9-4074-b2a2-be7fcb86f00e" />



### 05 Git-Github Fundamentals

01 - First repo

<img width="965" height="275" alt="image" src="https://github.com/user-attachments/assets/ad8c4936-68c6-4f71-8a25-479a4e71368d" />

02 - Tracking changes

<img width="992" height="270" alt="image" src="https://github.com/user-attachments/assets/67d38c2c-0712-4953-8526-b578901d6635" />


03 - Remotes

<img width="940" height="311" alt="image" src="https://github.com/user-attachments/assets/35b06c12-9189-4e03-929c-f23b29153ed8" />


04 - Capstone


<img width="945" height="301" alt="image" src="https://github.com/user-attachments/assets/bd3e6234-3fa1-4dc1-a110-1abc1ddbc6a2" />



### 06 Docker


01 - Containers

<img width="1065" height="350" alt="image" src="https://github.com/user-attachments/assets/e9f85fbb-bd78-4837-97d6-8d6a219b06ae" />


02 - Images

<img width="927" height="237" alt="image" src="https://github.com/user-attachments/assets/41d7cc43-143a-4d2b-903c-1dd405ee8727" />


03 - Volumes

<img width="1021" height="277" alt="image" src="https://github.com/user-attachments/assets/8872f07d-915f-4ba8-828d-1a5d9b613ba7" />


04 - Building Images

<img width="1032" height="376" alt="image" src="https://github.com/user-attachments/assets/82e1d3f2-c221-40ba-bb3f-489c33a2b887" />


05 - Debugging

<img width="837" height="282" alt="image" src="https://github.com/user-attachments/assets/f352bce4-dc2c-4f0b-9019-65b0da1ff1f2" />



06 - Networking and compose

<img width="835" height="267" alt="Screenshot 2026-10-26 225120" src="https://github.com/user-attachments/assets/b5401531-2e55-4393-bdf0-3c25ef42e541" />

<img width="1047" height="175" alt="Screenshot 2026-10-26 225248" src="https://github.com/user-attachments/assets/e5516171-d910-4bb3-8434-769ea509a3d1" />

<img width="835" height="267" alt="Screenshot 2026-10-26 225120" src="https://github.com/user-attachments/assets/91a8859c-38ba-4b15-b7ce-ef2f5ccc10cc" />



07 - Capstone: Full-Stack App on Docker

Pulls together Sections 6, 10 & 11: building images, container networking, and Docker Compose - the way a real service is actually shipped.

This is the payoff. Stand up a real three-tier stack:

browser ->  web (nginx UI)  ->  api (Python backend)  ->  db (Postgres)
                 :8080              service name "api"        named volume

The UI is served by nginx and proxies API calls to the backend. The backend reads and writes a Postgres table. The database keeps its data in a named volume so it survives restarts. You will containerize the backend and wire all three together with Docker Compose - exactly the shape of most production apps.

<img width="1005" height="370" alt="image" src="https://github.com/user-attachments/assets/ac2b3b18-0a4f-4ebe-aefc-ed600ee92105" />



08 - Capstone microservices

The advanced capstone. Everything from the course, on a real microservices architecture: multiple services, a database per service, service-to-service calls, and one UI - all orchestrated with Docker Compose.

<img width="1192" height="387" alt="image" src="https://github.com/user-attachments/assets/9128db73-759e-499f-8c75-cd1acc25ab5e" />



<img width="482" height="246" alt="image" src="https://github.com/user-attachments/assets/80916dc7-6bd0-44e5-b01f-c3ab0384ee18" />
            



Note: running a database in a raw container in production is a massive risk. Instead of managing postgres in docker, production microservices offload this to cloud providers like
AWS RDS, Google Cloud SQL, Azure SQL and configured in a high available, multi-az setup. Where the primary database handles 100% or reads and writes. A standby database "hot backup" sitting in a completely separate physical data centre (Availability Zone). 
Data is copied here instantly using synchronous replication.
Automatic Failover: If the data centre housing Zone A loses power or suffers a networking hardware failure, the cloud provider automatically switches your orders-service connection to the Standby DB in Zone B. This swap takes seconds and requires zero code changes.
At times the standy may be used for reads to improve user experience.

               ┌────────────────────────┐
               │    orders-service      │
               └───────────┬────────────┘
                           │
             ┌─────────────┴─────────────┐ (Automatic Failover)
             ▼                           ▼
    ┌─────────────────┐         ┌─────────────────┐
    │ Primary DB      │         │ Standby DB      │
    │ (Availability   │────────►│ (Availability   │
    │  Zone A - Read/ │ Synchronous│  Zone B - Hot   │
    │  Write)         │ Replication│  Backup)        │
    └─────────────────┘         └─────────────────┘


## 09 - Capstone Smart Lead


Submission - Smart Lead Capstone
Copy this file into the root of your solution repository and fill it in. Keep it honest and concise - the reviewer reads this first.

Name: skool.com/@john-rugge-4911
Solution repository: repo: https://github.com/jrrugge/devops-exercises1
                      Smart Lead Capstone: https://github.com/jrrugge/devops-exercises1/tree/main/06-docker/09-capstone-smart-lead
Date: : 30/10/2026
How to run it
The reviewer will run exactly what you put here, on a machine with only Docker.

# clone
git clone https://github.com/jrrugge/devops-exercises1.git
cd devops-exercises1/06-docker/09-capstone-smart-lead

rename the provided env.example file to env, the config override - in cloud deployments secrets would be set in secrets manager
cp env.example .env


# bring the whole system up
docker compose up --build -d
<img width="1025" height="155" alt="image" src="https://github.com/user-attachments/assets/89be90bb-1f22-49af-9c29-37aeac6cf1c5" />

As above first set first env.exampleto.env`):

URL / port the API is on:

App receives messages from potential leads on: http://localhost:8080/api/v1/messages

Qualified leads can be fetched here: http://localhost:8080/api/v1/leads

Submit a message to populate the queue and database
curl -X POST http://localhost:8080/api/v1/messages
-H "Content-Type: application/json"
-d "{"content":"How much does the pro plan cost?"}" See example below 

Verify the qualified lead was safely generated and stored
curl http://localhost:8080/api/v1/leads See example below

Prove it works
Paste the commands you use to demonstrate the end-to-end flow, and what you expect to see: 

# submit a message
curl -X POST localhost:8080/api/v1/messages \
  -H 'Content-Type: application/json' \
  -d '{"content":"How much does the pro plan cost?"}'

# then a lead should appear
curl localhost:8080/api/v1/leads
<img width="1175" height="197" alt="image" src="https://github.com/user-attachments/assets/f9047fd5-e546-42d4-ba7a-e5e016dd882d" />
Design decisions (the important part)
Explain the choices you made and why. A few sentences each.

Building the app image - what base image(s), single or multi-stage, and why: The pom.xml file dictates our base image choices because it lists the strict technical requirements the app needs to compile and run. Inside the pom.xml, the <java.version>21</java.version> tag explicitly tells us the app is coded in Java 21. Because of this rule, we are forced to use Docker images that natively support Java 21, leading directly to our choices of maven:3.9.6-eclipse-temurin-21-jammy for compiling the code and eclipse-temurin:21-jre-jammy for running it. We separated the compilation from the execution i.e multi-stage build. By discarding the heavy Maven tools and source code after building the jar file, and copying only the final app jar into a lightweight JRE runner, we keep the final image incredibly lean, small, and secure for production. By reading these rules directly from the project's blueprint i.e pom file, we ensure our containers match the exact environment the application expects.

Pointing the app at the containers - which application.properties values you overrode, and how you passed them in: I used spring boot's 'relaxed binding' mechanism to override the defaults inside application.properties by injecting uppercase environment variables directly through docker-compose.yml file, the docker-compose file also uses dynamic variable which point to the .env file to keep secret from being pushed into code repos. The appplication.properties file shows the default network settings point to localhost for all services so I redirected network traffic away from localhost by pointing SPRING_DATASOURCE_URL and SPRING_CLOUD_AWS_SQS_ENDPOINT directly to our internal container service hostnames (db and localstack). I then set ENABLE_FAKE_HF=true to toggle the offline AI stub, mirrored a literal upstream typo via AWS_QUEQUE_URL, and muted background connection noise by setting the MANAGEMENT_OTLP export variables to false for ease reviewing logs directly related to the application during build and troubleshooting.

Startup ordering - how you made the app wait for the database and queue to be ready (not just started): I did this by using docker compose health checks per service paired with dependency routing. Instead of a basic depends_on which only tracks if a process has started, I added explicit validation scripts using pg_isready for the db and a core curl -f request against LocalStack health diagnostic endpoint (/_localstack/health). By setting the app’s depends_on config to require condition: service_healthy for both backing components, the Spring Boot container automatically remains in a locked wait-state, preventing startup crashes until the infrastructure sockets are fully initialized and ready to accept traffic.

The queue - how it gets created and how the app finds it: The SQS queue is created automatically on startup by leveraging LocalStack's native container engine configuration via the SQS_QUEUES=message-analysis-queue environment variable in our Compose file. The application then dynamically discovers this queue over the internal Docker network mesh by using Spring's Relaxed Binding properties (AWS_QUEQUE_URL and APP_QUEUE_NAME), which resolve straight to the LocalStack service container endpoint.

The AI call - how you ran without a real HuggingFace key, and how a real key would be supplied: I ran the application without a real HuggingFace key by setting the ENABLE_FAKE_HF=true environment variable in our docker-compose.yml file, which instantly toggles the project’s built-in offline mock analyzer. To use a real key in production without editing the image or committing secrets, a developer would switch that variable to 'false' and securely pass the token via an untracked local .env file mapped to HF_TOKEN, auto picked up by spring boot at boot time.

Persistence - where the database data lives and how you confirmed it survives a restart:

The database data physically lives inside the container at /var/lib/postgresql/data, which is mapped out to an isolated, docker-managed 'named disk volume called postgres_data on the host 'my local machine'. [postgres_data:/var/lib/postgresql/data] Confirmed durability by writing a message using curl, verifying it created a lead, and then executing a strict docker compose down to completely delete the running container infrastructure from memory. After running docker compose up -d to rebuild the stack, a final curl http://localhost:8080/api/v1/leads request returned the identical records, proving the data survives independent container reboots. See below


Reflection
Answer the questions from the capstone README:

Which application.properties values did you override, and why those exactly? SPRING_DATASOURCE_URL & SPRING_CLOUD_AWS_SQS_ENDPOINT: Redirected away from localhost to point directly to our container service hostnames (db and localstack) so the containers could communicate across the docker internal bridge network mesh, enabling the app to run anywhere docker is installed. AWS_QUEQUE_URL: Overridden exactly in the original file to safely route spring SQS listeners. ENABLE_FAKE_HF: Switched to true to activate the offline mock analyzer stub, ensuring the platform works immediately for peer review purposes without external API keys.
How did you guarantee the app does not start before the database and queue are ready, and how is that different from a plain depends_on? see 4. health checks and dependency routing
Where does the database data live, and how did you prove it survives a restart? see 8. persistence above
How would you switch from the AI stub to a real HuggingFace key without changing the image or committing a secret? see 7 above.
What did you do to keep the final image small and safe, and what would you improve with more time? With more time i would set up an Nginx reverse proxy container layer to safely handle upstream SSL/TLS certificate termination.



### Notes & takeaways
-

### Commands I want to remember
```bash
(Working with directories) Folder build: mkdir -p release/v2/{bin,config,logs} && touch release/v2/VERSION
(Working with directories) Archiving: - zip -r ~/sandbox/release-v2.zip release/
sudo useradd -m [name]
passwd [name]
userdel rf [name]
sudo adduser [name] sudo (add user to sudoers)
sudo passwd [name]
sudo usermod -aG ops [name] (add to group)
or sudo adduser [name] ops
sudo gpasswd -d [name] ops (remove user from group)
sudo group add [group name]
sudo groupdel legacy  (delete an old group)
groups (list groups)
less -X /etc/group
id, id [name]
su i, su [name]

(executble and runs a command 'greet')
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
sed -i '/export PATH="\$HOME\/bin"/d' ~/.bashrc
sed -i '/export PATH="\$HOME\/bin:\$PATH"/d' ~/.bashrc
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
sudo vi ~/.bashrc
source ~/.bashrc
mkdir -p ~/bin
echo -e '#!/bin/bash\necho "ready to deploy"' > ~/bin/greet
chmod +x ~/bin/greet

~/.ssh/config setup commands
# Ensure the .ssh folder has secure permissions
chmod 700 ~/.ssh

# Write the exact configuration using the precise hint keywords
cat << 'EOF' > ~/.ssh/config
Host myserver
    HostName 1.2.3.4
    User student
    IdentityFile ~/.ssh/id_rsa

Host prod
    HostName 5.6.7.8
    User ubuntu
    Port 22
    IdentityFile ~/.ssh/prod_key.pem
EOF

# Set owner read/write permissions for Tier 2
chmod 600 ~/.ssh/config
student@2950e2c71bab:~/sandbox$ exit
```

### Gotchas / things that confused me
-

---

<!-- Copy the block above for each new course you start. -->
