

## 📌 Project Overview

This project demonstrates a complete **DevOps pipeline** using modern tools and practices. It covers:

* Continuous Integration & Continuous Deployment (CI/CD)
* Containerization using Docker
* Deployment on AWS EC2
* Monitoring using Prometheus and Grafana
* Automated build and deployment using Jenkins

## 🛠️ Tech Stack

* Git & GitHub
* Jenkins
* Docker
* Docker Hub
* AWS EC2 (Ubuntu)
* Prometheus
* Node Exporter
* Grafana

 ⚙️ Step-by-Step Implementation

 1️⃣ Launch EC2 Instance

* Launch Ubuntu EC2 instance
* Configure Security Group:

  * 22 → SSH
  * 80 → Application
  * 3000 → Grafana
  * 9090 → Prometheus
  * 9100 → Node Exporter

2️⃣ Install Required Tools

```bash
sudo apt update
sudo apt install -y docker.io git
sudo systemctl start docker
sudo systemctl enable docker
```
 3️⃣ Setup Jenkins

```bash
sudo apt install openjdk-17-jdk -y
```

Added Jenkins repository and installed:

```bash
sudo apt install jenkins -y
sudo systemctl start jenkins
```

Access Jenkins:

```
http://54.215.250.241:8080
```

---

### 4️⃣ Clone Application Code

```bash
git clone https://github.com/sriram-R-krishnan/devops-build
cd React-Application

### 5️⃣ Create Dockerfile

```dockerfile
FROM node:18 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:latest
COPY --from=build /app/build /usr/share/nginx/html
```

---

### 6️⃣ Build Docker Image

```bash
docker build -t dev-app .
```

---

### 7️⃣ Push Image to Docker Hub

```bash
docker tag dev-app <subashreedocker>/dev-app:latest
docker login
docker push <subashreedocker>/dev-app:latest
```

---

### 8️⃣ Jenkins Pipeline

```groovy
pipeline {
    agent any

    stages {

        stage('Clone Code') {
            steps {
                git 
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t <subashreedocker>/dev-app:latest .'
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                docker login -u <subashreedocker> -p <password>
                docker push <subashreedocker>/dev-app:latest
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker rm -f react-container || true
                docker run -d -p 80:80 --name react-container<subashreedocker>/dev-app:latest
                '''
            }
        }
    }
}
```

---

 9️⃣ Install Node Exporter

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
tar xvf node_exporter-1.8.1.linux-amd64.tar.gz
cd node_exporter-1.8.1.linux-amd64
./node_exporter &
```

Access:

```
http://<>:9100/metrics
```

---

### 🔟 Install Prometheus

```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
tar xvf prometheus-2.52.0.linux-amd64.tar.gz
cd prometheus-2.52.0.linux-amd64
```

Edit config:

```yaml
scrape_configs:
  - job_name: "node-exporter"
    static_configs:
      - targets: ["localhost:9100"]
```

Run:

```bash
./prometheus
```

Access:

```
http://54.215.250.241:9090
```

---

### 1️⃣1️⃣ Install Grafana

```bash
sudo apt install grafana -y
sudo systemctl start grafana-server
```

Access:

```
http://54.215.250.241:3000
```

Default login:

```
admin / admin
```

---

### 1️⃣2️⃣ Connect Grafana to Prometheus

* Add Data Source → Prometheus
* URL:

```
http://54.215.250.241:9090
```

* Import Dashboard → Node Exporter Dashboard

---

## 🔔 Monitoring & Alerts

* Prometheus collects metrics
* Node Exporter provides system data
* Grafana visualizes dashboards
* Alerts can be configured using Alertmanager

---

## ✅ Features

✔ Automated CI/CD pipeline
✔ Dockerized React application
✔ Deployment on AWS EC2
✔ Real-time monitoring
✔ Dashboard visualization
✔ Scalable architecture

---

## 📸 Output

* Application: `http://54.215.250.241
* Grafana: `http://54.215.250.241:3000`
* Prometheus: `http://54.215.250.241:9090`

---

## 🙌 Conclusion

This project demonstrates a complete DevOps lifecycle from code commit to deployment and monitoring. It showcases real-world implementation of CI/CD pipelines and observability tools.

---


