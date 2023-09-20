#!/bin/bash
. ~/.bashrc
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init --path)"
fi

pyenv versions

pyenv global 3.10.0
python3 -m venv myenv
source myenv/bin/activate
echo '#### Checking python ####'
which python3
python3 -V

echo '#### Installing requirements ####'
pip install -r ./requirements.txt

echo '#### Run tests ####'
pytest APITests --alluredir=./allure_results  --junitxml=./xmlReport/output.xml

echo '### deactivate virtual environment ###'
deactivate
echo '### change pyenv to system ###'
pyenv global system
