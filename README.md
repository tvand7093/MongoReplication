# MongoDB Docker Cluster with Arbiter

This is a docker image and compose configuration to build a mongodb replication set
using three nodes: a primary, a secondary, and an arbiter.

# Running the nodes

```bash
docker-compose up 
```

This will build the base image `mongo-replset`, as well as the three nodes as independent images.
It will then startup all the nodes and configure them correctly for their respective services.

# Connecting to the nodes

The following table outlines the port mappings for the nodes as well as their responsibility.

| Node Name | Port | Connection Command |
|:----------|:----:|:-------------------|
| *master* | 3001 | mongo localhost:3001 |
| *secondary* | 3002 | mongo localhost:3002 |
| *arbiter* | 3003 | mongo localhost:3003 |