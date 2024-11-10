# Virtual Environment Path
VENV_PATH="/home/istywhyerlina/fp_datastorage/PacbookDWH/.venv/bin/activate"

# Activate Virtual Environment
source "$VENV_PATH"

# Set Python script
PYTHON_SCRIPT="/home/istywhyerlina/fp_datastorage/PacbookDWH/transform.py"

# Run Python Script and Insert Log Process
python3 "$PYTHON_SCRIPT" >> /home/istywhyerlina/fp_datastorage/PacbookDWH/log/logs.log 2>&1

# Luigi info simple log
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo "Luigi started at ${dt}" >> /home/istywhyerlina/fp_datastorage/PacbookDWH/log/luigi_info.log

