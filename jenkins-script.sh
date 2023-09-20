#!/bin/bash
set -e

# Activate Python environment if already created
if [ -d myenv ]; then
    source myenv/bin/activate
else
    . ~/.bashrc
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init --path)"
    fi

    pyenv global 3.10.0
    python3 -m venv myenv
    source myenv/bin/activate
fi

# Print Python version
echo '#### Checking python ####'
which python3
python3 -V

# Install requirements if not cached
if [ ! -f .requirements_cached ]; then
    echo '#### Installing requirements ####'
    pip install -r ./requirements.txt
    touch .requirements_cached
fi

# Run tests in parallel (adjust the number of workers as needed)
echo '#### Run tests ####'
pytest APITests --alluredir=./allure_results --junitxml=./xmlReport/output.xml -n auto

# Deactivate virtual environment
deactivate

# Change Pyenv to system Python
echo '### Change pyenv to system ###'
pyenv global system
