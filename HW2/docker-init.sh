echo "Clearing data"
rm -rf ../postgresql-rp/data/*
rm -rf ../postgresql-rp/data-slave/*
docker-compose down

docker-compose up -d primary-db

echo "Starting primary-db node..."
sleep 90  # Waits for master note start complete

echo "Prepare replica config..."
docker exec -it primary-db sh /etc/postgresql/init-script/init.sh
echo "Restart master node"
docker-compose restart primary-db
sleep 90

echo "Starting slave node..."
docker-compose up -d replica-db
sleep 90  # Waits for note start complete

echo "Done"