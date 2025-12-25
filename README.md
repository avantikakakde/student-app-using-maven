  
# 🎓 Student App – DevOps CI/CD Automation Project 🚀

A **Java-based Student Management Web Application** deployed using a **fully automated CI/CD pipeline** built with **Git, GitHub, Jenkins, Maven, AWS EC2 (Ubuntu), and Apache Tomcat**.

This project demonstrates how modern **DevOps practices** can be applied to automate the complete application lifecycle — from **code commit to production deployment** — with zero manual intervention.

---

## 📌 About the Project

The **Student App** is a simple Java web application that allows users to submit and manage student information such as:

- Student Name  
- Address  
- Age  
- Qualification  
- Percentage  
- Year of Passing  

The primary objective of this project is **CI/CD automation**, not application complexity.  
It serves as a **real-world DevOps use case** for deploying Java applications using Jenkins pipelines and AWS infrastructure.

---

## 🎯 Project Goals

- Implement Continuous Integration using Jenkins
- Automate WAR file creation using Maven
- Deploy the application automatically on Apache Tomcat
- Use AWS EC2 instances for Jenkins and application hosting
- Enable secure, passwordless deployment using SSH

---

## ⚙️ Technology Stack

| Category | Tools |
|--------|------|
| Programming Language | Java |
| Build Tool | Maven |
| Version Control | Git, GitHub |
| CI/CD Tool | Jenkins |
| Cloud Platform | AWS EC2 (Ubuntu 22.04) |
| Application Server | Apache Tomcat 10 |
| Pipeline Type | Jenkins Declarative Pipeline |

---

## 🔄 CI/CD Workflow

1. Developer modifies code locally
2. Code is pushed to GitHub (master branch)
3. Jenkins detects changes automatically
4. Maven builds the project and generates a `.war` file
5. Jenkins transfers the WAR file to the Tomcat EC2 server
6. Tomcat service restarts automatically
7. Updated application is available on the browser

---

## 🧰 Jenkins Pipeline (Jenkinsfile)

The Jenkins pipeline performs the following stages:

- **Checkout** – Pulls the latest code from GitHub  
- **Build** – Compiles and packages the application using Maven  
- **Deploy** – Copies the WAR file to the Tomcat server and restarts the service  

This ensures consistent and reliable deployments every time.

---

## ☁️ AWS EC2 Infrastructure

| Instance | Purpose | Configuration |
|--------|--------|--------------|
| EC2 Instance 1 | Jenkins Server | Ubuntu 22.04, Jenkins, Java, Maven, Git |
| EC2 Instance 2 | Application Server | Ubuntu 22.04, Java, Apache Tomcat 10 |

---

## 🔐 SSH & Security Setup

- SSH key pair created for secure communication
- Private key stored in Jenkins Credentials (SSH Agent)
- Passwordless SSH enabled between Jenkins and Tomcat server
- Secure deployment using `scp`

---

## 🌍 Application Access

Once deployed successfully, the application can be accessed at:

http://<EC2_PUBLIC_IP>:8080/student-app

---

## 📸 Screenshots Showcase

### 📝 Student Admission Form
![](./Screenshot/Screenshot%202025-12-20%20133208.png)

---

### 🛠️ Jenkins Build Console
![Jenkins Console Output](./Screenshot/Screenshot%202025-12-20%20133406.png)

---

### ☁️ AWS EC2 Instances
![AWS EC2 Instances](./Screenshot/Screenshot%202025-12-20%20133426.png)

---


### 💻 Jenkinsfile in VS Code
![Jenkinsfile VS Code](./Screenshot/Screenshot%202025-12-20%20132848.png)

---
## 🧰 Jenkinsfile (CI/CD Pipeline)

The following **Jenkins Declarative Pipeline** automates the complete build and deployment process of the Student App.

### 📄 Jenkinsfile

```
pipeline {
    agent any

    environment {
        SERVER_IP    = '3.110.158.78'
        SSH_CRED_ID  = 'node-app-key'
        TOMCAT_PATH  = '/var/lib/tomcat10/webapps'
        TOMCAT_SVC   = 'tomcat10'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/avantikakakde/student-app-using-maven.git'
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                        WAR_FILE=\$(ls target/*.war | head -n 1)
                        scp -o StrictHostKeyChecking=no \$WAR_FILE ubuntu@${SERVER_IP}:/tmp/
                        ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} '
                            sudo rm -rf ${TOMCAT_PATH}/*
                            sudo mv /tmp/*.war ${TOMCAT_PATH}/ROOT.war
                            sudo chown tomcat:tomcat ${TOMCAT_PATH}/ROOT.war
                            sudo systemctl restart ${TOMCAT_SVC}
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo "App deployed! Visit: http://${SERVER_IP}:8080/"
        }
        failure {
            echo "Deployment failed."
        }
    }
}




```






---

## 👨‍💻 Author
####  Avantika kakde
💼 DevOps | Cloud | CI/CD |  
🌐 GitHub Profile

---

## 🏁 Conclusion

This project demonstrates a **complete DevOps workflow**, integrating **Git, GitHub, Jenkins, Maven, AWS EC2, and Apache Tomcat** to deliver a real-world **CI/CD implementation**.

💡 The automated pipeline streamlines the deployment lifecycle, improves reliability, and removes manual effort — reflecting **core DevOps principles** in action.

⭐ If you found this project helpful, don’t forget to **star the repository**!