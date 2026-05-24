#!/bin/bash
echo "=== DÉBUT DE L'IMPORTATION MONGODB ==="

mongoimport --db recrute_mongo --collection offres --file /docker-entrypoint-initdb.d/offres.json --jsonArray
mongoimport --db recrute_mongo --collection candidats --file /docker-entrypoint-initdb.d/candidats.json --jsonArray

echo "=== IMPORTATION MONGODB TERMINÉE ==="