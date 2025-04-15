# Build Instructions

```bash
# Export environment variables
export BOOST_VERSION="1.88.0"
```

```bash
$ docker build -t libboost-$BOOST_VERSION --build-arg BOOST_VERSION=$BOOST_VERSION  .
```

# Copy built boost libraries and headers
```bash
$ docker run --rm -d --name libboost-$BOOST_VERSION libboost-$BOOST_VERSION sleep 10 && \
docker cp libboost-$BOOST_VERSION:/libboost.tar.gz . && \
docker stop libboost-$BOOST_VERSION 
```