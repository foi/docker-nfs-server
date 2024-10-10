# docker-nfs-server with default rw access to share
The `nfs-server` image provides a minimal NFSv4 server.

## Usage
Running the container in Docker requires:

1. making the container privileged to allow it to mount the nfsd
   pseudo-filesystem;
2. mounting a volume to `/mnt/data`, the directory that will be exported;
3. exposing the port used for NFSv4 (2049).
4. you should have nfs-utils installed for nfs and nfsd kernel modules

For example:

```
    docker run --privileged -v <host directory or docker volume name>:/mnt/data:rw -v /lib/modules:/lib/modules -p 2049:2049 \
           foifirst/nfs-server:v1.0.0
```

where `<directory>` is the path of the directory you want to serve.

The directory can then be mounted:

```
sudo mount -v -t nfs4 -o proto=tcp,port=2049,rw 127.0.0.1:/ <target>
```

where `<target>` is the mount point.

## Configuration
The following environment variables affect the NFS server:

- `NFS_SERVER_DEBUG`: if set to `0`, disable debug logs for NFS server daemons
  (default: `1`).
- `NFS_SERVER_ALLOWED_CLIENTS`: the network address to allow connections from
    (default: `*`, used by Docker on Linux for all networks).
