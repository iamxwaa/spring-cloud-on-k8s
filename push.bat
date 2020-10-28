@echo off
mvn clean package docker:build -DpushImage -DskipTests