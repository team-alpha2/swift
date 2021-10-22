printf "Starting tests..."

cd ../

py swift.py

cd /steps/

# tests go here

py complete_task.feature.py

printf "Tests complete!"