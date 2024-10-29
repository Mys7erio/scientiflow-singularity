FROM python:3.13.0-slim-bookworm

# ARG GIT_TOKEN
# RUN git clone https://$GIT_TOKEN@github.com/your-username/private-repo.git
# RUN unset GIT_TOKEN

RUN apt-get update && \
    apt-get install -y git

COPY scientiflow_agent-0.1.0-py3-none-any.whl /tmp/scientiflow_agent-0.1.0-py3-none-any.whl

RUN pip install /tmp/scientiflow_agent-0.1.0-py3-none-any.whl


ENTRYPOINT ["python3",  "-m",  "scientiflow_agent"]
