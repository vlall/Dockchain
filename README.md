# Dockchain
Dockchain is a Docker image to store/query the BTC blockchain from a database
The image is on hub.docker.com, just run:

```
$ docker pull vlall/dockchain
$ docker run -pit 5000:5000 vlall/dockchain
$ service postgresql start
$ psql -U postgres blockchain
```
