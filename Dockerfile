# Unless explicitly stated otherwise all files in this repository are dual-licensed
# under the Apache 2.0 or BSD3 Licenses.
#
# This product includes software developed at Datadog (https://www.datadoghq.com/)
# Copyright 2022 Datadog, Inc.

# FROM registry.access.redhat.com/ubi8/python-39
# Use the official Python base image
FROM python:3.9-alpine

# Add maintainer label
LABEL maintainer="Min minhwei.ng@datadoghq.com"

# Install bash and curl
RUN apk add --no-cache bash curl

WORKDIR /home

COPY requirements.txt /home
COPY notes_app /home/notes_app

RUN pip install -r requirements.txt

# Runs the application without Datadog
CMD ["python", "-m", "notes_app.app"]
