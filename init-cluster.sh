sleep 5  Additional waiting time

# Checking cluster status
cluster_status=$(mongosh --host mongodb1 --port 27017 -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --eval "rs.status()" --quiet)

# Checking if the cluster already exists
if [[ "$cluster_status" == *"ok"* ]]; then
  echo "Cluster is already initialized."
else
  echo "initializing the cluster..."
  mongosh --host mongodb1 --port 27017 -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" <<EOF
  rs.initiate({
    _id: "cluster",
    members: [
      { _id: 0, host: "mongodb1:27017" },
      { _id: 1, host: "mongodb2:27017" },
      { _id: 2, host: "mongodb3:27017" }
    ]
  })
EOF
fi
